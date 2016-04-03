package com.helpers;

import org.postgresql.util.Base64;
import org.springframework.stereotype.Component;

/**
 * Created by volkswagen1 on 09.01.2016.
 */
@Component
public class EncoderId {
   public String encodId(String data){
       return Base64.encodeBytes(data.getBytes());
   }
   public String decodeID(String data){
       return new String(Base64.decode(data));
   }

}
