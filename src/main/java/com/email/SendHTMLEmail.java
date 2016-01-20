package com.email;

import com.servise.StandartMasege;
import com.setting.Setting;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created by volkswagen1 on 08.01.2016.
 */
public class SendHTMLEmail
{
    public static void successfulRegistration (String id,String email){
        // Recipient's email ID needs to be mentioned.
        String to;
        if(email.isEmpty()){
        to = Setting.getRecipientEmail();}
        else {
            to=email;
        }
        // Sender's email ID needs to be mentioned
        String from = Setting.getFromEmailAddr();
        // Assuming you are sending email from localhost
        String host = "smtp.gmail.com";
        // Get system properties
        Properties properties = System.getProperties();
        // Setup mail server
        properties.setProperty("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");
        // Get the default Session object.
        Auth auth = new Auth();
        Session session = Session.getDefaultInstance(properties,auth);
        try{
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);
            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));
            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            // Set Subject: header field
            message.setSubject(StandartMasege.getMessage(17));
            // Send the actual HTML message, as big as you like
            // Send message
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
            helper.setText("<a href='http://localhost:8080/ConfirmationOfRegistration?id="+id+"'>"+StandartMasege.getMessage(18)+"</a>", true);
//            Transport transport =session.getTransport("smtp");
            Transport.send(helper.getMimeMessage());
        }
        catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}