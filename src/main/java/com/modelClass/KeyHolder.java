package com.modelClass;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

/**
 * Created by volkswagen1 on 15.03.2016.
 */
@Entity
public class KeyHolder {
    @Id
    private String idDealer;
    private String key;
    private String pass;
    @Temporal(TemporalType.DATE)
    private Date dateOfCreation;
    public KeyHolder(){}
    public KeyHolder(String idDealer, String key,String password) {
        dateOfCreation=new Date();
        this.pass=password;
        this.idDealer = idDealer;
        this.key = key;
    }

    public String getPass() {
        return pass;
    }

    public Date getDateOfCreation() {
        return dateOfCreation;
    }

    public void setDateOfCreation(Date dateOfCreation) {
        this.dateOfCreation = dateOfCreation;
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
