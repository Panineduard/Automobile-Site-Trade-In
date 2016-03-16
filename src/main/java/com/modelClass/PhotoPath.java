package com.modelClass;

import org.hibernate.annotations.*;
import javax.persistence.CascadeType;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by volkswagen1 on 13.03.2016.
 */
@Entity
@Table(name = "PhotoPath")
public class PhotoPath {
    @Id
    @GeneratedValue
    private Long idPhoto;

    @Column(name = "idcar")
    private Long idCar;
    private String path;

    public PhotoPath() {

    }

    public PhotoPath(Long idCar, String path) {
        this.idCar = idCar;
        this.path = path;

    }


    public Long getIdDealer() {
        return idCar;
    }

    public void setIdDealer(Long idCar) {
        this.idCar = idCar;
    }

    public Long getIdPhoto() {
        return idPhoto;
    }

    public void setIdPhoto(Long idPhoto) {
        this.idPhoto = idPhoto;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
    public String toString(){
        return path;
    }

}
