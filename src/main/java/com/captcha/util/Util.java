package com.captcha.util;
import java.util.Random;

public class Util {

    public static String generateCaptchaTextMethod1()    {

        Random rdm=new Random();
        int rl=rdm.nextInt(); // Random numbers are generated.
        String hash1 = Integer.toHexString(rl); // Random numbers are converted to Hexa Decimal.

        return hash1;

    }

    public static String generateCaptchaTextMethod2(int captchaLength)   {

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
