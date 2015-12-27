package modelClass;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by ������ on 30.08.15.
 */
@Entity
@Table (name = "Login")
public class Login {
    @Id
    @Column(name = "iddeal")
    private Long idDealer;
    @Column(name = "password")
    private String password;

    public Long getIdDealer() {
        return idDealer;
    }

    public void setIdDealer(Long idDealer) {
        this.idDealer = idDealer;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String toString(){return ""+idDealer;}
}

