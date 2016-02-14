package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.modelClass.CarBrand;
import com.modelClass.Dealer;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
public class AdminServiceDAO {
    public List<Dealer> getAllDealers(){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query =session.createQuery("from  Dealer d ");
        List<Dealer> dealers=query.list();
        return dealers;
    }
    public boolean setModelsByBrand(File models, String brand){
        List <String>modelsName=new ArrayList<>();
        try(Stream<String> stream=new BufferedReader(new FileReader(models)).lines()) {
            stream
                    .forEach(s1 -> {
                        modelsName.add(new String(s1));
                    });
            CarBrand carBrand=new CarBrand();
            carBrand.setBrand(brand);
            carBrand.setModels(modelsName);
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tr=session.beginTransaction();
            session.merge(carBrand);
            tr.commit();
            if(session.isOpen()){
                session.close();
            }
            return true;
        } catch (Exception e) {
            return false;
        }


    }
}
