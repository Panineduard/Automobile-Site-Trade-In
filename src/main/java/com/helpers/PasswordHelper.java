package com.helpers;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by volkswagen1 on 17.12.2015.
 */

public class PasswordHelper implements PasswordEncoder {
    private MessageDigest md;
    public PasswordHelper(){
        try {
            md=MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
    public String encode(CharSequence charSequence) {
        if(md==null){
            return charSequence.toString();
        }
        md.update(charSequence.toString().getBytes());
        byte byteData[]=md.digest();
        StringBuffer hexString = new StringBuffer();
        for (int i =0;i<byteData.length;i++){
            String hex = Integer.toHexString(0xff & byteData[i]);
            if(hex.length()==1)hexString.append('0');
            hexString.append(hex);
        }

        return hexString.toString();
    }

    public boolean matches(CharSequence charSequence, String s) {
        return (encode(charSequence)).equals(s);
    }
}