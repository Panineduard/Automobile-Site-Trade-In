package com.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

/**
 * Created by Эдуард on 05.01.16.
 */
public class SendMail {


    @Autowired
    private JavaMailSender mailSender; // MailSender interface defines a strategy

    @Autowired
    private SimpleMailMessage simpleMailMessage;

    public void crunchifyReadyToSendEmail(String toAddress, String fromAddress, String subject, String msgBody) {

        simpleMailMessage.setTo(toAddress);
        simpleMailMessage.setFrom(fromAddress);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText(msgBody);

            MimeMessage message = mailSender.createMimeMessage();

            try{
                MimeMessageHelper helper = new MimeMessageHelper(message, true);

                helper.setFrom(simpleMailMessage.getFrom());
                helper.setTo(simpleMailMessage.getTo());
                helper.setSubject(simpleMailMessage.getSubject());
                helper.setText(String.format(
                        simpleMailMessage.getText(), true));
                }
            catch (MessagingException e) {
                throw new MailParseException(e);
            }
            mailSender.send(message);

    }
}
