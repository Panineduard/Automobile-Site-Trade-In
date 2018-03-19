package com.models;

import javax.persistence.*;

/**
 * Created by ������ on 30.08.15.
 */
//@Embeddable
    @Entity
    @Table(name = "ContactPerson")
     public class Contact_person {

    @Id
    @GeneratedValue
    private Long idContactPerson;
    private String idDealer;
    private String name;
    private String phone;
    private String email;

    public String getIdDealer() {
        return idDealer;
    }

    public void setIdDealer(String idDealer) {
        this.idDealer = idDealer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


}
