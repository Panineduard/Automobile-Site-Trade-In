package modelClass;

import javax.persistence.Embeddable;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by ������ on 30.08.15.
 */
@Embeddable
public class Contact_person {


    private String name;
    private String phone;
    private String email;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String toString() {
        return "Имя - " + name + "<br> Телефон - " + phone + "<br> Электронная почта - " + email;
    }
}
