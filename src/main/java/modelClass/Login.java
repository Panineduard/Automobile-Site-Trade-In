package modelClass;

import javax.persistence.*;

/**
 * Created by ������ on 30.08.15.
 */
@Entity
@Table (name = "Login")
public class Login {
    @Id
    @Column(name = "iddeal")
    private String idDealer;
    @Column(name = "password")
    private String password;
    @Column(name = "role")

    @Enumerated(EnumType.STRING)
    private ListRole role;

    public ListRole getRole() {
        return role;
    }

    public void setRole(ListRole role) {
        this.role = role;
    }

    public String getIdDealer() {
        return idDealer;
    }

    public void setIdDealer(String idDealer) {
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

