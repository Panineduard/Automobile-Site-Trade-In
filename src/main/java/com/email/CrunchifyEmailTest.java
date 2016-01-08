package com.email;

import com.email.CrunchifyEmailAPI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * @author Crunchify.com
 */

public class CrunchifyEmailTest {





public  void  sendHttpMassage(String message, String email){

    // Spring Bean file you specified in /src/main/resources folder
    String crunchifyConfFile = "crunchify-bean.xml";
    ConfigurableApplicationContext context = new ClassPathXmlApplicationContext(crunchifyConfFile);
    SendMail sendMail = (SendMail) context.getBean("crunchifyEmail");

    String toAddr = "panin.eduard.a@gmail.com";
    String fromAddr = "veselayagora1@gmail.com";

    if (!toAddr.equals(email)) {
        toAddr = email;
    }
    String subject = " Это сообщение отправлено автоматически. ";
    if (email.equals(toAddr)) {
        // email subject
        subject = "Users our site";
    }

    sendMail.crunchifyReadyToSendEmail(toAddr, fromAddr, subject, message);
}

    public static void sendMessageOnEmail(String message, String email) {

        // Spring Bean file you specified in /src/main/resources folder
        String crunchifyConfFile = "crunchify-bean.xml";
        ConfigurableApplicationContext context = new ClassPathXmlApplicationContext(crunchifyConfFile);

        // @Service("crunchifyEmail") <-- same annotation you specified in CrunchifyEmailAPI.java
        CrunchifyEmailAPI crunchifyEmailAPI = (CrunchifyEmailAPI) context.getBean("crunchifyEmail");
        String toAddr = "panin.eduard.a@gmail.com";

        String fromAddr = "veselayagora1@gmail.com";
        if (!toAddr.equals(email)) {
            toAddr = email;
        }
        String subject = " Это сообщение отправлено автоматически. ";
        if (email.equals(toAddr)) {
            // email subject
            subject = "Users our site";
        }

        // email body
        crunchifyEmailAPI.crunchifyReadyToSendEmail(toAddr, fromAddr, subject, message);
    }
}