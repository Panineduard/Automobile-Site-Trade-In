package wepServise;

import dao.CarDAO;
import dao.configuration.files.HibernateUtil;
import modelClass.Car;
import modelClass.Login;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 03.10.15.
 */
public class ServletImeges extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        Car car= new Car();
        Integer number_of_photo=0;

        if(req.getParameter("idCar") != null){

            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            car=session.get(Car.class, new Long(req.getParameter("idCar") ));


        }
        if(req.getParameter("number_of_photo")!=""&&req.getParameter("number_of_photo")!=null){
        number_of_photo=new Integer(req.getParameter("number_of_photo"));
        }

//        if(!car.getPhoto().isEmpty()){
//        try {
//
//            response.setContentType("image/jpg");
//            response.getOutputStream().write(car.getPhoto().get(number_of_photo));
//            response.getOutputStream().flush();
//            response.getOutputStream().close();
//        }
//        catch(Exception e){
//            e.printStackTrace();
//        }
//        }
    }


    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        File file=new File(req.getParameter("photo"));
        byte[] saveImage = new byte[(int) file.length()];
        Car car = (Car)req.getAttribute("newCar");
//        List<byte[]> carsPhoto=car.getPhoto();
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            fileInputStream.read(saveImage);
            fileInputStream.close();
//            carsPhoto.add(saveImage);
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            session.merge(car);
            session.getTransaction().commit();

        } catch (Exception e) {
            req.setAttribute("exception","File save exception");
            System.out.println("Файл не найден");
        }
        response.sendRedirect("/pageForCar.jsp");
    }
}
