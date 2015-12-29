package com.modelClass;

import javax.persistence.Embeddable;

/**
 * Created by ������ on 30.08.15.
 */
@Embeddable
public class Address {
    private String  street;
    private String city;
    private long namberhouse;

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

    public long getNamberhouse() {
        return namberhouse;
    }

    public void setNamberhouse(long namberhouse) {
        this.namberhouse = namberhouse;
    }
}
