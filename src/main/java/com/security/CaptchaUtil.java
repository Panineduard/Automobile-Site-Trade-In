package com.security;
import java.util.Random;

public class CaptchaUtil {

    public static String generateCaptchaText(int captchaLength)   {

        String saltChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuffer captchaStrBuffer = new StringBuffer();
        Random rnd = new Random();

        // build a random captchaLength chars salt
        while (captchaStrBuffer.length() < captchaLength)
        {
            int index = (int) (rnd.nextFloat() * saltChars.length());
            captchaStrBuffer.append(saltChars.substring(index, index+1));
        }

        return captchaStrBuffer.toString();

    }

}
