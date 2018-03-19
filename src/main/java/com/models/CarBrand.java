package com.models;

import javax.persistence.*;
import java.util.List;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
@Entity
@Table(name = "Cars_brand")
public class CarBrand {
    @Id
    private String brand;
    @ElementCollection(fetch=FetchType.EAGER)
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
