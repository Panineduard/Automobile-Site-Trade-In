package com.modelClass;


import javax.persistence.Embeddable;

/**
 * Created by ������ on 30.08.15.
 */
@Embeddable
public class Address {
    private String  street;
    private String city;
    private String numberHouse;
    private String index;

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getNumberHouse() {
        return numberHouse;
    }

    public void setNumberHouse(String numberHouse) {
        this.numberHouse = numberHouse;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }
}
