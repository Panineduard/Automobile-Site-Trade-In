package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.helpers.ResultCars;
import com.helpers.SearchOptions;
import com.modelClass.*;

import com.servise.ChangeImgSize;
import com.servise.StandartMasege;
import com.setting.Setting;
import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;
import interfaceModel.dao.CarDaoInterface;
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
 * @author Panin Eduard on 02.10.15.
 * @version 1.0
 */
@Repository
public class CarDAO implements CarDaoInterface {
@Autowired
StandartMasege standartMasege;
@Autowired
DealerDao dealerDao;
@Autowired
ChangeImgSize changeImgSize;
    private List<PhotoPath> setPhotoFiles(Car car,List<MultipartFile> multipartFiles){
        List<PhotoPath> pathPhoto=new ArrayList<>();
        int numberPhoto=car.getPhotoPath().size();
        for (MultipartFile file:multipartFiles){

            int pointPosition= file.getOriginalFilename().indexOf('.');
            String formatFile =file.getOriginalFilename().substring(pointPosition);
            BufferedOutputStream stream=null;

            try {
                File convFile = new File( file.getOriginalFilename());
                file.transferTo(convFile);
                BufferedImage bufferedImage =  ImageIO.read(convFile);
                if(bufferedImage.getHeight()>=bufferedImage.getWidth()){
                    bufferedImage=changeImgSize.resizeImage(bufferedImage,Setting.get_IMG_HEIGHT(),Setting.get_IMG_WIDTH());
                }
                else {
                    bufferedImage=changeImgSize.resizeImage(bufferedImage,Setting.get_IMG_WIDTH(),Setting.get_IMG_HEIGHT());
                }
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bufferedImage,"jpg",baos);
                baos.flush();


                File file1 = new File(Setting.getClientsFolder()+car.getIdDealer(),car.getIdCar()+"-"+numberPhoto+formatFile);
                pathPhoto.add(new PhotoPath(car.getIdCar(),file1.getAbsolutePath()));
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
        car.setMainPhotoUrl(pathPhoto.get(0).getPath());
        return pathPhoto;
    }
    /**
     * @param idCar accepts a parameter cars id
     * @param idPhoto accepts a parameter photos id
     * @return true if successful completion return false if one of parameters null
     * */
    public boolean deletePhotoByCarsId(long idCar,long idPhoto){
        if(idCar==0&&idPhoto==0)return false;
    Session session=HibernateUtil.getSessionFactory().getCurrentSession();
    Transaction tr=session.beginTransaction();
      try {
          Car car= session.load(Car.class, idCar);

          PhotoPath photoPath=session.load(PhotoPath.class, idPhoto);

              File file = new File(photoPath.getPath());
              file.delete();//return true if file deleted

        List<PhotoPath>photoPaths=car.getPhotoPath();
        photoPaths.remove(photoPath);
        car.setPhotoPath(photoPaths);
        session.update(car);
        session.delete(photoPath);
        tr.commit();
          return true;
      }
        catch (HibernateException f){
            if(tr!=null)tr.rollback();
            return false;
        }
        catch (Exception e){
            e.printStackTrace();
            return false;
        }
        finally {
            if (session.isOpen()){
                session.close();
            }
        }
    }
    /**
     *we can get Cars List by dealers id.
     * @param idD can`t be null. It is String dealers id
     * @return List of cars
     * @see Car
     * */
    @Nullable
    public List<Car> getCarByIdDealer(@NotNull String idD){
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
        finally {
            if(session.isOpen()){
                session.close();
            }
        }
        return cars;
    }
    /**
     * This method does not has parameters
     * @return List of Integers value with years wat can be in database*/
    public  List<Integer> getYears(){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        List<Integer>years=null;
      try {


        Transaction tr=session.beginTransaction();
        Query query=session.createQuery("from Years ");
        years=query.list();
          tr.commit();
      }
      finally {
          if(session.isOpen()){session.close();}
          return years;
      }

    }
    /**
     * @param car input parameter can be Car.class
     * @see Car
     * @param multipartFiles it is List of MultipartFile
     * @see MultipartFile
     * @return cars id from DB in this car or return -1 if something from data equally 0 */
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
            List<PhotoPath> pathPhoto=new ArrayList<PhotoPath>();
            session.save(car);
            session.flush();
            carId=car.getIdCar();
            List<PhotoPath>photoPaths=new ArrayList<>();
            photoPaths.add(new PhotoPath(carId, "one"));
            photoPaths.add(new PhotoPath(carId, "too"));
            car.setPhotoPath(photoPaths);
            if (multipartFiles.size()>0) {
                pathPhoto=setPhotoFiles(car,multipartFiles);
            }
//            else pathPhoto.add(new PhotoPath(carId,"null"));
            car.setPhotoPath(pathPhoto);
            session.update(car);
            tr.commit();

        }
        catch (Exception e){
            e.printStackTrace();
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

    /**this method found cars for all or one parameters if prise 1 it is ascending_price if prise 2 by_prices_descending 0 nothing
     *
     * @param options it is object SearchOptions.class
     * @see SearchOptions
     * @param page input here what page you want get now it is int value
     * @return object ResultCars.class
     * @see ResultCars
     */
    @Nullable
    public ResultCars getCarsByParameters(@NotNull SearchOptions options, int page){
        //String make,String model,String price_from,String price_to,String year_from,String year_to,String engine,String gearbox,String region,
       if(options==null){
           return null;
       }
        else {
           Session session =HibernateUtil.getSessionFactory().getCurrentSession();


           try {


        List<Car> carsList;

        session.beginTransaction();
        String requestDb ="";
        boolean fMake = false,fModel = false,fPrise_from = false,fPrise_to = false,fYear_from = false,fYear_to = false,
                fRegion=false, fEngine = false,fGearbox=false;
        String priseQuery=" ";
        if(options.getPrise()==1){
                priseQuery=" ORDER BY c.prise ";
        }
        if (options.getPrise()==2){
            priseQuery=" ORDER BY c.prise DESC";
        }
        if(options.getRegion()!=null&&!options.getRegion().isEmpty()){
            fRegion=true;
            requestDb=requestDb+"and c.region=:region";
        }
        if(options.getMake()!=null&&!options.getMake().isEmpty()){
            fMake=true;
        requestDb=requestDb+" and c.brand=:make";
        }
        if(options.getModel()!=null&&!options.getModel().isEmpty()){
            fModel=true;
            requestDb+= " and c.model=:model";
        }
        if(options.getPrice_from()!=null&&!options.getPrice_from().isEmpty()){
            fPrise_from=true;
            requestDb+=" and c.prise>=:prise_from";
        }
        if(options.getPrice_to()!=null&&!options.getPrice_to().isEmpty()){
            fPrise_to=true;
            requestDb+=" and c.prise<=:prise_to";
        }
        if(options.getEngine()!=null&&!options.getEngine().isEmpty()){
            fEngine=true;
            requestDb+=" and c.enginesType =:engine ";
        }
        if(options.getGearbox()!=null&&!options.getGearbox().isEmpty()){
            fGearbox=true;
            requestDb+=" and c.transmission =:gearbox";

        }
        if(options.getYear_from()!=null&&!options.getYear_from().isEmpty()){
            fYear_from=true;
            requestDb+=" and  c.yearMade >=:year_from";
        }
        if(options.getYear_to()!=null&&!options.getYear_to().isEmpty()){
            fYear_to=true;
            requestDb+=" and c.yearMade <=:year_to ";
        }
        Query query1=session.createQuery("select count(*)from Car c where c.id>=:id "+requestDb);
//Query query=session.createQuery("from Car where rownum between '10' ");
        Query query =session.createQuery("from Car  c where c.id>=:id "+requestDb+priseQuery).setFirstResult((page-1)*10).setMaxResults(page*10);

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
//           System.out.println(query.list());
        carsList=(List<Car>)query.list();
        ResultCars result=new ResultCars();
        result.setCars(carsList);
        result.setPage(page);
        result.setPages((Long)query1.list().get(0)/10+1);
        return result ;
    }
   finally {
               if(session.isOpen())session.close();

           }
}
    }



    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    /**
     * @param countLastCar input how many cars return this method if parameter is 0 method return all cfrs from DB
     * @return List of cars and sorted it by date provide
     * @see Car
     * */
    @Nullable
    public List<Car> getLastCars(Integer countLastCar){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
       try {

        Transaction tr=session.beginTransaction();
//        Query query1 = session.createQuery("select max (idCar) from Car ");
//        Long maxIdOfCar = (Long)query1.list().get(0);
        Query query = session.createQuery("from Car c where c.idCar>= :id ORDER BY c.dateProvide DESC ").setMaxResults(countLastCar);
        query.setParameter("id",0L);
        List<Car> cars = (List<Car>)query.list();

        return cars;
       }
       catch (Exception e){
          return null;
       }
        finally {
           if(session.isOpen()){
               session.close();
           }
       }
    }
/**
*@param  id this parameter must be only number if id is null method returns null
*@return object Car.class
*@see Car
*/
@Nullable
    public Car getCarById(String id){
        if(id==null)return null;
        else {
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            try {
        Long idCar =new Long(id);
        session.beginTransaction();
        Query query = session.createQuery("from Car c where c.idCar=:id");
        query.setParameter("id", idCar);
        Car car =(Car)query.uniqueResult();
        return car;
            }
            catch (NumberFormatException f){
                f.printStackTrace();
                return null;
            }
            finally {
                if(session.isOpen()){session.close();}
            }
        }
    }
    /**
     *@param idCar this parameter must be only number if id is null method returns null
     *@return true if successful completion return false if something happened(see StackTrace)
    */
    public boolean deleteCarById(String idCar){
        if(idCar==null)return false;
        else {

        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr=session.beginTransaction();
        try {
            Long id =new Long(idCar);
            Car car= session.load(Car.class, id);

            for (PhotoPath path:car.getPhotoPath()) {
                try {
                    File file = new File(path.getPath());
                    file.delete();//return true if file deleted
                } catch (Exception e) {
                    continue;
                }
            }
            session.delete(car);
//            session.flush();
            tr.commit();
            dealerDao.updateCountOfCar(car.getIdDealer());
            return true;
        }
        catch (NumberFormatException f){
            f.printStackTrace();
            return false;
        }
        catch (org.hibernate.ObjectNotFoundException e){
            e.printStackTrace();
            return false;
        }
       finally {
            if(session.isOpen()){
                session.close();
            }
        }
        }
    }
/**
 * This method just update car in DB with new parameters
 * @param car it is object Car.class
 * @see Car
 * @param multipartFiles it is list of MultipartFile
 * @see MultipartFile
 * @return true if successful completion return false if something happened(see StackTrace)*/
    public boolean updateCarById(Car car,List<MultipartFile> multipartFiles){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        try {


        Transaction tr=session.beginTransaction();
        List<PhotoPath> pathPhoto=new ArrayList<>();
        if (multipartFiles.size()>0) {
            pathPhoto=setPhotoFiles(car,multipartFiles);
        }
        List<PhotoPath>photos=car.getPhotoPath();
        pathPhoto.forEach(p -> photos.add(p));
        car.setPhotoPath(photos);
        session.update(car);
        tr.commit();
        return true;
        }
        finally {
            if(session.isOpen())session.close();
        }
    }
    /**
     * method look for old car owners mail
     *@param period_in_month it is int period of month from today
     *@return empty HashSet if can not fined data in DB
     */
    public HashSet<String> getOldCarOwnersEmails(@NotNull Integer period_in_month){
        HashSet<String> emails=new LinkedHashSet<>();
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        if(period_in_month==null)return emails;
        else {
        try {
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.MONTH, -period_in_month);
        Date date =calendar.getTime();
        Transaction tr=session.beginTransaction();
        Query query = session.createQuery("select idDealer from Car where dateProvide<=:date");
        query.setParameter("date", date);
        List <String> dealersIds=query.list();
        List<Dealer> dealers=new ArrayList<>();
        dealersIds.forEach(n -> dealers.add(session.get(Dealer.class, n)));
        dealers.forEach(n -> emails.add(n.getContact_persons().get(0).getEmail()));
        return emails;
        }
        catch (NullPointerException e){
            e.printStackTrace();
            return emails;
        }
        finally {
            if(session.isOpen())session.close();
        }
        }
    }
    /**
     * @param period_in_month it is int period of month from today it cant be 0 (default period 1 month)
     * @return true if successful completion return false if method can`t fined data from DB something happened(see StackTrace)*/
    public boolean deleteOldCar(Integer period_in_month){
        if(period_in_month==null)return false;
        else {
            if (period_in_month==0)period_in_month=1;
            Session session=HibernateUtil.getSessionFactory().getCurrentSession();
            try {
                Calendar calendar=Calendar.getInstance();
                calendar.add(Calendar.MONTH, -period_in_month);
                Date date =calendar.getTime();
                Transaction tr=session.beginTransaction();
                Query query = session.createQuery(" from Car where dateProvide<=:date");
                query.setParameter("date", date);
                List<Car>cars=query.list();
                if(cars!=null&&!cars.isEmpty()){

                    cars.forEach ( c-> {
                        c.getPhotoPath().forEach(p -> new File(p.getPath()).delete());
                        session.delete(c);

                    });
                    tr.commit();
                    return true;
                }
                else return false;

            }
            finally {
                if(session.isOpen()){
                    session.close();
                }
            }
        }
        }
    /**
     * Method update date on today by cars id
     * @param id it is long number cars id */
    public  void updateDateProvideDyId(Long id){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            Transaction tr = session.beginTransaction();
            Query query = session.createQuery("update Car set dateProvide=:date where idCar=:id");
            query.setParameter("date", new Date());
            query.setParameter("id", id);
            query.executeUpdate();
            tr.commit();
        }
        finally {
            if(session.isOpen()){
                session.close();
            }
        }
    }
    /**
     * method delete all cars from DB and files from folder
     * @param idDealer it is a dealer id
     * */
    public void  deleteCarsByDealersID(String idDealer){

        Optional.ofNullable(idDealer).ifPresent(idD -> {
            Session session=HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tr=session.beginTransaction();
            try {
                List<Car>cars=session.createQuery(" from Car where idDealer=:idDealer")
                        .setParameter("idDealer", idD)
                        .list();
                session.createQuery("delete Car where idDealer=:idDealer")
                        .setParameter("idDealer", idD)
                        .executeUpdate();
                cars.forEach(car -> {
                    car.getPhotoPath().forEach(path->{
                        File file = new File(path.getPath());
                        file.delete();//return true if file deleted
                    });
                    Query query = session.createQuery("delete PhotoPath where idCar=:idCar");
                    query.setParameter("idCar", car.getIdCar());
                    query.executeUpdate();

                });

                tr.commit();
            }

            catch (HibernateException e){
                if (tr!=null){
                    tr.rollback();
                }
            }
            catch (Exception e){
                if (tr!=null){
                    tr.rollback();
                }
            }
            finally {
                if(session.isOpen()){
                    session.close();
                }
            }
        });

    }
    /**
     * @param brand it is String name of model
     * @return list of string from DB if nosing find return special message
     * @see StandartMasege*/
    public List<String>getModelByBrand(String brand){
        Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        try {
        session.beginTransaction();
        CarBrand carBrand= null;
                if (brand!=null){
                    carBrand=session.get(CarBrand.class, brand);
                }

        if (carBrand==null){
            List<String> model=new ArrayList<>();
            model.add(standartMasege.getMessage(25));
            return model;
        }
        return carBrand.getModels();
        }
        finally {
            if(session.isOpen())session.close();
        }
    }
/**
 * @return list of brand from DB*/
    public List<Brand> getBrands() {
            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            List<Brand>brands=null;
            try {
                Transaction tr=session.beginTransaction();
                Query query=session.createQuery("from Brand ");
                brands=query.list();
                tr.commit();
            }
            finally {
                if(session.isOpen()){session.close();}
                return brands;
            }
    }
}
