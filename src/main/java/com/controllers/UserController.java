package com.controllers;

import com.dao.DealerDao;
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
        }
        else {
            returnMassege = "Проверте пароль!!!";
        }
        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", "Здравствуйте " + name + " " + returnMassege);
        return model;}
       catch (NumberFormatException e){
//           returnMassege="Вы ввели не допустимое поле номер диллера!";
           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", "Поле 'Номер диллера'! Только цифры!");
           return model1;
       }
    }



    @RequestMapping(value = "/myAccount")
    public ModelAndView accountModel(HttpServletRequest request){
            ModelAndView modelAndView = new ModelAndView("myAccount");
            return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/checkLogin")
    public ModelAndView getLoginForm(HttpServletRequest request){
    Login login = (Login)request.getSession().getAttribute("login");
        if(login==null){
        ModelAndView modelAndView = new ModelAndView("checkLogin");
        modelAndView.addObject("msg","<h1>Welcome<h1>");
        return modelAndView;}
        else {
            ModelAndView modelAndView = new ModelAndView("myAccount");
            return ViewHalper.addingDealerAndCarsInView(modelAndView);}
    }

    @RequestMapping(value = "/checkLogin",method = RequestMethod.POST)
    public ModelAndView checkUserData(@RequestParam("user") String user,@RequestParam("password") String password,HttpServletRequest request){
    if(user.isEmpty()||password.isEmpty()){
    ModelAndView model3 = new ModelAndView("checkLogin");
    model3.addObject("msg", "<h2>Пароль или пользователь не верен!</h2>");
    return model3;
}
        else {
        Login login = new Login();

        login.setIdDealer(user);
        login.setPassword(password);
        login.setRole(ListRole.ROLE_USER);
        request.getSession().setAttribute("login", login);
        ModelAndView model = new ModelAndView("myAccount");
       return ViewHalper.addingDealerAndCarsInView(model);
}


    }
}
