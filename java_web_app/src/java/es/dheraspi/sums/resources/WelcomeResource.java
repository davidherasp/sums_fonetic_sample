/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.resources;

import com.robrua.orianna.type.core.common.Region;
import com.robrua.orianna.type.core.summoner.Summoner;
import es.dheraspi.sums.model.DAO;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author david heras
 */
@Path("home")
public class WelcomeResource extends BaseResource
{
    @GET
    @Path("{region}/{name}")
    @Produces(MediaType.TEXT_HTML)
    public void getHtml(@PathParam("region") String region, @PathParam("name") String name)
            throws ServletException, IOException, InterruptedException 
    {
        HttpServletRequest   request = getRequest();
        HttpServletResponse response = getResponse();
        HttpSession session = request.getSession();
        
        Summoner summoner = (Summoner) session.getAttribute("summoner");
        String sessionName = summoner.getName().replaceAll("\\s","");
        String sessionRegion = (String) session.getAttribute("region");
        
     // This means that the user has accesed via URL and not through the login page
        if (summoner == null || !sessionName.equals(name) || !sessionRegion.equals(region))
        {
            request.setAttribute("name", name);
            request.setAttribute("region", region);
            request.getRequestDispatcher("/indirectLogin.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("skinName", getSkinName());
        request.getRequestDispatcher("/welcome.jsp").forward(request, response);
    }
    
    @GET
    @Path("{region}/{name}/lane_champs_sums")
    @Produces(MediaType.TEXT_HTML)
    public void getLaneChampSums(@PathParam("region") String region, @PathParam("name") String name) throws ServletException, IOException
    {
        DAO dao = getDAO();
        HttpServletRequest   request = getRequest();
        HttpServletResponse response = getResponse();
        HttpSession session = request.getSession();
        
        Summoner summoner = (Summoner) session.getAttribute("summoner");
        String sessionName = summoner.getName().replaceAll("\\s","");
        String sessionRegion = (String) session.getAttribute("region");
        
        // This means that the user has accesed via URL and not through the login page
        if (summoner == null || !sessionName.equals(name) || !sessionRegion.equals(region) )
        {
            request.setAttribute("name", name.replaceAll("\\s",""));
            request.setAttribute("region", region);
            request.getRequestDispatcher("/indirectLogin.jsp").forward(request, response);
            return;
        }
        
        String champs = dao.getLanesChampsSums((Summoner) session.getAttribute("summoner"));
        
        request.setAttribute("skinName", getSkinName());
        request.setAttribute("champs", champs);
        request.getRequestDispatcher("/champions.jsp").forward(request, response);
    }
    
    @GET
    @Path("{region}/{name}/lane_sums")
    @Produces(MediaType.TEXT_HTML)
    public void getLaneSums(@PathParam("region") String region, @PathParam("name") String name) throws IOException, InterruptedException, ServletException
    {
        DAO dao = getDAO();
        HttpServletRequest   request = getRequest();
        HttpServletResponse response = getResponse();
        HttpSession session = request.getSession();
        
        Summoner summoner = (Summoner) session.getAttribute("summoner");
        String sessionName = summoner.getName().replaceAll("\\s","");
        String sessionRegion = (String) session.getAttribute("region");
        
        // This means that the user has accesed via URL and not through the login page
        if (summoner == null || !sessionName.equals(name) || !sessionRegion.equals(region) )
        {
            request.setAttribute("name", name.replaceAll("\\s",""));
            request.setAttribute("region", region);
            request.getRequestDispatcher("/indirectLogin.jsp").forward(request, response);
            return;
        }
        
        Map<String, String> data = dao.getLanesSumsAnalysis((Summoner) session.getAttribute("summoner"));
        
        for(Map.Entry<String, String> entry : data.entrySet())
        {
            request.setAttribute(entry.getKey(), entry.getValue());
        }
        
        request.setAttribute("skinName", getSkinName());
        request.getRequestDispatcher("/summoners.jsp").forward(request, response);
    }
}
