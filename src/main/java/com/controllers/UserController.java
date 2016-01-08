package com.controllers;

import com.dao.DealerDao;
import com.email.CrunchifyEmailAPI;
import com.email.CrunchifyEmailTest;
import com.modelClass.ListRole;
import com.modelClass.Login;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
            CrunchifyEmailTest.sendMessageOnEmail("Подтвердите регистрацию на сайте volkswagen trade in перейдя по этой ссылке \n" +
                    "http://localhost:8080/ConfirmationOfRegistration?id="+nameDealer,email);
        }
        else {
            returnMassege = "Проверте пароль!!!";
        }
        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", "Здравствуйте " + name + " " + returnMassege+"\n вам на почту отправлено письмо с подтверждением регистрации");
        return model;}
        catch (NumberFormatException e){

           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", "Поле 'Номер диллера'! Только цифры!");
           return model1;
        }
    }

@RequestMapping(value = "/ConfirmationOfRegistration", method = RequestMethod.GET)
public  ModelAndView registrationComp(@RequestParam("id") String idDealer){
    DealerDao dealerDao = new DealerDao();
    dealerDao.updateRegistrationAndRoleById(idDealer);
    ModelAndView model = new ModelAndView("successfulRegistration");
    model.addObject("msg", "Вы удачно подтвердили почту с номером диллера - " +idDealer);
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
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }




}
