package com.servise;


import com.dao.configuration.files.HibernateUtil;
import com.modelClass.Login;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    public UserDetails loadUserByUsername(String idDealer) throws UsernameNotFoundException {
        System.out.println(idDealer);
        Login login=new Login();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query= session.createQuery("from Login l where l.idDealer=:idDealer");
        query.setParameter("idDealer",idDealer);
        login=(Login)query.uniqueResult();
        session.beginTransaction().commit();
        System.out.println("Login - "+login.getIdDealer()+"Pssword"+login.getPassword());
        return login;
    }

}