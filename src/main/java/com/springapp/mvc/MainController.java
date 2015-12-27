package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Эдуард on 29.11.15.
 */

@Controller
public class MainController {
    @RequestMapping("/")
    public ModelAndView printWelcome() {
        ModelAndView model = new ModelAndView("index");//this is constructor were is view filrd

        return model;
    }
}
