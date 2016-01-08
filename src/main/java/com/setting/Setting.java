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
}
