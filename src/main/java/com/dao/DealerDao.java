package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.email.CrunchifyEmailTest;
import com.helpers.HttpHelper;
import com.helpers.PasswordHelper;
import com.modelClass.Contact_person;
import com.modelClass.Dealer;
import com.modelClass.ListRole;
import com.modelClass.Login;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.mail.MessagingException;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 25.09.15.
 */
public class DealerDao {
    public void updateRegistrationAndRoleById(String idDealer){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        Query query =  session.createQuery("update Dealer d set d.registration =:registration where numberDealer=:id ");
        Query query1=session.createQuery("update  Login l set l.role =:role where l.idDealer =:id");
        query.setParameter("registration", true);
        query.setParameter("id", idDealer);
        query1.setParameter("id", idDealer);
        query1.setParameter("role",ListRole.ROLE_USER);
        query1.executeUpdate();
        query.executeUpdate();
        tr.commit();
    }
public Integer updateCountOfCar(String idDealer){
    Session session= HibernateUtil.getSessionFactory().getCurrentSession();
    Transaction tr=null;

   try {
       tr= session.beginTransaction();
       Query query = session.createQuery("select countOfCar from Dealer where numberDealer = :number ");

    query.setParameter("number", idDealer);

    List countOfCars = query.list();

    Integer countOfCar = (Integer) countOfCars.get(0);
    countOfCar++;

    query = session.createQuery("update Dealer set countOfCar = :countOfCar " +
            " where numberDealer = :numberDealer");
    query.setParameter("countOfCar", countOfCar);
    query.setParameter("numberDealer", idDealer);
    query.executeUpdate();
    tr.commit();
       return countOfCar;
   }
   catch (Exception e){
       if(tr!=null)tr.rollback();
       return -1;
   }
    finally {
       if (session.isOpen()){
       session.close();
       }
   }


}
public String getDealerName(String numberDealer){
        Session session= HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String nameDealer;
        try {
           Query query = session.createQuery("select nameDealer from Dealer dealer where dealer.numberDealer =:numberDealer") ;
            query.setParameter("numberDealer",numberDealer);
            nameDealer=(String)query.uniqueResult();
            return nameDealer;
        }
        catch (NullPointerException p){
            return null;
        }
        finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }
public Dealer getDealerById(String id){
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    session.beginTransaction();
    Dealer dealer= session.get(Dealer.class, id);
    session.close();
    return dealer;

}
public String setDealer(String numberDealer, String nameDealer, String email, String name, String personPhone, String password) {
        if (getDealerName(numberDealer) != null) {
            return "Данный полюзователь уже зарегестрирован";
        }
        if (!nameDealer.isEmpty() || !numberDealer.isEmpty() || !email.isEmpty() || !name.isEmpty() || !password.isEmpty()) {
            Dealer dealer = new Dealer();
            dealer.setNumberDealer(numberDealer);
            dealer.setNameDealer(nameDealer);
            dealer.setRegistration(false);
            List<Contact_person> contact_persons = new ArrayList<Contact_person>();
            Contact_person contact_person = new Contact_person();
            contact_person.setEmail(email);
            contact_person.setName(name);
            contact_person.setPhone(personPhone);
            contact_persons.add(contact_person);
            dealer.setContact_persons(contact_persons);
            PasswordHelper passwordHelper = new PasswordHelper();
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.merge(dealer);
            Login login = new Login();
            login.setIdDealer(dealer.getNumberDealer());
            login.setPassword(passwordHelper.encode(password));
            login.setRole(ListRole.ROLE_ANONYMOUS);
            session.merge(login);
            new File("C:\\ClientsFolder\\"+numberDealer).mkdir();

            session.beginTransaction().commit();
            HttpHelper httpHelper = new HttpHelper();
//
//            try {
////                CrunchifyEmailTest.sendMessageOnEmail(httpHelper.getHttpMessage("Подтвердите регистрацию на сайте volkswagen trade in перейдя по этой ссылке \n" +
////                        "http://localhost:8080/ConfirmationOfRegistration?id=" + nameDealer), email);
//            } catch (MessagingException e) {
//                e.printStackTrace();
//            }
            return "Вы удачно добавили данные";
        }
        return "Проверте поля!";


    }
}
