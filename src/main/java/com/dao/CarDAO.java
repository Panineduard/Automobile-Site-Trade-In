package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.modelClass.Car;

import com.modelClass.Dealer;
import com.setting.Setting;
import javassist.tools.rmi.ObjectNotFoundException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;

/**
 * Created by Эдуард on 02.10.15.
 */
public class CarDAO {

    private static List<String> setPhotoFiles(Car car,List<MultipartFile> multipartFiles){
        List<String> pathPhoto=new ArrayList<>();
        int numberPhoto=car.getPhotoPath().size();
        for (MultipartFile file:multipartFiles){

            int pointPosition= file.getOriginalFilename().indexOf('.');
            String formatFile =file.getOriginalFilename().substring(pointPosition);
            BufferedOutputStream stream=null;
            try {
                File file1 = new File(Setting.getClientsFolder()+car.getIdDealer(),car.getIdCar()+"-"+numberPhoto+formatFile);
                pathPhoto.add(file1.getAbsolutePath());
                byte[] bytes = file.getBytes();
                stream =new BufferedOutputStream(new FileOutputStream(file1));
                stream.write(bytes);
                numberPhoto++;
            }
            catch (FileNotFoundException e){
                System.out.println("Error");
                return null;
            }
            catch (IOException e){
                e.printStackTrace();
                return null;
            }
            finally {
                try {
                    stream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return pathPhoto;
    }
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

            car.setDateProvide(new Date());
            List<String> pathPhoto=new ArrayList<String>();
            session.save(car);
            session.flush();
            carId=car.getIdCar();
            if (!multipartFiles.get(0).isEmpty()) {
                pathPhoto=setPhotoFiles(car,multipartFiles);
            }
            else pathPhoto.add("null");
            car.setPhotoPath(pathPhoto);
            session.update(car);
            tr.commit();

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
       try {
           Session session = HibernateUtil.getSessionFactory().getCurrentSession();

        session.beginTransaction();
        Query query1 = session.createQuery("select max (idCar) from Car ");
        Long maxIdOfCar = (Long)query1.list().get(0);
        Query query = session.createQuery("from Car c where c.idCar>= :maxId ");
        query.setParameter("maxId",maxIdOfCar-countLastCar);
        List<Car> cars = (List<Car>)query.list();

        return cars;
       }
       catch (Exception e){
          return null;
       }
    }
    public Car getCarById(String id){
        Long idCar =new Long(id);
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Query query = session.createQuery("from Car c where c.idCar=:id");
        query.setParameter("id",idCar);
        Car car =(Car)query.uniqueResult();
        return car;
    }
    public boolean deleteCarById(String idCar){
        Long id =new Long(idCar);
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        try {
            Car car= session.load(Car.class, id);
            for (String path:car.getPhotoPath()) {
                try {
                    File file = new File(path);
                    file.delete();//return true if file deleted
                } catch (Exception e) {
                    continue;
                }
            }
            session.delete(car);
            tr.commit();
            return true;
        }
        catch (org.hibernate.ObjectNotFoundException e){
            return false;
        }
       finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }
    public boolean updateCarById(Car car,List<MultipartFile> multipartFiles){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        List<String> pathPhoto=new ArrayList<String>();
        if (!multipartFiles.get(0).isEmpty()) {
            pathPhoto=setPhotoFiles(car,multipartFiles);
        }
        List<String>photos=car.getPhotoPath();
        pathPhoto.forEach(p->photos.add(p));
        car.setPhotoPath(photos);
        session.update(car);
        tr.commit();
        return true;
    }
    public HashSet<String> getOldCarOwnersEmails(Integer period_in_month){
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.MONTH, -period_in_month);
        Date date =calendar.getTime();
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        Query query = session.createQuery("select idDealer from Car where dateProvide<=:date");
        query.setParameter("date", date);
        List <String> dealersIds=query.list();
        List<Dealer> dealers=new ArrayList<>();
        HashSet<String> emails=new LinkedHashSet<>();
        dealersIds.forEach(n -> dealers.add(session.get(Dealer.class, n)));
        dealers.forEach(n -> emails.add(n.getContact_persons().get(0).getEmail()));
        return emails;
    }
    public  void updateDataProvideDyId(Long id){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        Query query=session.createQuery("update Car set dateProvide=:date where idCar=:id");
        query.setParameter("date",new Date());
        query.setParameter("id",id);
        query.executeUpdate();
        tr.commit();
        if(session.isOpen()){
            session.close();
        }
    }
    public void  deleteCarsByDealersID(String idDealer){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        Query query=session.createQuery("delete from Car where idDealer=:idDealer");
        query.setParameter("idDealer",idDealer);
        query.executeUpdate();
        tr.commit();
        if(session.isOpen()){
            session.close();
        }
    }
}
