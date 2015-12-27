package com.springapp.mvc;

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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Эдуард on 30.11.15.
 */
@Controller
public class CarController {
    @RequestMapping(value = "/getPhoto", method = RequestMethod.GET)
    public void getRegistrationForm(HttpServletRequest req,HttpServletResponse response){
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

        if(!car.getPhotoPath().isEmpty()){

//            try {
//
//                response.setContentType("image/jpg");
//                response.getOutputStream().write(new File(car.getPhotoPath().get(number_of_photo)));
//                response.getOutputStream().flush();
//                response.getOutputStream().close();
//            }
//            catch(Exception e){
//                e.printStackTrace();
//            }
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
                                          @ModelAttribute("comment")String comment,HttpSession httpSession) {
        Login login = (Login)httpSession.getAttribute("login");
        if (login!=null) {
            Long idDealer=login.getIdDealer();
            System.out.println("прошол файл");
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
                    return modelAndView;
                }


            }}}}}}

        }

        ModelAndView modelAndView=new ModelAndView("pageForCar");
        modelAndView.addObject("msg","Авто не добавлено проверьте поля");
        return modelAndView;

    }


}
