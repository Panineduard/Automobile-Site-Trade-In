package com.modelClass;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

/**
 * Created by ������ on 30.08.15.
 */
@Entity
@Table (name = "DEALER")
public class Dealer {
    @Id
    private String numberDealer;

    @Embedded
    private Address address;
    private boolean registration;
    private String nameDealer;
    private int countOfCar;
    @Temporal(TemporalType.DATE)
    private Date dateRegistration;
    @OneToMany(cascade = CascadeType.ALL ,fetch=FetchType.EAGER)
    private List<Contact_person> contact_persons=new ArrayList<>();


    public List<Contact_person> getContact_persons() {
        return contact_persons;
    }

    public void setContact_persons(List<Contact_person> contact_persons) {
        this.contact_persons = contact_persons;
    }

    public String getNumberDealer() {
        return numberDealer;
    }

    public void setNumberDealer(String numberDealer) {
        this.numberDealer = numberDealer;
    }

    public String getNameDealer() {
        return nameDealer;
    }

    public void setNameDealer(String nameDealer) {
        this.nameDealer = nameDealer;
    }

    public int getCountOfCar() {
        return countOfCar;
    }

    public void setCountOfCar(int countOfCar) {
        this.countOfCar = countOfCar;
    }

    public boolean isRegistration() {
        return registration;
    }

    public void setRegistration(boolean registration) {
        this.registration = registration;
    }

    public Date getDateRegistration() {
        return dateRegistration;
    }

    public void setDateRegistration(Date dateRegistration) {
        this.dateRegistration = dateRegistration;
    }


    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String toString() {
        return "" + numberDealer;
    }
}
