package com.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Created by volkswagen1 on 25.03.2016.
 */
@Entity
public class Years {
    @Id
    @GeneratedValue()
    private int id;
    private Integer year;

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }
}
