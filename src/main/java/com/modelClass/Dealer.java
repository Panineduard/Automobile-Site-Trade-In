package com.modelClass;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ������ on 30.08.15.
 */
@Entity
@Table (name = "DEALER")
public class Dealer {
    @Id
    private String numberDealer;

    private String nameDealer;
    private int countOfCar;
    @ElementCollection
    private List<Contact_person> contact_persons=new ArrayList<Contact_person>();



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

    public String toString() {
        return "" + countOfCar;
    }
}
