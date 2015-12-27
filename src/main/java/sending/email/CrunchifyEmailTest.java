package sending.email;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @author Crunchify.com
 */

public class CrunchifyEmailTest {

    @SuppressWarnings("resource")
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
        String subject = "Это сообщение отправлено автоматически.";
        if (email.equals(toAddr)) {
            // email subject
            subject = "Users our site";
        }

        // email body
        crunchifyEmailAPI.crunchifyReadyToSendEmail(toAddr, fromAddr, subject, message);
    }
}