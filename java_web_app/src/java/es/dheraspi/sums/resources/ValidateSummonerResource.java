/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.resources;

import com.robrua.orianna.type.core.summoner.Summoner;
import com.robrua.orianna.type.exception.APIException;
import es.dheraspi.sums.form.FormLogin;
import es.dheraspi.sums.model.DAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author david
 */
@Path("validate")
public class ValidateSummonerResource extends BaseResource
{
    @GET
    @Produces(MediaType.TEXT_HTML)
    public void getHtml() throws ServletException, IOException 
    {
        DAO dao = getDAO();
        HttpServletRequest request = getRequest();
        HttpServletResponse response = getResponse();
        
        String name = request.getParameter("name");
        String region = request.getParameter("region");
        
        FormLogin fl = new FormLogin();
        Map<String, String> errores = new HashMap<>();
        
        fl.setName(name);
        fl.setRegion(region);
        errores = fl.validate();
        
        try
        {
            dao.setRegion(region);
            Summoner summoner = dao.getSummoner(name);
            
            if(errores.isEmpty())
            {
                dao.insertSummoner(summoner, region);
                
                request.setAttribute("name", name.replaceAll("\\s",""));
                request.getSession().setAttribute("region", region);
                request.getSession().setAttribute("summoner", summoner);
                
             // If all is OK then we go to summonerOK
                request.getRequestDispatcher("/summonerOk.jsp").forward(request, response);
            }
        }catch(APIException|ServletException ex)
        {
            if(ex.getClass() == APIException.class)
            {
                errores.put("name", "Summoner not found");
                request.setAttribute("errores", errores);
            }else
            {
                
            }
        }
        
        if (!errores.isEmpty())
        {
            request.setAttribute("old", fl);
            request.setAttribute("errores", errores);
            
         // But if something is not ok we go back to the login page showing the errors
            request.getRequestDispatcher("/login.jsp").forward(request, response);           
        }
    }
    
    @GET
    @Path("{region}/{name}")
    @Produces(MediaType.TEXT_HTML)
    public void getHtml2(@PathParam("region") String region, @PathParam("name") String name) throws ServletException, IOException 
    {
        DAO dao = getDAO();
        HttpServletRequest request = getRequest();
        HttpServletResponse response = getResponse();
        
        FormLogin fl = new FormLogin();
        Map<String, String> errores = new HashMap<>();
        
        fl.setName(name);
        fl.setRegion(region);
        errores = fl.validate();
        
        try
        {
            dao.setRegion(region);
            Summoner summoner = dao.getSummoner(name);
            
            if(errores.isEmpty())
            {
                dao.insertSummoner(summoner, region);
                
                request.setAttribute("name", name.replaceAll("\\s",""));
                request.getSession().setAttribute("region", region);
                request.getSession().setAttribute("summoner", summoner);
                
             // If all is OK then we go to summonerOK
                request.getRequestDispatcher("/summonerOk.jsp").forward(request, response);
            }
        }catch(APIException|ServletException ex)
        {
            if(ex.getClass() == APIException.class)
            {
                errores.put("name", "Summoner not found");
                request.setAttribute("errores", errores);
            }
        }catch(IllegalArgumentException ex)
        {
            errores.put("region", "Wrong region");
            request.setAttribute("errores", errores);
        }
        
        if (!errores.isEmpty())
        {
            request.setAttribute("old", fl);
            request.setAttribute("errores", errores);
            
         // But if something is not ok we go back to the login page showing the errors
            request.getRequestDispatcher("/login.jsp").forward(request, response);           
        }
    }
}
