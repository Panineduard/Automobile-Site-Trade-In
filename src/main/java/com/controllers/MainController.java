package com.controllers;

import com.dao.CarDAO;
import com.modelClass.Car;
import com.servise.StandartMasege;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Эдуард on 29.11.15.
 */

@Controller
public class MainController {
   @Autowired
   CarDAO carDAO;
@Autowired
StandartMasege standartMasege;
    @RequestMapping(value = {"/index","/ "})
    public ModelAndView printWelcome(HttpSession session) {
        System.out.println("hhhhhh");
        List<Car> cars =(List<Car>)session.getAttribute("cars");
        ModelAndView model = new ModelAndView("index");//this is constructor were is view field
        if (cars!=null){
            if (cars.contains(null)){
                cars.remove(null);
                session.setAttribute("cars", cars);
            }

           return model;
        }
        else {
            int countOfCars = 20;
            session.setAttribute("cars", carDAO.getLastCars(countOfCars));


//            if (cars != null && cars.size() < countOfCars) {
//                cars = carDAO.getLastCars(cars.size());
//                if (cars != null) {
//                    Collections.sort(cars, (Car c1, Car c2) -> -c1.getIdCar().compareTo(c2.getIdCar()));
//                }
//                session.setAttribute("cars", cars);
//                return model;
//            }
//            if (cars != null && cars.size() >= countOfCars) {
//
//                cars = carDAO.getLastCars(countOfCars);
//                if (cars != null) {
//                    Collections.sort(cars, (Car c1, Car c2) -> -c1.getIdCar().compareTo(c2.getIdCar()));
//                }
//                session.setAttribute("cars", cars);
//                return model;
//            }

                return model;

        }
    }

    @RequestMapping("/403")
    public ModelAndView getErorPage(){
        ModelAndView modelAndView = new ModelAndView("successfulRegistration");
        modelAndView.addObject("msg", standartMasege.getMessage(19));
        return modelAndView;
    }
}
