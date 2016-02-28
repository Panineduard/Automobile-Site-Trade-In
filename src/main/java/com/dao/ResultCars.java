package com.dao;

import com.modelClass.Car;

import java.util.List;

/**
 * Created by volkswagen1 on 26.02.2016.
 */
public class ResultCars {
    private List<Car> cars;
    private int page;
    private Long pages;

    public List<Car> getCars() {
        return cars;
    }

    public void setCars(List<Car> cars) {
        this.cars = cars;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public Long getPages() {
        return pages;
    }

    public void setPages(Long pages) {
        this.pages = pages;
    }
}
