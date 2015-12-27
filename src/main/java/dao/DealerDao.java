package dao;

import dao.configuration.files.HibernateUtil;
import modelClass.Contact_person;
import modelClass.Dealer;
import modelClass.Login;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 25.09.15.
 */
public class DealerDao {
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

    query = session.createQuery("update Dealer set countOfCar = :countOfCar" +
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
            List<Contact_person> contact_persons = new ArrayList<Contact_person>();
            Contact_person contact_person = new Contact_person();
            contact_person.setEmail(email);
            contact_person.setName(name);
            contact_person.setPhone(personPhone);
            contact_persons.add(contact_person);
            dealer.setContact_persons(contact_persons);
            Login login = new Login();
            login.setPassword(password);
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.merge(dealer);
            Login login1 = new Login();
            login1.setIdDealer(dealer.getNumberDealer());
            login1.setPassword(login.getPassword());
            session.merge(login1);
            new File("C:\\ClientsFolder\\"+numberDealer).mkdir();


            session.beginTransaction().commit();
            return "Вы удачно добавили данные";
        }
        return "Проверте поля!";


    }
}
