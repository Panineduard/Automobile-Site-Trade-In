package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.modelClass.Login;
import org.hibernate.Session;

/**
 * Created by Эдуард on 29.09.15.
 */
public class LoginDao {

    public boolean checkLogin(Login login){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Login login1;

        try {
            login1 = session.get(Login.class, login.getIdDealer());
            if (login1.getIdDealer() != null) {
                return true;
            }
            else return false;
        }
        catch (NullPointerException e){
            return false;
        }
    }


}
