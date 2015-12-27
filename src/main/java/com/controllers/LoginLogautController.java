package com.controllers;

import modelClass.ListRole;
import modelClass.Login;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import servise.ViewHalper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by volkswagen1 on 27.12.2015.
 */
@Controller
public class LoginLogautController {

    @RequestMapping(value = "/login")
    public ModelAndView login(HttpServletRequest request){

        Login login = (Login)request.getSession().getAttribute("login");
        if(login==null){
            ModelAndView modelAndView = new ModelAndView("checkLogin");
            modelAndView.addObject("msg","<h1>Welcome<h1>");
            return modelAndView;}
        else {
            ModelAndView modelAndView = new ModelAndView("myAccount");
            return ViewHalper.addingDealerAndCarsInView(modelAndView,request);}
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
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
            login.setRole(ListRole.USER);
            request.getSession().setAttribute("login", login);
            ModelAndView model = new ModelAndView("myAccount");
            return ViewHalper.addingDealerAndCarsInView(model,request);
        }
    }
    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request){
            request.getSession().invalidate();
            ModelAndView modelAndView = new ModelAndView("index");
            return modelAndView;
    }
}
