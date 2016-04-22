package com.servise;


import com.setting.Setting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

/**
 * Created by volkswagen1 on 08.01.2016.
 */

public class SendHTMLEmail
{
@Autowired
JavaMailSenderImpl mailSender;

    public void setMailSender(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    public void sendHtmlMessage(String email,String text,String subject) {
//        System.out.println(mailSender.getUsername());
//    JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
//    Properties properties=new Properties() ;//= System.getProperties()
        // Setup mail server
//        properties.setProperty("mail.smtp.host", "smtp.gmail.com");
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.port", "587");
//        mailSender.setPassword("p1120772");
//        mailSender.setPort(587);
//        mailSender.setHost("smtp.gmail.com");
//        mailSender.setUsername("veselayagora1@gmail.com");
//        mailSender.setDefaultEncoding("UTF-8");
//        mailSender.setJavaMailProperties(properties);

        MimeMessage message = mailSender.createMimeMessage();


        try{
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(Setting.getFromEmailAddr());
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(text,true);

//            FileSystemResource file = new FileSystemResource("C:\\log.txt");
//            helper.addAttachment(file.getFilename(), file);

        }catch (MessagingException e) {
            throw new MailParseException(e);
        }
        mailSender.send(message);
    }
//    public void sendHtmlMessage (String email,String text,String subject){
//        // Recipient's email ID needs to be mentioned.
//        String to;
//        if(email==null){
//        to = Setting.getRecipientEmail();}
//        else {
//            to=email;
//        }
//        // Sender's email ID needs to be mentioned
//        String from = Setting.getFromEmailAddr();
//        // Assuming you are sending email from localhost
//        String host = "smtp.gmail.com";
//        // Get system properties
//        Properties properties=new Properties() ;//= System.getProperties()
//        // Setup mail server
//        properties.setProperty("mail.smtp.host", host);
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.port", "587");
//        // Get the default Session object
//        Auth auth=new Auth();
//        Session session = Session.getDefaultInstance(properties,auth);
//        try{
//            // Create a default MimeMessage object.
//            MimeMessage message = new MimeMessage(session);
//            // Set From: header field of the header.
//            message.setFrom(new InternetAddress(from));
//            // Set To: header field of the header.
//            message.addRecipient(Letter.RecipientType.TO, new InternetAddress(to));
//            // Set Subject: header field
//            message.setSubject(subject);
//            // Send the actual HTML message, as big as you like
//            // Send message
//            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
//
//                helper.setText(text, true);
//
////            Transport transport =session.getTransport("smtp");
//            Transport.send(helper.getMimeMessage());
//        }
//        catch (MessagingException mex) {
//            mex.printStackTrace();
//        }
//    }
}