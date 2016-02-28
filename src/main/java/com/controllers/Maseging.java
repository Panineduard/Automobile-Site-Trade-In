package com.controllers;

import com.servise.SendHTMLEmail;
import com.servise.StandartMasege;
import com.setting.Setting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Эдуард on 29.11.15.
 */
@Controller
public class Maseging {
    @Autowired
    SendHTMLEmail sendHTMLEmail;
    @Autowired
    StandartMasege standartMasege;
    @RequestMapping(value = "/sendMassage", method = RequestMethod.GET)
    public ModelAndView getRegistrationForm(){
        ModelAndView modelAndView = new ModelAndView("registration");
        return modelAndView;
    }
    @RequestMapping(value = "/sendMessage",method = RequestMethod.POST)
    public ModelAndView saveUserData(@RequestParam("senderName") String senderName,@RequestParam("senderEmail") String senderEmail,@RequestParam("message")
    String message){
       sendHTMLEmail.sendHtmlMessage(Setting.getRecipientEmail(), standartMasege.getMessage(4) + " " + senderName + "\n Email - " + senderEmail + "\n" + message, "Users volkswagen site");
        ModelAndView model1 = new ModelAndView("successfulRegistration");
        model1.addObject("msg",standartMasege.getMessage(5));
        return model1;
}
}
