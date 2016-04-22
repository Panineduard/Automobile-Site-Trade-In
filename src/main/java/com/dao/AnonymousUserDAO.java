package com.dao;

import com.controllers.Message;
import com.dao.configuration.files.HibernateUtil;
import com.modelClass.Letter;
import com.servise.StandartMasege;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by volkswagen1 on 18.04.2016.
 */
@Repository
public class AnonymousUserDAO {
    @Autowired
    StandartMasege standartMasege;
   public void saveLetter(Letter letter){
      Session session = HibernateUtil.getSessionFactory().getCurrentSession();
       Transaction transaction=session.beginTransaction();
       session.save(letter);
       session.flush();
       transaction.commit();
       if(session.isOpen()){
           session.close();
       }

   }

}
