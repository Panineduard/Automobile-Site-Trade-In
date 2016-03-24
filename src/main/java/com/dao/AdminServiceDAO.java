package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.modelClass.AuthorizedDealers;
import com.modelClass.CarBrand;
import com.modelClass.Dealer;
import com.modelClass.Region;
import com.servise.StandartMasege;
import org.apache.commons.io.IOUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
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
        String myString = IOUtils.toString(byteArrayInputStream);
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
        String myString = IOUtils.toString(byteArrayInputStream);
        Stream<String> stream = new BufferedReader(new StringReader(myString)).lines();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr = session.beginTransaction();
        {
            stream
                    .forEach(s1 -> {
                       Region region= new Region();
                        region.setName(s1);
                        session.merge(region);

                    });


        }


        tr.commit();
        if (session.isOpen()) {
            session.close();
        }


    }

    public List<AuthorizedDealers> getAuthorizedDealers() {
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query =session.createQuery("from  AuthorizedDealers d ");
        List<AuthorizedDealers> dealers=query.list();
        return dealers;
    }
}
