package com.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by volkswagen1 on 27.12.2015.
 */
@Controller
public class LoginLogautController {

    @RequestMapping(value = "/login")
    public ModelAndView login(HttpServletRequest request){
            ModelAndView modelAndView = new ModelAndView("checkLogin");
            modelAndView.addObject("msg","<h1>Welcome<h1>");
            return modelAndView;
    }

    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request){
            request.getSession().invalidate();
            ModelAndView modelAndView = new ModelAndView("index");
            return modelAndView;
    }
}
