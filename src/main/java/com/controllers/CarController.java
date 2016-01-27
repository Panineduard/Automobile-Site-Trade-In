package com.controllers;

import com.helpers.FileUploadForm;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.modelClass.Car;
import com.servise.ChangeImgSize;
import com.servise.StandartMasege;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;

/**
 * Created by Эдуард on 30.11.15.
 */
@Controller
public class CarController {
    @RequestMapping(value = "/getPhoto", method = RequestMethod.GET)
    public void getRegistrationForm(HttpServletRequest req,HttpServletResponse response){
        String path_of_photo=(String)req.getParameter("pathPhoto");
        Integer imgHeight=0;
        Integer imgWidth =0;
        try {

        if(req.getParameter("Height")!=null||req.getParameter("Width")!=null){
            imgHeight=new Integer(req.getParameter("Height"));
            imgWidth=new Integer(req.getParameter("Width"));

        }
        }
        catch (ClassCastException e){
            System.out.println("exeption in car contpoller param");
        }
        finally {


        if(req.getParameter("pathPhoto")!=null&&!req.getParameter("pathPhoto").isEmpty()){
//            path_of_photo=req.getParameter("path_of_photo");


            try {

//                FileInputStream fileInputStream=null;

                try {
                    File file=new File(path_of_photo);
//                    byte[] chars = new byte[(int)file.length()];
//                    fileInputStream=new FileInputStream(path_of_photo);
//                    fileInputStream.read(chars);
//                    fileInputStream.close();
                    BufferedImage bufferedImage =  ImageIO.read(file);
//
                    if(imgHeight!=0||imgWidth!=0){
                        bufferedImage = ChangeImgSize.resizeImage(bufferedImage, imgWidth, imgHeight);
                    }

                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    ImageIO.write(bufferedImage,"jpg",baos);
                    baos.flush();
                    byte[] imageInByte = baos.toByteArray();
                    baos.close();

                    response.setContentType("image/jpg");
                    response.getOutputStream().write(imageInByte);
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                }

                catch(FileNotFoundException fe){
                    fe.printStackTrace();
                }
                finally {
//                    fileInputStream.close();
                }

            }
            catch (IOException r){
                System.out.println("Ошибка потока");
            }
        }
        }
    }


    @RequestMapping(value = "/addCar")
    public ModelAndView getLoginForm(){
        ModelAndView modelAndView = new ModelAndView("pageForCar");
        return modelAndView;
    }


    @RequestMapping(value = "/lookForCars",method = RequestMethod.POST)
    public ModelAndView getCarsPages(@ModelAttribute("make")String make,@ModelAttribute("model")String model,
                                     @ModelAttribute("price_from")String price_from,@ModelAttribute("price_to")String price_to,
                                     @ModelAttribute("year_from")String year_from,@ModelAttribute("year_to")String year_to,
                                     @ModelAttribute("engine")String engine,@ModelAttribute("gearbox")String gearbox,HttpSession session){
        CarDAO carDAO= new CarDAO();
        List<Car> cars =carDAO.getCarsByParameters(make,model,price_from,price_to,year_from,year_to,engine,gearbox);
        ModelAndView modelAndView = new ModelAndView("index");
        session.setAttribute("cars",cars);
        session.removeAttribute("page");
//        modelAndView.addObject("cars",cars);
        return modelAndView;
    }

    @RequestMapping(value = "/addCarWithPhoto",method = RequestMethod.POST)
    public ModelAndView uploadCarsFile(@ModelAttribute("uploadForm") FileUploadForm uploadForm,Model map,
                                          @ModelAttribute("make")String make,@ModelAttribute("model")String model,
                                          @ModelAttribute("prise")String prise,@ModelAttribute("year_prov")String year_prov,
                                          @ModelAttribute("engine")String engine,@ModelAttribute("gearbox")String gearbox,
                                          @ModelAttribute("mileage")String mileage,@ModelAttribute("comment")String comment,
                                          @ModelAttribute("engine_capacity")String engine_capacity) {
        String nullMsg="Data not available.";
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer = auth.getName();
        if (!idDealer.isEmpty()) {
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
                if(!engine_capacity.isEmpty()){car.setEngineCapacity(engine_capacity);}
                else {car.setEngineCapacity(nullMsg);}
                if(!mileage.isEmpty()){
                    car.setMileage(new Integer(mileage));
                }
                else car.setMileage(0);

                if (carDAO.setCar(car, uploadForm.getFiles()) != -1L) {
                    ModelAndView modelAndView=new ModelAndView("my_account");
                    modelAndView.addObject("msg", StandartMasege.getMessage(1));
                    return ViewHalper.addingDealerAndCarsInView(modelAndView);
                }


            }}}}}}

        }

        ModelAndView modelAndView=new ModelAndView("pageForCar");

        modelAndView.addObject("msg",StandartMasege.getMessage(2));
        return modelAndView;

    }


}
