package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.modelClass.Car;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Эдуард on 02.10.15.
 */
public class CarDAO {
    public List<Car> getCarByIdDealer(String idD){
       List <Car> cars = new ArrayList<Car>();
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        try {
            Query query = session.createQuery("from Car car where car.idDealer = :code ");
            query.setParameter("code", idD);
            List list = query.list();
            cars=list;
        }
        catch (NullPointerException n){
            cars=null;
        }
        return cars;
    }
    //This method return -1 if something from data equally 0
    public Long setCar(Car car,List<MultipartFile> multipartFiles){


        //check block fo null and empty
             if(car.getBrand().isEmpty()){
                 System.out.println("марка");
                return -1L;
             };
            if (car.getModel().isEmpty()){
                System.out.println("модель");
                return -1L;
            }
            if (car.getIdDealer().isEmpty()){
                System.out.println("Диллер");
             return -1L;
              }
            if (car.getDescription().isEmpty()){
                System.out.println("Описание");
                return -1L;
            }
            if(car.getEnginesType().isEmpty()){
                System.out.println("Тип ДВС");
                return -1L;
            }
            if(car.getPrise()==0){
                System.out.println("цена");
                return -1L;
            }
            if(car.getTransmission().isEmpty()){
                System.out.println("кпп");
                return -1L;
            }
            if(car.getYearMade()==0){
                System.out.println("Год");
                return -1L;
            }

            //her wi added car in dat base
        Session session= HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=null;
        Long carId=0L;
        try {
            tr= session.beginTransaction();
            //her wi check and looking for last Id Car
            Query query = session.createQuery("select max (idCar) from Car");
            Long maxIdOfCar = (Long)query.list().get(0);
            if(maxIdOfCar==null){
                maxIdOfCar=0L;
            }
            carId=++maxIdOfCar;
            if (carId==0L){
                return -1L;
            }
            car.setIdCar(carId);
            car.setDateProvide(new Date());
            List<String> pathPhoto=new ArrayList<String>();

            if (!multipartFiles.get(0).isEmpty()) {
                int numberPhoto=0;
                for (MultipartFile file:multipartFiles){

                    int pointPosition= file.getOriginalFilename().indexOf('.');
                    String formatFile =file.getOriginalFilename().substring(pointPosition);
                    BufferedOutputStream stream=null;
                    try {
                        File file1 = new File("C:\\ClientsFolder\\"+car.getIdDealer(),carId+"-"+numberPhoto+formatFile);
                        pathPhoto.add(file1.getAbsolutePath());
                        byte[] bytes = file.getBytes();
                        stream =new BufferedOutputStream(new FileOutputStream(file1));
                        stream.write(bytes);
                        numberPhoto++;
                    }
                    catch (FileNotFoundException e){
                        System.out.println("Error");
                        return -1L;
                    }
                    catch (IOException e){
                        e.printStackTrace();
                        return -1L;
                    }
                    finally {
                        try {
                            stream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            car.setPhotoPath(pathPhoto);
            session.merge(car);
            tr.commit();
            new DealerDao().updateCountOfCar(car.getIdDealer());
        }
        catch (Exception e){
            if(tr!=null)tr.rollback();
            return -1L;
        }
        finally {
            if (session.isOpen()){
                session.close();
            }
        }
        return carId ;
    }
//this method found cars for all or one parameters
    public  List<Car> getCarsByParameters(String make,String model,String price_from,String price_to,String year_from,
                                          String year_to,String engine,String gearbox){
        List<Car> carsList;
        Session session =HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String requestDb ="";
        boolean fMake = false,fModel = false,fPrise_from = false,fPrise_to = false,fYear_from = false,fYear_to = false,fEngine = false,fGearbox=false;
        if(!make.isEmpty()){
            fMake=true;
        requestDb=requestDb+" and c.brand=:make";
        }
        if(!model.isEmpty()){
            fModel=true;
            requestDb+= " and c.model=:model";
        }
        if(!price_from.isEmpty()){
            fPrise_from=true;
            requestDb+=" and c.prise>:prise_from";
        }
        if(!price_to.isEmpty()){
            fPrise_to=true;
            requestDb+=" and c.prise<:prise_to";
        }
        if(!engine.isEmpty()){
            fEngine=true;
            requestDb+=" and c.enginesType =:engine ";
        }
        if(!gearbox.isEmpty()){
            fGearbox=true;
            requestDb+=" and c.transmission =:gearbox";

        }
        if(!year_from.isEmpty()){
            fYear_from=true;
            requestDb+=" and  c.yearMade >:year_from";
        }
        if(!year_to.isEmpty()){
            fYear_to=true;
            requestDb+=" and c.yearMade <:year_to ";
        }

        Query query =session.createQuery("from Car  c where c.id>=:id "+requestDb);
        query.setParameter("id",0L);
        if(fMake){
            query.setParameter("make",make);
        }
        if(fModel){
            query.setParameter("model",model);
        }
        if(fPrise_from){
            query.setParameter("prise_from",new Integer(price_from));
        }
        if(fPrise_to){
            query.setParameter("prise_to",new Integer(price_to));
        }
        if(fEngine){
            query.setParameter("engine",engine);
        }
        if(fYear_from){
            query.setParameter("year_from",new Integer(year_from));
        }
        if(fYear_to){
            query.setParameter("year_to",new Integer(year_to));
        }
        if(fGearbox){
            query.setParameter("gearbox", gearbox);
        }
        List list=query.list();
//        session.beginTransaction().commit();
        carsList=list;
        return carsList;
    }
    public List<Car> getLastCars(Integer countLastCar){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query1 = session.createQuery("select max (idCar) from Car ");
        Long maxIdOfCar = (Long)query1.list().get(0);
        Query query = session.createQuery("from Car c where c.idCar>= :maxId ");
        query.setParameter("maxId",maxIdOfCar-countLastCar);
        List<Car> cars = (List<Car>)query.list();

        return cars;
    }
}
