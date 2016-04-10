package com.controllers;

import com.servise.StandartMasege;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by volkswagen1 on 27.12.2015.
 */
@Controller
public class LoginLogOutController {
    @Autowired
    StandartMasege standartMasege;

    @RequestMapping(value = "/login")
    public ModelAndView login(HttpServletRequest request){
            ModelAndView modelAndView = new ModelAndView("checkLogin");
            modelAndView.addObject("msg",standartMasege.getMessage(3));
            return modelAndView;
    }
    @RequestMapping(value = "/login_invalid")
    public ModelAndView loginInvalid(){
        ModelAndView modelAndView = new ModelAndView("checkLogin");
        modelAndView.addObject("msg",standartMasege.getMessage(34));
        return modelAndView;
    }

    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request){
            request.getSession().invalidate();
            ModelAndView modelAndView = new ModelAndView("index");
            return modelAndView;
    }
}
