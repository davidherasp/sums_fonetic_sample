/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.resources;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author david
 */
@Path("login")
public class LoginResource extends BaseResource
{
    @GET
    @Produces(MediaType.TEXT_HTML)
    public void getHtml() throws ServletException, IOException 
    {
        HttpServletRequest   request = getRequest();
        HttpServletResponse response = getResponse();
        
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
