package com.controllers;

import com.dao.CarDAO;
import com.modelClass.Car;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Эдуард on 29.11.15.
 */

@Controller
public class MainController {
    @RequestMapping("/")
    public ModelAndView printWelcome(HttpServletRequest request) {
        int countOfCars=5;
        CarDAO carDAO = new CarDAO();
        ModelAndView model = new ModelAndView("index1");//this is constructor were is view filrd
        List<Car> cars =carDAO.getLastCars(countOfCars);
        if(cars.isEmpty()){
        }
        if(cars.size()<countOfCars){
            model.addObject("cars",carDAO.getLastCars(cars.size()));
        }
        if (cars.size()==countOfCars){
            model.addObject("cars",carDAO.getLastCars(countOfCars));
        }
//        model.addObject("cars",carDAO.getLastCars(countOfCars));
        return model;
    }
}
