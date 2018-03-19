package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;


import java.util.Locale;

/**
 * Created by volkswagen1 on 11.01.2016.
 */
@Component
public class StandartMasege {
    @Autowired
    MessageSource messageSource;//=new ClassPathXmlApplicationContext("spring-app.xml");

    /**
     * @param p it is a number of message
     * @return String it is a messages from Resource Bundle messages by number
     */
    public String getMessage(Integer p) {
        String message = messageSource.getMessage(p.toString(), null, "Messages was not found", Locale.getDefault());
        return message;
    }
}
