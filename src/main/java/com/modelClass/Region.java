package com.modelClass;

import javax.persistence.*;

/**
 * Created by volkswagen1 on 24.03.2016.
 */
@Entity
@Table(name = "REGION")
public class Region {
    @Id
//    @GeneratedValue()
//    @Column(name = "id")
    private int id;

    private String name;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
