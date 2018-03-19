package com.service;


import com.dao.configuration.files.HibernateUtil;
import com.models.Login;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    public UserDetails loadUserByUsername(String idDealer) throws UsernameNotFoundException {

        Login login;
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query= session.createQuery("from Login l where l.idDealer=:idDealer");
        query.setParameter("idDealer",idDealer);
        login=(Login)query.uniqueResult();
        session.beginTransaction().commit();
        return login;
    }

}