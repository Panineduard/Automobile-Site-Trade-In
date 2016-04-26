

import com.captcha.util.Util;
import com.dao.AnonymousUserDAO;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.dao.configuration.files.HibernateUtil;
import com.helpers.SearchOptions;
import com.modelClass.*;
import com.servise.TaskExecutorClass;
import org.apache.commons.io.FileUtils;
import org.hibernate.Session;


import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 11.08.15.
 */
public class Main {
    public static void main(String...args)  {
//String prise="45 45";


//       DealerDao dealerDao = new DealerDao();
//        dealerDao.updateCountOfCar("1");
//        CarDAO carDAO=new CarDAO();
//        System.out.println(carDAO.getModelByBrand(null));
//        SearchOptions searchOptions=new SearchOptions(new String(),new String(),new String(),new String(),new String(),new String(),new String(),new String(),new String(),0);
//        System.out.println(carDAO.getCarsByParameters(searchOptions,0));
//
//        String h="    ";
//        h=h.replaceAll("[\\s]{1,}", "").toLowerCase().trim();
//        if (h.matches("[-+]?\\d+")){
//            StringBuffer sb=new StringBuffer(h);
//            int step=3;
//            for (int i =0;i<(h.length()/3);i++){
//                sb.insert(sb.length() - step, " ");
//                step=step+4;
//            }
//            h=sb.toString();
//            h=h.trim();
//            System.out.println(h);
//        }

//        DealerDao dealerDao=new DealerDao();

//        dealerDao.deleteLoginAndDealerById("1");
//        CarDAO carDAO=new CarDAO();
//        System.out.println(carDAO.getCarsByParameters(new SearchOptions("","","","","","","","","",0),1));
//        carDAO.deleteCarsByDealersID("1");
//        carDAO.deleteCarById("58");
//        carDAO.deletePhotoByCarsId(4L,74l);

//
//        CarDaoInterface carDAO = new CarDaoInterface();
//        Long idFoundDealer = (121L);
//        List<Car> cars ;
//        cars=carDAO.getCarByIdDealer(idFoundDealer);
//
//
//
//        for (int i =0;i<cars.size();i++) {
//            System.out.println(cars.get(i).getBrand());
//        }
////




//Login login = new Login();
//        login.setPassword("1");
//        login.setUsername("121");
//        login.setIdLogin(121L);
//        LoginDao loginDao = new LoginDao();
//        System.out.println(loginDao.checkLogin(login));


//        Dealer dealer = new Dealer();
//        Address address = new Address();
//        address.setCity("Sity1");
//        address.setNamberhouse(232L);
//        address.setStreet("street1");
//        dealer.setAdress(address);
//        dealer.setNameDealer("Avtodom");
//        dealer.setNumberDealer(34);
//        dealer.setPhoneDealer("1242343422");
//        List<Contact_person> contact_persons =dealer.getContact_persons();
//        Contact_person contact_person1 = new Contact_person();
//        contact_person1.setEmail("Email1");
//        contact_person1.setFirstname("fdff");
//        contact_person1.setLastname("fdfds");
//        contact_person1.setName("dsfsdf");
//        contact_person1.setPhone(342423);
//        contact_persons.add(contact_person1);
//

//            Car car = new Car();
//            car.setDateProvide(new Date());
//            car.setBrand("Audi" + 1);
//            car.setDescription("Фигня полная");
//            car.setIdDealer(121L);
//            List<byte[]> photos = new ArrayList<byte[]>();
//        for (int i=0;i<5;i++) {
//            File file = new File("D:\\JAVA\\volkswagenTradeIn\\testImeges\\" + i + ".jpg");
//            byte[] saveImage = new byte[(int) file.length()];
//            try {
//                FileInputStream fileInputStream = new FileInputStream(file);
//                fileInputStream.read(saveImage);
//                fileInputStream.close();
//            } catch (Exception e) {
//                System.out.println("Файл не найден");
//            }
//
//            photos.add(saveImage);
//        }
//            car.setPhoto(photos);
////
////
////
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
//            session.merge(car);
////
//            session.getTransaction().commit();

//        CarDaoInterface carDAO = new CarDaoInterface();
//        System.out.println(carDAO.getCarByIdDealer(121L).get(0).getBrand());



//        Car car1 = new Car();
//        car1 =session.get(Car.class,2L);
//        System.out.println(car1.getBrand());
//        System.out.println(car1.getPhoto());
//
//
//
//        try{
//            FileOutputStream fos = new FileOutputStream("D:\\JAVA\\volkswagenTradeIn\\testImeges\\1Out.jpg");  //windows
//
//            fos.write(car1.getPhoto().get(0));
//            fos.close();
//        }catch(Exception e){
//            e.printStackTrace();
//        }
//        car = null;
//        session = HibernateUtil.getSessionFactory().openSession();
//        session.beginTransaction();
//        car =session.get(Car.class,454L);
//        System.out.println(car.getDescription());
//        session.close();
    }
}
