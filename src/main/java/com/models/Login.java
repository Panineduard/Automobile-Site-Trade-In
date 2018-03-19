package com.models;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by ������ on 30.08.15.
 */
@Entity
@Table (name = "Login")
public class Login implements UserDetails {
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

    public String getUsername() {
        return idDealer;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<SimpleGrantedAuthority> result=new ArrayList<SimpleGrantedAuthority>();
        result.add(new SimpleGrantedAuthority(role.name()));

        return result;
    }



    public boolean isAccountNonExpired() {
        return true;
    }

    public boolean isAccountNonLocked() {
        return true;
    }

    public boolean isCredentialsNonExpired() {
        return true;
    }

    public boolean isEnabled() {
        return true;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String toString(){return ""+idDealer;}


}

