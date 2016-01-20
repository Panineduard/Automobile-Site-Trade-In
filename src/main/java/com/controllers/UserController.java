package com.controllers;

import com.dao.CarDAO;
import com.dao.DealerDao;
import com.email.SendEmailText;
import com.modelClass.Car;
import com.servise.StandartMasege;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;

/**
 * Created by Эдуард on 07.11.15.
 */
@Controller
@SessionAttributes("login")

public class UserController {

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public ModelAndView getRegistrationForm(){
        ModelAndView modelAndView = new ModelAndView("registration");
        return modelAndView;
    }
    @RequestMapping(value = "/registration",method = RequestMethod.POST)
    public ModelAndView saveUserData(@RequestParam("pasword") String pasword,@RequestParam("checkPasword") String checkPasword,@RequestParam("numberDealer")
    String numberDealer,@RequestParam("nameDealer") String nameDealer,@RequestParam("email") String email,
                                     @RequestParam("name") String name,@RequestParam("personPhone")String personPhone){

        String returnMassege;
        DealerDao dealerDao = new DealerDao();
       try{ if (pasword.equals(checkPasword)){
            returnMassege= dealerDao.setDealer(numberDealer, nameDealer,email,name,personPhone,pasword);

        }
        else {
            returnMassege = StandartMasege.getMessage(6);
        }
        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", StandartMasege.getMessage(7) +" "+ name + " " + returnMassege);
        return model;}
        catch (NumberFormatException e){

           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", StandartMasege.getMessage(8));
           return model1;
        }
    }

@RequestMapping(value = "/ConfirmationOfRegistration", method = RequestMethod.GET)
public  ModelAndView registrationComp(@RequestParam("id") String idDealer){
    DealerDao dealerDao = new DealerDao();
    String msg;
    ModelAndView model;
    if(dealerDao.updateRegistrationAndRoleById(idDealer))
    {
        model = new ModelAndView("successfulRegistration");
        msg=StandartMasege.getMessage(9);
        model.addObject("msg",msg );
    }
    else {

        model=new ModelAndView("zerroPage");
    }

    return model;
}
    @RequestMapping(value = "/myAccount")
    public ModelAndView accountModel(){
            ModelAndView modelAndView = new ModelAndView("myAccount");
            return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/feedback")
    public ModelAndView getFeedbackForm(){
        ModelAndView modelAndView = new ModelAndView("feedback");
        return modelAndView;
    }

    @RequestMapping(value = "/carPage",method = RequestMethod.GET)
    public ModelAndView getDealer(@RequestParam ("idCar") String idCar){
        ModelAndView modelAndView= new ModelAndView("auto");
        Car car=null;
        CarDAO carDAO =new CarDAO();
        if(!idCar.isEmpty()){
            car=carDAO.getCarById(idCar);
            DealerDao dealerDao=new DealerDao();
            modelAndView.addObject("car", car);
            modelAndView.addObject("dealer",dealerDao.getDealerById(car.getIdDealer()));
        }


        return modelAndView;
    }


}
