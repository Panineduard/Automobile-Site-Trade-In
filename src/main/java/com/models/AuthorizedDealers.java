package com.models;



import javax.persistence.*;


/**
 * Created by volkswagen1 on 17.02.2016.
 */
@Entity
@Table(name="authorized_dealers")
public class AuthorizedDealers {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    private String dealer_number;

    public Long getId() {
        return id;
    }

    public String getDealer_number() {
        return dealer_number;
    }

    public void setDealer_number(String dealer_number) {
        this.dealer_number = dealer_number;
    }
}
