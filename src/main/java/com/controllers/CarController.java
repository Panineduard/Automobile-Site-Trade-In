package com.controllers;

import com.helpers.FileUploadForm;
import dao.CarDAO;
import dao.DealerDao;
import dao.configuration.files.HibernateUtil;
import modelClass.Car;
import modelClass.Login;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import servise.ViewHalper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by Эдуард on 30.11.15.
 */
@Controller
public class CarController {
    @RequestMapping(value = "/getPhoto", method = RequestMethod.GET)
    public void getRegistrationForm(HttpServletRequest req,HttpServletResponse response){
        String path_of_photo=(String)req.getParameter("pathPhoto");
        System.out.println(path_of_photo);
        if(!req.getParameter("pathPhoto").isEmpty()){
//            path_of_photo=req.getParameter("path_of_photo");


            try {

                FileInputStream fileInputStream=null;

                try {
                    File file=new File(path_of_photo);
                    byte[] chars = new byte[(int)file.length()];
                    fileInputStream=new FileInputStream(path_of_photo);
                    fileInputStream.read(chars);
                    fileInputStream.close();


                    response.setContentType("image/jpg");
                    response.getOutputStream().write(chars);
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                }

                catch(FileNotFoundException fe){
                    fe.printStackTrace();
                }
                finally {
                    fileInputStream.close();
                }

            }
            catch (IOException r){
                System.out.println("Ошибка потока");
            }
        }

    }


    @RequestMapping(value = "/addCar")
    public ModelAndView getLoginForm(){
        ModelAndView modelAndView = new ModelAndView("pageForCar");
        return modelAndView;
    }

    @RequestMapping(value = "/addCarWithPhoto",method = RequestMethod.POST)
    public ModelAndView uploadFileHandler(@ModelAttribute("uploadForm") FileUploadForm uploadForm,Model map,
                                          @ModelAttribute("make")String make,@ModelAttribute("model")String model,
                                          @ModelAttribute("prise")String prise,@ModelAttribute("year_prov")String year_prov,
                                          @ModelAttribute("engine")String engine,@ModelAttribute("gearbox")String gearbox,
                                          @ModelAttribute("comment")String comment,HttpServletRequest request) {
        Login login = (Login)request.getSession().getAttribute("login");
        if (login!=null) {
            String idDealer=login.getIdDealer();
            Car car = new Car();
            CarDAO carDAO=new CarDAO();
            DealerDao dealerDao = new DealerDao();


            car.setIdDealer(idDealer);

            if (!make.isEmpty()) {
                car.setBrand(make);

            if (!model.isEmpty()) {
                car.setModel(model);

            if (!prise.isEmpty()) {
                car.setPrise(new Integer(prise));

            if (!year_prov.isEmpty()) {
                car.setYearMade(new Integer(year_prov));

            if (!engine.isEmpty()) {
                car.setEnginesType(engine);

            if (!gearbox.isEmpty()) {
                car.setTransmission(gearbox);

                if (!comment.isEmpty()) {
                    car.setDescription(comment);
                }


                if (carDAO.setCar(car, uploadForm.getFiles()) != -1L) {
                    ModelAndView modelAndView=new ModelAndView("myAccount");
                    modelAndView.addObject("msg","Автомобиль удачно добавлен");
                    return ViewHalper.addingDealerAndCarsInView(modelAndView,request);
                }


            }}}}}}

        }

        ModelAndView modelAndView=new ModelAndView("pageForCar");
        modelAndView.addObject("msg","Авто не добавлено проверьте поля");
        return modelAndView;

    }


}
