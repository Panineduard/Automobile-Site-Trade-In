package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.helpers.SearchOptions;
import com.modelClass.Car;

import com.modelClass.CarBrand;
import com.modelClass.Dealer;
import com.servise.ChangeImgSize;
import com.servise.StandartMasege;
import com.setting.Setting;
import javassist.tools.rmi.ObjectNotFoundException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

/**
 * Created by Эдуард on 02.10.15.
 */
@Repository
public class CarDAO {
@Autowired
StandartMasege standartMasege;
@Autowired
ChangeImgSize changeImgSize;

    private List<String> setPhotoFiles(Car car,List<MultipartFile> multipartFiles){
        List<String> pathPhoto=new ArrayList<>();
        int numberPhoto=car.getPhotoPath().size();
        for (MultipartFile file:multipartFiles){

            int pointPosition= file.getOriginalFilename().indexOf('.');
            String formatFile =file.getOriginalFilename().substring(pointPosition);
            BufferedOutputStream stream=null;

            try {
                File convFile = new File( file.getOriginalFilename());
                file.transferTo(convFile);
                BufferedImage bufferedImage =  ImageIO.read(convFile);
                bufferedImage=changeImgSize.resizeImage(bufferedImage,Setting.get_IMG_WIDTH(),Setting.get_IMG_HEIGHT());
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bufferedImage,"jpg",baos);
                baos.flush();


                File file1 = new File(Setting.getClientsFolder()+car.getIdDealer(),car.getIdCar()+"-"+numberPhoto+formatFile);
                pathPhoto.add(file1.getAbsolutePath());
                byte[] bytes = baos.toByteArray();
                baos.close();
                stream =new BufferedOutputStream(new FileOutputStream(file1));
                stream.write(bytes);
                numberPhoto++;
            }
            catch (FileNotFoundException e){
                System.out.println("Error from setPhotoFiles CarDao");
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
//this method found cars for all or one parameters if prise 1 it is ascending_price if prise 2 by_prices_descending 0 nothing
    public  ResultCars getCarsByParameters(SearchOptions options, int page){
        //String make,String model,String price_from,String price_to,String year_from,String year_to,String engine,String gearbox,String region,
        List<Car> carsList;
        Session session =HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        String requestDb ="";
        boolean fMake = false,fModel = false,fPrise_from = false,fPrise_to = false,fYear_from = false,fYear_to = false,
                fRegion=false, fEngine = false,fGearbox=false;
        String priseQuery=" ";
        if(options.getPrise()==1){
                priseQuery="ORDER BY c.prise ";
        }
        if (options.getPrise()==2){
            priseQuery="ORDER BY c.prise DESC";
        }
        if(!options.getRegion().isEmpty()){
            fRegion=true;
            requestDb=requestDb+"and c.region=:region";
        }
        if(!options.getMake().isEmpty()){
            fMake=true;
        requestDb=requestDb+" and c.brand=:make";
        }
        if(!options.getModel().isEmpty()){
            fModel=true;
            requestDb+= " and c.model=:model";
        }
        if(!options.getPrice_from().isEmpty()){
            fPrise_from=true;
            requestDb+=" and c.prise>:prise_from";
        }
        if(!options.getPrice_to().isEmpty()){
            fPrise_to=true;
            requestDb+=" and c.prise<:prise_to";
        }
        if(!options.getEngine().isEmpty()){
            fEngine=true;
            requestDb+=" and c.enginesType =:engine ";
        }
        if(!options.getGearbox().isEmpty()){
            fGearbox=true;
            requestDb+=" and c.transmission =:gearbox";

        }
        if(!options.getYear_from().isEmpty()){
            fYear_from=true;
            requestDb+=" and  c.yearMade >:year_from";
        }
        if(!options.getYear_to().isEmpty()){
            fYear_to=true;
            requestDb+=" and c.yearMade <:year_to ";
        }
        Query query1=session.createQuery("select count(*)from Car c where c.id>=:id "+requestDb);
//Query query=session.createQuery("from Car where rownum between '10' ");
        Query query =session.createQuery("from Car  c where c.id>=:id "+requestDb+priseQuery).setFirstResult(page-1).setMaxResults(page+9);

        query.setParameter("id",0L);
        query1.setParameter("id",0L);
        if(fMake){
            query.setParameter("make",options.getMake());
            query1.setParameter("make",options.getMake());
        }
        if(fModel){
            query.setParameter("model",options.getModel());
            query1.setParameter("model",options.getModel());

        }
        if(fPrise_from){
            query.setParameter("prise_from",new Integer(options.getPrice_from()));
            query1.setParameter("prise_from",new Integer(options.getPrice_from()));
        }
        if(fPrise_to){
            query.setParameter("prise_to",new Integer(options.getPrice_to()));
            query1.setParameter("prise_to",new Integer(options.getPrice_to()));
        }
        if(fEngine){
            query.setParameter("engine",options.getEngine());
            query1.setParameter("engine",options.getEngine());
        }
        if(fYear_from){
            query.setParameter("year_from",new Integer(options.getYear_from()));
            query1.setParameter("year_from",new Integer(options.getYear_from()));
        }
        if(fYear_to){
            query.setParameter("year_to",new Integer(options.getYear_to()));
            query1.setParameter("year_to",new Integer(options.getYear_to()));
        }
        if(fGearbox){
            query.setParameter("gearbox", options.getGearbox());
            query1.setParameter("gearbox", options.getGearbox());
        }
        if (fRegion){
            query.setParameter("region",options.getRegion());
            query1.setParameter("region",options.getRegion());
        }
        carsList=query.list();
        ResultCars result=new ResultCars();
        result.setCars(carsList);
        result.setPage(page);
        result.setPages((Long)query1.list().get(0)/10+1);
        if(session.isOpen())session.close();
        return result ;
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
        query.setParameter("id", idCar);
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
        pathPhoto.forEach(p -> photos.add(p));
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
    public void deleteOldCar(Integer period_in_month){
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.MONTH, -period_in_month);
        Date date =calendar.getTime();
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        Query query = session.createQuery(" from Car where dateProvide<=:date");
        query.setParameter("date", date);
        List<Car>cars=query.list();
        if(!cars.isEmpty()){
            cars.forEach ( c-> {
                c.getPhotoPath().forEach(p -> new File(p).delete());
                session.delete(c);
                tr.commit();
        });
        }
        if(session.isOpen()){
            session.close();
        }}
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
        Query query=session.createQuery("from Car where idDealer=:idDealer");
        query.setParameter("idDealer", idDealer);
        try {
            session.delete(query.list().get(0));
            tr.commit();
        }
          catch (IndexOutOfBoundsException e){
              System.out.println("Car DAO 319 line IndexOutOfBoundsException ");
          }


      finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }
    public List<String>getModelByBrand(String brand){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction=session.beginTransaction();
        CarBrand carBrand= session.get(CarBrand.class, brand);

        if (carBrand==null){
            List<String> model=new ArrayList<>();
            model.add(standartMasege.getMessage(25));
            return model;
        }
        return carBrand.getModels();
    }

}
