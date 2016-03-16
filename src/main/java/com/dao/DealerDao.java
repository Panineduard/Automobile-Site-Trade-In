package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.servise.SendHTMLEmail;
import com.helpers.EncoderId;

import com.helpers.PasswordHelper;
import com.modelClass.*;
import com.servise.StandartMasege;
import com.setting.Setting;
import org.apache.commons.io.FileUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by Эдуард on 25.09.15.
 */
@Repository
public class DealerDao {
    @Autowired
    SendHTMLEmail sendHTMLEmail;
    @Autowired
    StandartMasege standartMasege;
    public KeyHolder getKeyDHolderByKeyAndDeleteKey(String key){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        try {
            Query query =session.createQuery("from KeyHolder where key=:key ");
            query.setParameter("key", key);
            KeyHolder keyHolder = (KeyHolder)query.list().get(0);
            if(keyHolder==null)return null;
            session.delete(keyHolder);
            session.flush();
            tr.commit();
            return keyHolder;
        }
        catch (Exception e){
            if (tr!=null){
                tr.rollback();
            }
            return null;
        }
        finally {
            if(session.isOpen()){session.close();}
        }
    }

    public String getIdDealerByEmail(String email){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
       try {
        Query query =session.createQuery("select idDealer from Contact_person where email=:email ");
        query.setParameter("email", email);
        String result = (String)query.list().get(0);
           tr.commit();
           return result;
       }
       catch (Exception e){
           if (tr!=null){
               tr.rollback();
           }
           return null;
       }
        finally {
           if(session.isOpen()){session.close();}
       }

    }

    public String getDealerName(String numberDealer) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String nameDealer;
        try {
            Query query = session.createQuery("select nameDealer from Dealer dealer where dealer.numberDealer =:numberDealer");
            query.setParameter("numberDealer", numberDealer);
            nameDealer = (String) query.uniqueResult();
            return nameDealer;
        } catch (NullPointerException p) {
            return null;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
    }

    public Dealer getDealerById(String id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction=session.beginTransaction();
        Dealer dealer = session.get(Dealer.class, id);
        transaction.commit();
        if (session.isOpen()) {
            session.close();
        }
        return dealer;

    }

    public List<Dealer> getIdDealersWithoutAuth() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Query query = session.createQuery("from  Dealer d where d.registration=false ");
        List<Dealer> dealers = query.list();
        return dealers;
    }

    public void  setKeyHolder(KeyHolder key){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        try {
            session.merge(key);
            tr.commit();
        }
        catch (Exception e){
            if (tr!=null){
                tr.rollback();
            }
        }
        finally {
            if(session.isOpen()){session.close();}
        }
    }

    public String setDealer(String numberDealer, String nameDealer, String email, String name, String personPhone, String password, String city) {
        if (getDealerName(numberDealer) != null) {
            return standartMasege.getMessage(11);
        }
        if (!nameDealer.isEmpty() || !numberDealer.isEmpty() || !email.isEmpty() || !name.isEmpty() || !password.isEmpty() || !city.isEmpty()) {
            Dealer dealer = new Dealer();
            Address address = new Address();
            dealer.setDateRegistration(new Date());
            dealer.setNumberDealer(numberDealer);
            dealer.setNameDealer(nameDealer);
            dealer.setRegistration(false);
            address.setCity(city);
            address.setIndex("");
            address.setNumberHouse("");
            address.setStreet("");
            dealer.setAddress(address);
            List<Contact_person> contact_persons = new ArrayList<>();
            Contact_person contact_person = new Contact_person();
            contact_person.setIdDealer(numberDealer);
            contact_person.setEmail(email);
            contact_person.setName(name);
            contact_person.setPhone(personPhone);
            contact_persons.add(contact_person);
            dealer.setContact_persons(contact_persons);
            PasswordHelper passwordHelper = new PasswordHelper();
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tr=session.beginTransaction();
            session.merge(dealer);
            Login login = new Login();
            login.setIdDealer(dealer.getNumberDealer());
            login.setPassword(passwordHelper.encode(password));
            login.setRole(ListRole.ROLE_ANONYMOUS);
            session.merge(login);
            new File(Setting.getClientsFolder() + numberDealer).mkdir();
            tr.commit();
            if(session.isOpen()){
                session.close();
            }
            String htmlMessage = "<a href='" + Setting.getHost() + "/ConfirmationOfRegistration?id=" + EncoderId.encodId(numberDealer) + "'>" + standartMasege.getMessage(18) + "</a>";
            sendHTMLEmail.sendHtmlMessage(email, htmlMessage, standartMasege.getMessage(17));
            return standartMasege.getMessage(12) +
                    " \n " + standartMasege.getMessage(13);
        }
        return standartMasege.getMessage(14);


    }

    public boolean changeContactPersonsData(String idDealer, Integer contactPersonsNumber, Contact_person contact_person) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        Dealer dealer = session.get(Dealer.class, idDealer);
        List<Contact_person> contact_persons = dealer.getContact_persons();
        if (contactPersonsNumber == null) {
            contact_persons.add(contact_person);
        } else {
            contact_persons.set(contactPersonsNumber, contact_person);
        }

        dealer.setContact_persons(contact_persons);
        session.merge(dealer);
        tr.commit();
        if (session.isOpen()) {
            session.close();
        }
        return true;
    }

    public boolean changeDealersAddress(String id, String index, String street, String houses_number) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        try {
            Dealer dealer = session.get(Dealer.class, id);
            Address address = dealer.getAddress();
            address.setStreet(street);
            address.setNumberHouse(houses_number);
            address.setIndex(index);
            session.update(dealer);
            tr.commit();
            return true;
        } catch (Exception e) {
            if (tr != null) tr.rollback();
            return false;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
    }

    public boolean changePasswordByIdDealer(String id,String password){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        try {
           Login login= session.get(Login.class, id);
            login.setPassword(password);
            session.update(login);
            session.flush();
            tr.commit();
            return true;
        }
        catch (Exception e){
            if (tr!=null){
                tr.rollback();
            }
            return false;
        }
        finally {
            if(session.isOpen()){session.close();}
        }
    }

    public boolean addLegalsDealer(AuthorizedDealers officialDealers) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        boolean returnValue = false;
        Query query = session.createQuery("from AuthorizedDealers where dealer_number =:id");
        query.setParameter("id", officialDealers.getDealer_number());

        if (query.list().isEmpty()) {
            session.merge(officialDealers);
            returnValue = true;
            tr.commit();
        }

        if (session.isOpen()) {
            session.close();

        }
        return returnValue;
    }

    public boolean updateRegistrationAndRoleById(String id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();

        String idDealer = EncoderId.decodeID(id);
        Transaction tr = session.beginTransaction();
        Query queryCheck = session.createQuery("from Dealer where numberDealer=:idD");
        queryCheck.setParameter("idD", idDealer);
        if (queryCheck.list().isEmpty()) {
            return false;
        } else {
            if (!((Dealer) queryCheck.list().get(0)).isRegistration()) {
                Query query = session.createQuery("update Dealer d set d.registration =:registration where numberDealer=:id ");
                Query query1 = session.createQuery("update  Login l set l.role =:role where l.idDealer =:id");
                query.setParameter("registration", true);

                query.setParameter("id", idDealer);
                query1.setParameter("id", idDealer);
                if (idDealer.equals("administrator")) {
                    query1.setParameter("role", ListRole.ROLE_ADMIN);
                } else {
                    query1.setParameter("role", ListRole.ROLE_USER);
                }
                query1.executeUpdate();
                query.executeUpdate();
                tr.commit();
                return true;
            }
            return false;
        }
    }

    public Integer updateCountOfCar(String idDealer) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = null;

        try {
            tr = session.beginTransaction();
            Query query = session.createQuery("from Car where idDealer=:number");
            query.setParameter("number", idDealer);
            Integer countOfCar = query.list().size();
            query = session.createQuery("update Dealer set countOfCar = :countOfCar " +
                    " where numberDealer = :numberDealer");
            query.setParameter("countOfCar", countOfCar);
            query.setParameter("numberDealer", idDealer);
            query.executeUpdate();
            tr.commit();
            return countOfCar;
        } catch (Exception e) {
            if (tr != null) tr.rollback();
            return -1;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }


    }

    public boolean deleteContactPersonById(String idDealer, int id) {
        if (id == 0) {
            return false;
        }
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        Dealer dealer = session.get(Dealer.class, idDealer);
        List<Contact_person> contact_persons = dealer.getContact_persons();
        contact_persons.remove(id);

        dealer.setContact_persons(contact_persons);
        session.merge(dealer);
        tr.commit();
        return true;
    }

    public boolean deleteLoginAndDealerById(String id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        try {
            session.createQuery("delete Login where idDealer=:id")
                    .setParameter("id", id)
                    .executeUpdate();
            Dealer dealer=(Dealer)session.createQuery("from Dealer where numberDealer=:id")
                    .setParameter("id",id)
                    .list().get(0);
            session.delete(dealer);
            session.flush();

            tr.commit();
            FileUtils.deleteDirectory(new File(Setting.getClientsFolder() + id));
            return true;
        }

        catch (Exception e){
            e.printStackTrace();
            if (tr!=null){
                tr.rollback();
            }
            return false;
        }
        finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }

    public void deleteLegalsDealer(String idDealer) {
        if (idDealer != null) {
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tr = session.beginTransaction();
            Query query = session.createQuery("delete AuthorizedDealers where dealer_number=:idDealer");
            query.setParameter("idDealer", idDealer);
            query.executeUpdate();
            tr.commit();
            if (session.isOpen()) {
                session.close();
            }
        }

    }
}
