package com.setting;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by volkswagen1 on 18.02.2016.
 */
@XmlRootElement(name="setting")
public class SettingJavax {
    @XmlElement
    private String emailTo;
    @XmlElement
    private String fromEmailAddr ;
    @XmlElement
    private String password;
    @XmlElement
    private String username ;
    @XmlElement
    private String ClientsFolder;
    @XmlElement
    private String RECIPIENT_EMAIL;
    @XmlElement
    private String host;

    public void setHost(String host) {
        this.host = host;
    }

    public void setEmailTo(String emailTo) {
        this.emailTo = emailTo;
    }

    public void setFromEmailAddr(String fromEmailAddr) {
        this.fromEmailAddr = fromEmailAddr;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setClientsFolder(String clientsFolder) {
        ClientsFolder = clientsFolder;
    }

    public void setRECIPIENT_EMAIL(String RECIPIENT_EMAIL) {
        this.RECIPIENT_EMAIL = RECIPIENT_EMAIL;
    }




    public String get_mail_to() {
        return emailTo;
    }

    public String get_from_mail_address() {
        return fromEmailAddr;
    }

    public String get_password() {
        return password;
    }

    public String get_username() {
        return username;
    }

    public String get_clients_folder() {
        return ClientsFolder;
    }

    public String get_RECIPIENT_MAIL() {
        return RECIPIENT_EMAIL;
    }

    public String get_host() {
        return host;
    }
}
