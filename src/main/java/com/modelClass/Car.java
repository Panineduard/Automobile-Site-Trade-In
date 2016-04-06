package com.modelClass;



import org.hibernate.annotations.*;

import javax.persistence.*;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Table;
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
    @GeneratedValue(strategy=GenerationType.TABLE)
    @Column(name = "idcar")
    private Long idCar;


    @OneToMany(cascade = CascadeType.ALL ,fetch=FetchType.EAGER)
    private List<PhotoPath> photoPaths;

//    @ElementCollection(fetch = FetchType.EAGER)
//    private List<String> photoPath = new ArrayList<String>();
    private String brand;
    private String model;
    private Integer yearMade;
    private String transmission;
    private String enginesType;
    private Integer prise;
    private String idDealer;
    private Long views;
    private String mileage;
    private String engineCapacity;
    private String region;
    private String equipment;
    @Temporal (TemporalType.DATE)
    private Date dateProvide;
    @Lob
    private String description;

    public List<PhotoPath> getPhotoPath() {
        return photoPaths;
    }

    public void setPhotoPath(List<PhotoPath> photoPaths) {
        this.photoPaths = photoPaths;
    }
//
//    public List<String> getPhotoPath() {
//        return photoPath;
//    }

//    public void setPhotoPath(List<String> photoPath) {
//        this.photoPath = photoPath;
//    }

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

    public String getMileage() {
        return mileage;
    }

    public void setMileage(String mileage) {
        this.mileage = mileage;
    }

    public String getEngineCapacity() {
        return engineCapacity;
    }

    public void setEngineCapacity(String engineCapacity) {
        this.engineCapacity = engineCapacity;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getEquipment() {
        return equipment;
    }

    public void setEquipment(String equipment) {
        this.equipment = equipment;
    }

    public String toString(){
        return "model"+model +"prise"+ prise +"brand"+brand+"year"+yearMade+"transm"+transmission+"engin"+enginesType;

    }
}
