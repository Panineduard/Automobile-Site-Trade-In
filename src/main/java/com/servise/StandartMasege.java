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
   public String  getMessage(Integer p){

        String message = messageSource.getMessage(p.toString(), null, "Messages was not found",Locale.getDefault());
        return message;
    }

//    public static void getMessage(Integer p)  {
//
//        String rootPath;
//        if(Setting.isAbsolutePath()){
//            rootPath=Setting.getTheAbsolutePathOfTheMessageFile();
//        }
//        else {
//            String catalinaBase = new File(new File( System.getProperty( "java.class.path" ) ).getParent()).getParent();
//            StringBuffer stringBuffer =new StringBuffer(catalinaBase);
//            int index=stringBuffer.indexOf(";");
//            rootPath=stringBuffer.substring(index + 1)+"\\webapps\\ROOT\\resources\\messages.txt";
//            //        System.out.println(rootPath);
//        }
//        final String[] returnMessage = new String[1];
//        BufferedReader reader = null;
//        try(Stream<String> stream=new BufferedReader(new FileReader(rootPath)).lines()) {
//            stream
//                    .filter(s -> ( new Integer(s.substring(0,2))).equals(p))
//                    .forEach(s1 -> {
//                        returnMessage[0] = new String(s1.substring(3));
//                    });
////            return returnMessage[0];
//        } catch (FileNotFoundException e) {
////            return "The file with messages was not found";
//        }




//    }
}
