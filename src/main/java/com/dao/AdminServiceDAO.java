package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.models.*;
import com.service.StandartMasege;
import org.apache.commons.io.IOUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
@Repository
public class AdminServiceDAO {
    @Autowired
    StandartMasege standartMasege;

    public List<Dealer> getAllDealers(){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query =session.createQuery("from  Dealer d ");
        List<Dealer> dealers=query.list();
        return dealers;
    }
    public void setModelsByBrand(MultipartFile models, String brand) throws IOException {
        List<String> modelsName = new ArrayList<>();
        CarBrand carBrand = new CarBrand();
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(models.getBytes());
        String myString = IOUtils.toString(byteArrayInputStream, "Windows-1251");
        Stream<String> stream = new BufferedReader(new StringReader(myString)).lines();
        modelsName.add(standartMasege.getMessage(29));
        {
            stream
                    .forEach(s1 -> {
                        modelsName.add(new String(s1));
                    });

            carBrand.setBrand(brand);
            carBrand.setModels(modelsName);
        }

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        session.merge(carBrand);
        tr.commit();
        if (session.isOpen()) {
            session.close();
        }


    }
    public void setRegions(MultipartFile regions) throws IOException {

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(regions.getBytes());
        String myString = IOUtils.toString(byteArrayInputStream, "Windows-1251");
        Stream<String> stream = new BufferedReader(new StringReader(myString)).lines();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        Query query = session.createQuery("delete from Region ");
        query.executeUpdate();
        final int[] id = {1};

            stream
                    .forEach(s1 -> {
                        Region region = new Region();
                        region.setName(s1);
                        region.setId(id[0]);
                        id[0]++;


                        session.merge(region);

                    });
        tr.commit();
        if (session.isOpen()) {
            session.close();
        }
    }

    public void setBrands(MultipartFile multipartFile) throws IOException{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        ByteArrayInputStream byteArrayInputStream = null;
        byteArrayInputStream = new ByteArrayInputStream(multipartFile.getBytes());
        String myString = null;
        myString = IOUtils.toString(byteArrayInputStream, "Windows-1251");
        Stream<String> stream = new BufferedReader(new StringReader(myString)).lines();
        Transaction tr = session.beginTransaction();
        Query query = session.createQuery("delete from Brand ");
        query.executeUpdate();
        final int[] id = {1};
        stream
                .forEach(s1 -> {
                    Brand brand = new Brand();
                    brand.setBrand(s1);
                    brand.setId(id[0]);
                    session.merge(brand);
                    id[0]++;
                });
        tr.commit();

        if (session.isOpen()) {
            session.close();
        }
    }
    public void setYears(MultipartFile regions) throws IOException {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();

           ByteArrayInputStream byteArrayInputStream = null;

               byteArrayInputStream = new ByteArrayInputStream(regions.getBytes());
           String myString = null;
               myString = IOUtils.toString(byteArrayInputStream);
           Stream<String> stream = new BufferedReader(new StringReader(myString)).lines();

        Transaction tr = session.beginTransaction();
        Query query = session.createQuery("delete from Years ");
        query.executeUpdate();
        stream
                .forEach(s1 -> {
                    Years years = new Years();
                    years.setYear(new Integer(s1));
                    session.merge(years);
                });
        tr.commit();

           if (session.isOpen()) {
               session.close();
           }
    }
    public List<Region> getRegions()  {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        Query query = session.createQuery("from Region ");
        List<Region> regions=query.list();
        tr.commit();
        if (session.isOpen()) {
            session.close();
        }

      return regions;
    }
    public List<AuthorizedDealers> getAuthorizedDealers() {
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query =session.createQuery("from  AuthorizedDealers d ");
        List<AuthorizedDealers> dealers=query.list();
        return dealers;
    }
    public boolean deleteLetter(String id,String all){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction=session.beginTransaction();
        try {
            if(all!=null&&all.equals("all")){
                session.createQuery("delete from Letter ")
                        .executeUpdate();
                transaction.commit();
            }
            else {
                Long idb;
                if(id!=null&&!id.isEmpty()){
                    idb=new Long(id);


                session.createQuery("delete from Letter where id=:id")
                        .setParameter("id",idb)
                        .executeUpdate();
                    transaction.commit();
                }
            }




            return true;
        }
        catch (Exception e){
            return false; }
        finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }

    public List<Letter> getMessages() {
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        List<Letter> result= session.createQuery("from Letter ").list();
        if(session.isOpen()){
            session.close();
        }
        return result;
    }


}
