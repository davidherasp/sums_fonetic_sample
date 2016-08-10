/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.resources;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author david
 */
@Path("riot.txt")
public class RiotTxtResource extends BaseResource
{    
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public FileInputStream getText() throws FileNotFoundException 
    {
        File file = new File(System.getProperty("user.home") + "/riot.txt");
        return new FileInputStream(file);
    }
}
