package com.modelClass;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.List;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
@Entity
@Table(name = "Cars_brand")
public class CarBrand {
    private String brand;
    @ElementCollection
    private List<String> models;

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public List<String> getModels() {
        return models;
    }

    public void setModels(List<String> models) {
        this.models = models;
    }
}
