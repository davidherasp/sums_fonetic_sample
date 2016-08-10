/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.listeners;

import es.dheraspi.sums.model.DAO;
import es.dheraspi.sums.model.DAOMongoDB;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author david
 */
public class ApplicationListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) 
    {
        ServletContext sc = sce.getServletContext();        
        DAO dao = new DAOMongoDB();
        dao.init();
        sc.setAttribute("dao", dao);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) 
    {
        
    }
}
