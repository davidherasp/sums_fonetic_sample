/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.model;

import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.UpdateOptions;
import com.robrua.orianna.api.core.RiotAPI;
import com.robrua.orianna.type.core.championmastery.ChampionMastery;
import com.robrua.orianna.type.core.common.Region;
import com.robrua.orianna.type.core.game.Game;
import com.robrua.orianna.type.core.matchlist.MatchReference;
import com.robrua.orianna.type.core.staticdata.Champion;
import com.robrua.orianna.type.core.summoner.Summoner;
import com.robrua.orianna.type.exception.APIException;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.Random;
import org.bson.Document;
import org.bson.conversions.Bson;

/**
 *
 * @author david heras
 */
public class DAOMongoDB implements DAO
{
    static String host, dbname, user, password, apikey;
    static MongoDatabase db;
    
    @Override
    public void init() 
    {    
        try 
        {
            Properties mydb = new Properties();
            Properties myapikey = new Properties();
            
            // Localhost
            mydb.load(new FileInputStream("C:\\Users\\david\\Documents\\tomcatcfgs\\mydb.cfg"));
            myapikey.load(new FileInputStream("C:\\Users\\david\\Documents\\tomcatcfgs\\apikey.cfg"));
            
            // Jelastic
//            mydb.load(new FileInputStream(System.getProperty("user.home") + "/mydb.cfg"));
//            myapikey.load(new FileInputStream(System.getProperty("user.home") + "/apikey.cfg"));
 
            host = mydb.getProperty("host");
            dbname = mydb.getProperty("dbname");
            user = mydb.getProperty("user");
            password = mydb.getProperty("password");
            
            apikey = myapikey.getProperty("apikey");
            RiotAPI.setAPIKey(apikey);
        } catch (IOException ex) {}
    }   

    @Override
    public void insertSummoner(Summoner summoner, String region) 
    {
        MongoCredential credential = MongoCredential.createCredential(user, dbname, password.toCharArray());
        try(MongoClient mongoClient = new MongoClient(new ServerAddress(host), Arrays.asList(credential)))
        {
            db = mongoClient.getDatabase(dbname);
            MongoCollection<Document> coll = db.getCollection("summoners");
            
            int profileIconID = summoner.getProfileIconID();
            
            Bson doc = new Document("$set",
                            new Document("_id", summoner.getID()))
                                 .append("name", summoner.getName())
                                 .append("level", summoner.getLevel())
                                 .append("profileIconID", profileIconID < 0 ? 0: profileIconID);
            
            Bson filter = Filters.eq("_id", region);
            switch(region)
            {
                case "EUW":
                    break;
                case "EUNE":
                    break;
                case "NA":
                    break;
                case "LAN":
                    break;
                case "LAS":
                    break;
                case "BR":
                    break;
                case "TR":
                    break;
                case "RU":
                    break;
                case "OCE":
                    break;
                case "KR":
                    break;
                case "JP":
                    break;
            }
            UpdateOptions options = new UpdateOptions().upsert(true);
            
            coll.updateOne(filter, doc, options);
        }catch(APIException ex)
        {
            //Some unknown error when trying to get matchList
        }
    }
    
    @Override
    public Map<String,String> getLanesSumsAnalysis(Summoner summoner) 
    {
        Map<String,String> lanes_data = new HashMap<String,String>();
        MongoCredential credential = MongoCredential.createCredential(user, dbname, password.toCharArray());
        try(MongoClient mongoClient = new MongoClient(new ServerAddress(host), Arrays.asList(credential)))
        {
            db = mongoClient.getDatabase(dbname);
            MongoCollection<Document> coll = db.getCollection("analysis");
            
            Bson query = new Document("_id", Long.toString(summoner.getID()));
            FindIterable<Document> iterable = coll.find(query);
            
            try
            {
                Document bot_doc = (Document) iterable.first().get("bot");
                Document mid_doc = (Document) iterable.first().get("mid");
                Document jun_doc = (Document) iterable.first().get("jun");
                Document top_doc = (Document) iterable.first().get("top");

                Iterator<String> kiter = bot_doc.keySet().iterator();
                Iterator<Object> viter = bot_doc.values().iterator();
                String bot = "";
                try
                {
                    bot = bot + "[{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    for(int i = 0; i < bot_doc.size() - 1; i++)
                    {
                        bot = bot + ",{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    }
                    bot = bot + "]";
                }catch (NoSuchElementException ex){}

                kiter = mid_doc.keySet().iterator();
                viter = mid_doc.values().iterator();
                String mid = "";
                try
                {
                    mid = mid + "[{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    for(int i = 0; i < mid_doc.size() - 1; i++)
                    {
                        mid = mid + ",{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    }
                    mid = mid + "]";
                }catch (NoSuchElementException ex){}


                kiter = jun_doc.keySet().iterator();
                viter = jun_doc.values().iterator();
                String jun = "";
                try{
                    jun = jun + "[{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    for(int i = 0; i < jun_doc.size() - 1; i++)
                    {
                        jun = jun + ",{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    }
                    jun = jun + "]";
                }catch (NoSuchElementException ex){}

                kiter = top_doc.keySet().iterator();
                viter = top_doc.values().iterator();
                String top = "";
                try{
                    top = top + "[{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    for(int i = 0; i < top_doc.size() - 1; i++)
                    {
                        top = top + ",{\"summoners\": \"" + kiter.next() + "\", \"wins\": " + viter.next() + "}";
                    }
                    top = top + "]";
                }catch (NoSuchElementException ex){}

                if(!bot.equals("")) lanes_data.put("bot", bot);
                if(!mid.equals("")) lanes_data.put("mid", mid);
                if(!jun.equals("")) lanes_data.put("jun", jun);
                if(!top.equals("")) lanes_data.put("top", top);
            }catch(NullPointerException ex)
            {
                // No games found
            }
            
            return lanes_data;
        }
    }
    
    @Override
    public String getLanesChampsSums(Summoner summoner) 
    {
        MongoCredential credential = MongoCredential.createCredential(user, dbname, password.toCharArray());
        try(MongoClient mongoClient = new MongoClient(new ServerAddress(host), Arrays.asList(credential)))
        {
            db = mongoClient.getDatabase(dbname);
            MongoCollection<Document> coll = db.getCollection("analysis");
            
            Bson query = new Document("_id", Long.toString(summoner.getID()));
            FindIterable<Document> iterable = coll.find(query);
            
            Document doc = iterable.iterator().next();
            Document result = (Document) doc.get("lane_champ_sums");

            return result.toJson();
        }catch (NoSuchElementException|NullPointerException ex)
        {
            return "empty";
        }
    }
    
    @Override
    public Champion getFavoriteChampion(Summoner summoner) 
    {
        List<ChampionMastery> championMastery = summoner.getChampionMastery();
        
        try
        {
            ChampionMastery get = championMastery.get(0);
            Champion champion = get.getChampion();
            return champion;
        }catch(IndexOutOfBoundsException ex)
        {
            Random rand = new Random();
            
            List<Champion> champions = RiotAPI.getChampions();
            int size = champions.size();
            int randomNum = rand.nextInt(size);
            Champion champion = champions.get(randomNum);
            
            return champion;
        }
    }

    @Override
    public Summoner getSummoner(String name) 
    {
        return RiotAPI.getSummonerByName(name);
    }

    @Override
    public void setRegion(String region) 
    {
        RiotAPI.setRegion(Region.valueOf(region));
    }

    @Override
    public List<Game> getRecentGames(Summoner summoner) 
    {
        return RiotAPI.getRecentGames(summoner);
    }

    @Override
    public List<MatchReference> getGames(Summoner summoner, int num) 
    {
        return summoner.getMatchList(num, 0);
    }
}
