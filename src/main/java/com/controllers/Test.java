package com.controllers;

import com.dao.AdminServiceDAO;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.helpers.EncoderId;
import com.helpers.PasswordHelper;
import com.modelClass.Address;
import com.modelClass.Contact_person;
import com.setting.Setting;
import com.setting.TestClass;
import javafx.util.converter.LocalDateTimeStringConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.xml.parsers.SAXParserFactory;
import java.io.*;
import java.time.LocalDateTime;
import java.util.*;

/**
 * Created by ������ on 12.08.15.
 */
//@Component
public class Test {

//    @Autowired
//    TestClass testClass;
//    public String test(){
//        return testClass.getName();
//    }
    public static void main(String... arg) throws IOException {

        //----------------------Collection sort-------------------
//        List <Integer> integers=new ArrayList<>();
//        Random random=new Random();
//        for (int i=0;i<30;i++){
//            integers.add(random.nextInt(100));
//        }
//        System.out.println(integers);
//        Collections.sort(integers, (Integer i1, Integer i2) -> -(i1.compareTo(i2)));
//        System.out.println(integers);
        //------------------------------------------------------------------

//        System.out.println(StandartMasege.getMessage(15));
//        System.out.println(Setting.getEmailTo());
//        boolean f=Setting.isAbsolutePath();
//        System.out.println(f);
//        ResourceBundle resourceBundle =  ResourceBundle.getBundle("messages");
//
//        System.out.println(resourceBundle.getString("1"));
//        AdminServiceDAO adminServiceDAO = new AdminServiceDAO();
//        System.out.println(adminServiceDAO.getAllDealers());

//        System.out.println(Setting.getHost());
//        CarDAO carDAO=new CarDAO();
//        System.out.println(carDAO.getModelByBrand("Vohgfhlkswagen"));
//        carDAO.getOldCarOwnersEmails(1);
//        DealerDao dealerDao = new DealerDao();
//        System.out.println(dealerDao.updateCountOfCar("1"));
//        dealerDao.deleteLoginAndDealerById("2");
//        Contact_person contact_person = new Contact_person();
//        contact_person.setEmail("dgfhdgf");
//        contact_person.setPhone("0501214455");
//        contact_person.setName("Сергей");
//        System.out.println(contact_person.getName().toLowerCase());
//        dealerDao.updateCountOfCar("1");
//        dealerDao.changeDealersAddress("1","124","94A","Клочковская");
//        dealerDao.changeContactPersonsData("1",null,contact_person);
//        System.out.println(dealerDao.deleteContactPersonById("1", 0));
//        List<String> strings = new ArrayList<>();
//        strings.add("1");
//        strings.add("2");
//        strings.add("3");
//        System.out.println(strings);
//        strings.remove(1);
//        System.out.println(strings);

//        CarDAO carDAO = new CarDAO();

//
//        System.out.println(carDAO.deleteCarById("1"));
//        System.out.println(StandartMasege.getMessage(1));
//        LocalDateTime localDateTime=LocalDateTime.now();
//        LocalDateTime localDateTime1 = localDateTime.plusDays(2);
////        System.out.println(localDateTime1.isAfter(localDateTime));

//     TaskExecutorClass cdb =new TaskExecutorClass();
//        cdb.sendEmailToOwnersOldCars();
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
