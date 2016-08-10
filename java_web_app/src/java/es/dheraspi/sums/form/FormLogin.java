/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.dheraspi.sums.form;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author david
 */
public class FormLogin 
{
    private String name;
    private String region;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }
    
    public Map<String, String> validate()
    {
       Map<String, String> errores = new HashMap<>();
        
       if ( "".equals( name.trim() ) )
       {
          errores.put("name", "El nombre es obligatorio");
       }
       else if ( name.length() > 16 )
       {
           errores.put("name", "La longitud del nombre no puede exceder los 16 caracteres");
       }
       
       return errores;
    }
}
