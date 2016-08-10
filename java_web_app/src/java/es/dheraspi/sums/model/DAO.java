/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.model;

import com.robrua.orianna.type.core.game.Game;
import com.robrua.orianna.type.core.matchlist.MatchReference;
import com.robrua.orianna.type.core.staticdata.Champion;
import com.robrua.orianna.type.core.summoner.Summoner;
import java.util.List;
import java.util.Map;

/**
 *
 * @author david heras
 */
public interface DAO 
{
    public void init();
    public void insertSummoner(Summoner summoner, String region);
    public Map<String,String> getLanesSumsAnalysis(Summoner summoner);
    public String getLanesChampsSums(Summoner summoner);
    public Champion getFavoriteChampion(Summoner summoner);
    public Summoner getSummoner(String name);
    public void setRegion(String region);
    public List<Game> getRecentGames(Summoner summoner);
    public List<MatchReference> getGames(Summoner summoner, int num);
}
