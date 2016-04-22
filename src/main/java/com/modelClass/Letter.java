package com.modelClass;

import org.hibernate.annotations.Type;

import javax.persistence.*;

/**
 * Created by volkswagen1 on 18.04.2016.
 */
@Entity
public class Letter {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String email;

    @Lob
    @Type(type = "org.hibernate.type.TextType")
    private String letter;

    public Letter() {
    }

    public Letter(String email, String massage) {
        this.email = email;
        this.letter = massage;
    }

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMassage() {
        return letter;
    }

    public void setMassage(String massage) {
        this.letter = massage;
    }
}
