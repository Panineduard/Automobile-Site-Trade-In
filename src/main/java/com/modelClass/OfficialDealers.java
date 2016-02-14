package com.modelClass;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by volkswagen1 on 13.02.2016.
 */
@Entity
@Table(name = "official_dealers")
public class OfficialDealers {
    @Id
    private String numberDealer;
    private String status;
}
