package com.setting;

/**
 * Created by Эдуард on 03.01.16.
 */
public final class Setting {
    private Setting(){}
    //her you set Email were get leter from user
    private static String emailTo = "panin.eduard.a@gmail.com";
    private static String fromEmailAddr = "veselayagora1@gmail.com";
    private static  String password ="p1120772";
    private static String username = "veselayagora1@gmail.com";
    private static String ClientsFolder="C:\\ClientsFolder\\";
    private static String RECIPIENT_EMAIL="veselaya_gora@mail.ru";
    private static String THE_ABSOLUTE_PATH_OF_THE_MESSAGE_FILE="D:\\Java\\Java projects\\volkswagenTradeWithoutSecurity\\src\\main\\webapp\\WEB-INF\\pages\\messages.txt";
    private static boolean  IS_ABSOLUTE_PATH=true;
    public static String getClientsFolder() {
        return ClientsFolder;
    }


    public static String getEmailTo() {
        return emailTo;
    }

    public static String getFromEmailAddr() {
        return fromEmailAddr;
    }

    public static String getPassword() {
        return password;
    }

    public static String getUsername() {
        return username;
    }

    public static String getRecipientEmail() {
        return RECIPIENT_EMAIL;
    }


    public static String getTheAbsolutrPathOfTheMessageFile() {
        return THE_ABSOLUTE_PATH_OF_THE_MESSAGE_FILE;
    }

    public static boolean isAbsolutePath() {
        return IS_ABSOLUTE_PATH;
    }
}
