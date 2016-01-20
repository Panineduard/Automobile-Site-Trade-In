package com.servise;

import com.dao.CarDAO;
import com.dao.DealerDao;
import com.email.SendEmailText;
import com.helpers.PasswordHelper;
import javafx.util.converter.LocalDateTimeStringConverter;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.task.TaskExecutor;

import java.io.*;
import java.time.LocalDateTime;

/**
 * Created by ������ on 12.08.15.
 */
public class Test {
    public static void main(String... arg) throws IOException {
        System.out.println(StandartMasege.getMessage(1));
//        LocalDateTime localDateTime=LocalDateTime.now();
//        LocalDateTime localDateTime1 = localDateTime.plusDays(2);
////        System.out.println(localDateTime1.isAfter(localDateTime));
//CleanDBTaskExecutor cdb =new CleanDBTaskExecutor();
//        cdb.serviceMethod();
//DealerDao dealerDao=new DealerDao();
//        System.out.println(dealerDao.getIdDealersWithoutAuth());


//        AutoClineDB autoClineDB=new AutoClineDB();
//        autoClineDB.beepForAnHour();
//        CarDAO carDAO=new CarDAO();
//        DealerDao dealerDao = new DealerDao();
//
//        System.out.println(carDAO.getCarById("1"));
//        System.out.println(dealerDao.getDealerById(carDAO.getCarById("1").getIdDealer()));
//        PasswordHelper passwordHelper=new PasswordHelper();
//        System.out.println(passwordHelper.encode("1"));
//        System.out.println(passwordHelper.encode(passwordHelper.encode("1")));
//        DealerDao dealerDao=new DealerDao();
//        CarDAO carDAO = new CarDAO();
//        System.out.println(carDAO.getLastCars(3));

//        dealerDao.updateRegistrationAndRoleById("3");
//        Session session = HibernateUtil.getSessionFactory().openSession();
//        session.beginTransaction();
//        Car car = new Car();
//        car=session.get(Car.class, new Long(4));
//
//        System.out.println(car.getBrand());


//        //add img in DB
//        String path="testImeges\\1.jpg";
//        File file=new File(path);
//
//        car.setBrand("bently");
//        car.setIdCar(1L);
//        car.setIdDealer(1L);
//        List<byte[]> carsPhoto=new ArrayList<byte[]>();
//        byte[] saveImage = new byte[(int) file.length()];
//        FileInputStream fileInputStream = new FileInputStream(file);
//        fileInputStream.read(saveImage);
//        fileInputStream.close();
//        carsPhoto.add(saveImage);
//         car.setPhoto(carsPhoto);
//        Session session = HibernateUtil.getSessionFactory().openSession();
//        session.beginTransaction();
//        session.merge(car);
//        session.getTransaction().commit();
    }
}
