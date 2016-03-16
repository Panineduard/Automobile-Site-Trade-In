package com.modelClass;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by volkswagen1 on 15.03.2016.
 */
@Entity
public class KeyHolder {
    @Id
    private String idDealer;
    private String key;
    private String pass;
    public KeyHolder(){}
    public KeyHolder(String idDealer, String key,String password) {
        this.pass=password;
        this.idDealer = idDealer;
        this.key = key;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getIdDealer() {
        return idDealer;
    }

    public void setIdDealer(String idDealer) {
        this.idDealer = idDealer;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
