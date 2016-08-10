/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.resources;

import com.robrua.orianna.type.core.staticdata.Champion;
import com.robrua.orianna.type.core.summoner.Summoner;
import es.dheraspi.sums.model.DAO;
import java.util.Random;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Context;

/**
 *
 * @author david heras
 */
public abstract class BaseResource 
{
    @Context
    private ServletContext sc;
    
    @Context
    private HttpServletRequest request;
    
    @Context
    private HttpServletResponse response;
    
    protected DAO getDAO()                      { return (DAO) sc.getAttribute("dao"); }
    protected HttpServletRequest getRequest()   { return request;  }
    protected HttpServletResponse getResponse() { return response; }
    
    protected String getSkinName()
    {
        DAO dao = getDAO();
        HttpSession session = request.getSession();
        Summoner summoner = (Summoner) session.getAttribute("summoner");
        Champion favoriteChampion = dao.getFavoriteChampion(summoner);
        
        int size = favoriteChampion.getSkins().size();
        int skinNum = favoriteChampion.getSkins().get(randInt(0,size)).getNum();
        String champName = favoriteChampion.getKey();
        String skinName = champName + "_" + skinNum;
        
        return skinName;
    }
    
    public static int randInt(int min, int max) 
    {
        // NOTE: This will (intentionally) not run as written so that folks
        // copy-pasting have to think about how to initialize their
        // Random instance.  Initialization of the Random instance is outside
        // the main scope of the question, but some decent options are to have
        // a field that is initialized once and then re-used as needed or to
        // use ThreadLocalRandom (if using at least Java 1.7).
        Random rand = new Random();

        // nextInt is normally exclusive of the top value,
        // so add 1 to make it inclusive
        int randomNum = rand.nextInt((max - min) + min);

        return randomNum;
    }
}
