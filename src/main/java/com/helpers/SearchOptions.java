package com.helpers;

/**
 * Created by volkswagen1 on 26.02.2016.
 */
public class SearchOptions {
    private String make;
    private String model;
    private String price_from;
    private String price_to;
    private String year_from;
    private String year_to;
    private String engine;
    private String gearbox;
    private String region ;
    private  int prise=0;
    public SearchOptions(){
        make=model=price_from=price_to=year_to=year_from=engine=gearbox=region="";

    }
    public SearchOptions(String make, String model, String price_from, String price_to, String year_from, String year_to, String engine, String gearbox, String region,int prise) {
        this.make = make;
        this.model = model;
        this.price_from = price_from;
        this.price_to = price_to;
        this.year_from = year_from;
        this.year_to = year_to;
        this.engine = engine;
        this.gearbox = gearbox;
        this.region = region;
        this.prise=prise;
    }

    public String getMake() {
        return make;
    }

    public String getModel() {
        return model;
    }

    public String getPrice_from() {
        return price_from;
    }

    public String getPrice_to() {
        return price_to;
    }

    public String getYear_from() {
        return year_from;
    }

    public String getYear_to() {
        return year_to;
    }

    public String getEngine() {
        return engine;
    }

    public String getGearbox() {
        return gearbox;
    }

    public String getRegion() {
        return region;
    }

    public int getPrise() {
        return prise;
    }

    public void setPrise(int prise) {
        this.prise = prise;
    }
    public String toString(){
        return prise+" "+price_from+" "+price_to+" "+year_from+" "+year_to+" "+engine+" "+gearbox+" "+region;
    }
}
