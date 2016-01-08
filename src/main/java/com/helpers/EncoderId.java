package com.helpers;

import org.postgresql.util.Base64;

/**
 * Created by volkswagen1 on 09.01.2016.
 */
public class EncoderId {
   public static String encodId(String data){
       return Base64.encodeBytes(data.getBytes());
   }
   public static String decodeID(String data){
       return new String(Base64.decode(data));
   }

}
