import sched
import time
import pandas as pd
import threading
import datetime
import logging

from pymongo import MongoClient
from collections import defaultdict
from cassiopeia import riotapi
from cassiopeia.type.core.common import LoadPolicy

logging.basicConfig(filename='update_tfedb_2.log', level=logging.INFO)

riotapi.set_load_policy(LoadPolicy.lazy)


db = client.tfedb

collsums = db.summoners_copy
collgame = db.games
collanal = db.analysis
collcont = db.sums_count
collsubs = db.mailchimp_subscribers
collsend = db.send_emails

s = sched.scheduler(time.time, time.sleep)


def send_email(name, region):
    # Check if the summoner has registered in the mailchimp list
    doc = collsubs.find({'name': str(name), "region": str(region)})
    if doc.count() == 1:
        ts = time.time()
        st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
        try:
            logging.info(st + " - Sending email to " + str(name) + " from " + str(region))
            collsend.insert_one(next(doc))
        except:
            logging.info(st + " - Email address from " + str(name) + " in " + str(region) + " already exists in the database")


def lane_sums(sum_id):
    top = defaultdict(int)
    jun = defaultdict(int)
    mid = defaultdict(int)
    bot = defaultdict(int)

    games = collgame.find({"participants._id":sum_id})

    for doc in games:
        for p in doc['participants']:
            if p['_id'] == str(sum_id) and p['won']:
                sums = p['sum_d'] + "-" + p['sum_f']
                lane = p['lane']
                if lane == 'top':
                    top[sums] += 1
                if lane == 'jungle':
                    jun[sums] += 1
                if lane == 'mid':
                    mid[sums] += 1
                if lane == 'bot':
                    bot[sums] += 1

    lanes = {"top": top, "jun": jun, "mid": mid, "bot": bot}

    key = {"_id": str(sum_id)}
    data = {"$set": lanes}
    collanal.update_one(key, data, upsert=True)


def lane_champ_sums(sum_id):
    top = {}
    jun = {}
    mid = {}
    bot = {}

    games = collgame.find({"participants._id":sum_id})
    for doc in games:
        for p in doc['participants']:
            if p['_id'] == str(sum_id) and p['won']:
                sums = p['sum_d'] + "-" + p['sum_f']
                champ = p['champion'].replace(".", "")
                lane = p['lane']
                if lane == 'top':
                    top.setdefault(champ, defaultdict(int))
                    top[champ][sums] += 1
                if lane == 'jungle':
                    jun.setdefault(champ, defaultdict(int))
                    jun[champ][sums] += 1
                if lane == 'mid':
                    mid.setdefault(champ, defaultdict(int))
                    mid[champ][sums] += 1
                if lane == 'bot':
                    bot.setdefault(champ, defaultdict(int))
                    bot[champ][sums] += 1

    lanes = {"top": top, "jun": jun, "mid": mid, "bot": bot}

    if not top:
        del lanes["top"]
    if not jun:
        del lanes["jun"]
    if not mid:
        del lanes["mid"]
    if not bot:
        del lanes["bot"]

    key = {"_id": str(sum_id)}
    data = {"$set": {"lane_champ_sums": lanes}}
    collanal.update_one(key, data, upsert=True)


def get_lane(lane):
    if str(lane) == "Lane.bot_lane":
        return "bot"
    if str(lane) == "Lane.mid_lane":
        return "mid"
    if str(lane) == "Lane.jungle":
        return "jungle"
    if str(lane) == "Lane.top_lane":
        return "top"


def get_side(side):
    if str(side) == "Side.blue":
        return "blue"
    else:
        return "red"


# Function where we will do all the work needed to insert games in our DB
def insert_games(sum_id, region):
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
    logging.info(st + " - Inserting games for " + str(sum_id) + " from " + str(region))
    try:
        riotapi.set_region(region)
        summoner = riotapi.get_summoner_by_id(sum_id)
        games = summoner.match_list()

        for g in games:
            if not collgame.find({'_id': str(g.id)}).count() > 0:
                try:
                    game = defaultdict(list)
                    match = g.match()
                    game.update({
                        "_id": str(g.id),
                        "date": str(match.creation),
                        "duration": str(match.duration),
                        "platform": str(match.platform),
                        "region": str(match.region),
                        "season": str(match.season),
                        "version": match.version,
                        "participants": []
                    })
                    try:
                        for p in g.match().participants:
                            try:
                                game['participants'].append({
                                    "_id": str(p.summoner_id),
                                    "name": p.summoner_name,
                                    "champion": p.champion.name,
                                    "won": p.stats.win,
                                    "side": get_side(p.side),
                                    "kills": p.stats.kills,
                                    "deaths": p.stats.deaths,
                                    "assists": p.stats.assists,
                                    "kda": p.stats.kda,
                                    "cs": p.stats.cs,
                                    "sum_d": str(p.summoner_spell_d),
                                    "sum_f": str(p.summoner_spell_f),
                                    "champ_lvl": p.stats.champion_level,
                                    "gold_earned": p.stats.gold_earned,
                                    # "items": [item.name if item is not None else None for item in p.stats.items],
                                    "m_dmg_dealt": p.stats.magic_damage_dealt,
                                    "p_dmg_dealt": p.stats.physical_damage_dealt,
                                    "dmg_2_champs": p.stats.damage_dealt_to_champions,
                                    "lane": get_lane(p.timeline.lane)
                                })
                            except:
                                ts = time.time()
                                st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
                                logging.warning(st + " - APIError exception found while adding a participant for " + str(sum_id) + " in " + str(region))
                    except:
                        ts = time.time()
                        st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
                        logging.warning(st + " - APIError exception found while loading participants for " + str(sum_id) + " in " + str(region))

                    key = {"_id": str(g.id)}
                    data = {"$set": game}
                    collgame.update_one(key, data, upsert=True)
                except:
                    ts = time.time()
                    st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
                    logging.warning(st + " - APIError exception found while loading game for " + str(sum_id) + " in " + str(region))
    except:
        ts = time.time()
        st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
        logging.error(st + " - APIError exception found while setting Region (Cassiopeia), getting summoner or getting " \
                   "match_list. Most likely it's match_list for " + str(sum_id) + " in " + str(region))

    # Updating games count value
    games_count = collgame.find({"participants._id": str(sum_id)}).count()
    collsums.update({"_id": int(sum_id)}, {"$set": {"games_count": games_count}})

    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
    logging.info(st + " - Analysing lane champion summoners wins for " + str(sum_id) + " in " + str(region))
    lane_sums(str(sum_id))

    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
    logging.info(st + " - Analysing lane summoners wins for " + str(sum_id) + " in " + str(region))
    lane_champ_sums(str(sum_id))

    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
    logging.info(st + " - Games inserted for " + str(sum_id) + " in " + str(region))

    # we will now send an email confirming the data is already collected if the person has subscribed to the list
    summoner = riotapi.get_summoner_by_id(sum_id)
    send_email(summoner.name, region)


def check_updates(sc, count_old):
    df = pd.DataFrame(list(collsums.find()))
    id_reg = df[['_id', 'region']]

    d = pd.DataFrame.to_dict(id_reg)
    lid = d['_id'].values()
    lreg = d['region'].values()

    count_new = collsums.count()
    if count_old < count_new:
        ts = time.time()
        st = datetime.datetime.fromtimestamp(ts).strftime('%d-%m-%Y %H:%M:%S')
        logging.info(st + " - " + str(count_new - count_old) + " new ID found")
        # collcont.update_one({"_id": "id"}, {"$set": {"count": count_new}})
        new_ids = lid[count_old:]
        new_regs = lreg[count_old:]
        threads = []

        # Start downloading data for the new ids
        for sum_id, reg in zip(new_ids, new_regs):
            t = threading.Thread(target=insert_games, args=(sum_id, reg))
            threads.append(t)
            t.start()
            # insert_games(id, reg)

        collcont.update_one({"_id": "id"}, {"$set": {"count": count_new}})

    sc.enter(10, 1, check_updates, (sc, count_new))


# getting actual count in case script stopped running
doc = collcont.find_one({"_id": "id"})
count = doc['count']

s.enter(1, 1, check_updates, (s, count))
s.run()
