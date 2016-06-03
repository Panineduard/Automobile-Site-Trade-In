package com.setting;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import java.io.File;

/**
 * Created by Эдуард on 03.01.16.
 */
public class Setting {
    private Setting(){}
    private String path =this.getClass().getClassLoader().getResource("seting.xml").getPath();
    private static SettingJavax settingJavax = null;
    static {
        File file = new File(new Setting().path);
        JAXBContext jaxbContext = null;

        Unmarshaller jaxbUnmarshaller = null;
        try {
            jaxbContext = JAXBContext.newInstance(SettingJavax.class);
            jaxbUnmarshaller = jaxbContext.createUnmarshaller();
            settingJavax = (SettingJavax) jaxbUnmarshaller.unmarshal(file);
        } catch (JAXBException e) {
            e.printStackTrace();
        }
    }
    public static String getEmailTo() {
        return settingJavax.get_mail_to();
    }

    public static String getFromEmailAddr() {
        return settingJavax.get_from_mail_address();
    }

    public static String getPassword() {
        return settingJavax.get_password();
    }

    public static String getUsername() {
        return settingJavax.get_username();
    }
    public static String getPath(){return settingJavax.get_path();}
    public static String getClientsFolder() {
        File folder = new File(settingJavax.get_clients_folder());
        if(!folder.exists()) {
            folder.mkdirs();
        }
        return settingJavax.get_clients_folder();
    }

    public static String getRecipientEmail() {
        return settingJavax.get_RECIPIENT_MAIL();
    }
    public static  String getHost(){return settingJavax.get_host();}
    public static Integer get_IMG_WIDTH(){return settingJavax.get_IMG_WIDTH();}
    public static Integer get_IMG_HEIGHT(){return settingJavax.get_IMG_HEIGHT();}
    public static  String getProjectName(){return settingJavax.get_project_name();}


}
