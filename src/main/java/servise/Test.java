package servise;

import dao.configuration.files.HibernateUtil;
import modelClass.Car;
import org.hibernate.Session;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ������ on 12.08.15.
 */
public class Test {
    public static void main(String... arg) throws IOException {
        System.out.println(new Integer("ewr"));

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
