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

}
