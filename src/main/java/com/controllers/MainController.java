package com.controllers;

import com.dao.CarDAO;
import com.modelClass.Car;
import com.servise.StandartMasege;
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
        int countOfCars=4;
        CarDAO carDAO = new CarDAO();
        List<Car> cars=null;
        ModelAndView model = new ModelAndView("index");//this is constructor were is view filrd
        if(carDAO.getLastCars(countOfCars)!=null){
             cars=carDAO.getLastCars(countOfCars);
        }


        if(cars!=null&&cars.size()<countOfCars){
            model.addObject("cars",carDAO.getLastCars(cars.size()));
            return model;
        }
        if (cars!=null&&cars.size()>=countOfCars){
            model.addObject("cars",carDAO.getLastCars(countOfCars));
            return model;
        }
//        model.addObject("cars",carDAO.getLastCars(countOfCars));
        else {return model;}
    }

    @RequestMapping("/403")
    public ModelAndView getErorPage(){
        ModelAndView modelAndView = new ModelAndView("successfulRegistration");
        modelAndView.addObject("msg", StandartMasege.getMessage(19));
        return modelAndView;
    }
}
