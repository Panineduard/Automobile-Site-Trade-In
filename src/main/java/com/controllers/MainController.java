package com.controllers;

import com.dao.CarDAO;
import com.helpers.ResultCars;
import com.helpers.SearchOptions;
import com.models.Car;
import com.service.StandartMasege;
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
//            session.setAttribute("cars", carDAO.getLastCars(countOfCars));
            SearchOptions options=new SearchOptions();
            ResultCars result= carDAO.getCarsByParameters(options, 1);
            session.setAttribute("options",options);
            session.setAttribute("cars",result.getCars());
            session.setAttribute("page",  result.getPage());
            session.setAttribute("cars",  result.getCars());
            session.setAttribute("pages", result.getPages());
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
