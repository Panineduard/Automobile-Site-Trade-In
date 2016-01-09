package com.modelClass;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * Created by ������ on 10.09.15.
 */
@Entity
@Table (name = "CARS")
public class Car {
    @Id
//    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long idCar;
    @ElementCollection
    private List<String> photoPath = new ArrayList<String>();
    private String brand;
    private String model;
    private Integer yearMade;
    private String transmission;
    private String enginesType;
    private Integer prise;
    private String idDealer;
    private Long views;
    private Integer mileage;
    private String engineCapacity;
    @Temporal (TemporalType.DATE)
    private Date dateProvide;
    @Lob
    private String description;

    public List<String> getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(List<String> photoPath) {
        this.photoPath = photoPath;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getIdCar() {
        return idCar;
    }

    public void setIdCar(Long idCar) {
        this.idCar = idCar;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public Date getDateProvide() {
        return dateProvide;
    }

    public void setDateProvide(Date dateProvide) {
        this.dateProvide = dateProvide;
    }

    public String getIdDealer() {
        return idDealer;
    }

    public void setIdDealer(String idDealer) {
        this.idDealer = idDealer;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public Integer getPrise() {
        return prise;
    }

    public void setPrise(Integer prise) {
        this.prise = prise;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getYearMade() {
        return yearMade;
    }

    public void setYearMade(Integer yearMade) {
        this.yearMade = yearMade;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getEnginesType() {
        return enginesType;
    }

    public void setEnginesType(String enginesType) {
        this.enginesType = enginesType;
    }

    public Integer getMileage() {
        return mileage;
    }

    public void setMileage(Integer mileage) {
        this.mileage = mileage;
    }

    public String getEngineCapacity() {
        return engineCapacity;
    }

    public void setEngineCapacity(String engineCapacity) {
        this.engineCapacity = engineCapacity;
    }

    public String toString(){
        return "model"+model +"prise"+ prise +"brand"+brand+"year"+yearMade+"transm"+transmission+"engin"+enginesType;

    }
}
