package com.email;

import com.email.CrunchifyEmailAPI;
import com.setting.Setting;
import org.hibernate.mapping.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * @author Crunchify.com
 */

public class SendEmailText {


    public static void sendMessageOnEmail(String message, String email) {

        // Spring Bean file you specified in /src/main/resources folder
        String crunchifyConfFile = "crunchify-bean.xml";
        ConfigurableApplicationContext context = new ClassPathXmlApplicationContext(crunchifyConfFile);

        // @Service("crunchifyEmail") <-- same annotation you specified in CrunchifyEmailAPI.java
        CrunchifyEmailAPI crunchifyEmailAPI = (CrunchifyEmailAPI) context.getBean("crunchifyEmail");
        String toAddr = Setting.getEmailTo();

        String fromAddr = Setting.getFromEmailAddr();
        if (!toAddr.equals(email)) {
            toAddr = email;
        }
        String subject = " Это сообщение отправлено автоматически. ";
        if (email.equals(toAddr)) {
            // email subject
            subject = "Письмо от пользователя сайта";
        }

        // email body
        crunchifyEmailAPI.crunchifyReadyToSendEmail(toAddr, fromAddr, subject, message);
    }
}