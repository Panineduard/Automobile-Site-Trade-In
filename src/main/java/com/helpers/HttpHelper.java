package com.helpers;

import org.springframework.mail.MailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

/**
 * Created by Эдуард on 05.01.16.
 */
public class HttpHelper {
    private JavaMailSender mailSender;
    public  MimeMessageHelper getHttpMessage(String message) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
        String htmlMsg = message;
//        helper.setFrom();
//        helper.setTo();
        helper.setText(htmlMsg, true);
        return helper;
    }
}
