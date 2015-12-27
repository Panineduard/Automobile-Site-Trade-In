package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class HelloController {
    static public void main(String[] args) {
    }

    @RequestMapping("/hello/{userName}")
    public ModelAndView printWelcome(@PathVariable("userName") String name) {
        ModelAndView model = new ModelAndView("hello");//this is constructor were is view filrd
        model.addObject("message", "Hello from controller!" + name);
        return model;
    }
}