package com.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.email.SendEmailText;

/**
 * Created by Эдуард on 29.11.15.
 */
@Controller
public class Maseging {
    @RequestMapping(value = "/sendMassage", method = RequestMethod.GET)
    public ModelAndView getRegistrationForm(){
        ModelAndView modelAndView = new ModelAndView("registration");
        return modelAndView;
    }
    @RequestMapping(value = "/sendMessage",method = RequestMethod.POST)
    public ModelAndView saveUserData(@RequestParam("senderName") String senderName,@RequestParam("senderEmail") String senderEmail,@RequestParam("message")
    String message){
        SendEmailText.sendMessageOnEmail("Письмо от " + senderName + "\n Email - " + senderEmail + "\n" + message, "veselaya_gora@mail.ru");
        ModelAndView model1 = new ModelAndView("successfulRegistration");
        model1.addObject("msg","Спасибо за отзыв,коментарии, или пожелания!");
        return model1;
}
}
