package com.servise;

import com.setting.Setting;
import com.sun.java.util.jar.pack.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;


import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.Buffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.function.BiPredicate;
import java.util.stream.Stream;

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
