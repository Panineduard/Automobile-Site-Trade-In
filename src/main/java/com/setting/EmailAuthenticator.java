package com.setting;


import com.setting.Setting;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * Created by volkswagen1 on 08.01.2016.
 */
public class EmailAuthenticator extends Authenticator {
    public EmailAuthenticator(){
        super();
    }
    public PasswordAuthentication getPasswordAuthentication(){
        String username = Setting.getUsername();
        String password = Setting.getPassword();
        if ((username != null) && (username.length() > 0) && (password != null)
                && (password.length   () > 0)) {
            return new PasswordAuthentication(username, password);
        }
        return null;
    }
}
