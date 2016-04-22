package com.controllers;

import com.dao.AdminServiceDAO;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.dao.configuration.files.HibernateUtil;
import com.helpers.EncoderId;
import com.helpers.FileUploadForm;
import com.modelClass.AuthorizedDealers;
import com.modelClass.CarBrand;
import com.modelClass.Letter;
import com.servise.StandartMasege;
import com.servise.TaskExecutorClass;
import com.setting.SettingJavax;
import org.apache.commons.io.IOUtils;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
@Controller
public class AdminController {
    @Autowired
    StandartMasege standartMasege;
    @Autowired
    AdminServiceDAO adminServiceDAO;
    @Autowired
    DealerDao dealerDao;
    @Autowired
    CarDAO carDAO;
    @Autowired
    EncoderId encoderId;
    @Autowired
    TaskExecutorClass taskExecutorClass;
    @RequestMapping("/sendEmailToOwnersOldCars")
    public ModelAndView sendEmailToOwnersOldCars(){
        taskExecutorClass.sendEmailToOwnersOldCars();
        ModelAndView modelAndView = new ModelAndView("admin_page");
        return modelAndView;
    }
    @RequestMapping("/update_dealers_list")
    public ModelAndView getAdminPage(){
        ModelAndView modelAndView = new ModelAndView("admin_page");
        modelAndView.addObject("dealers",adminServiceDAO.getAllDealers());
        return modelAndView;
    }
    @RequestMapping("/update_authorized_dealers_list")
    public ModelAndView getAdminPageWithAuthorizedDealers(){
        ModelAndView modelAndView = new ModelAndView("admin_page");
        modelAndView.addObject("authorized_dealers",adminServiceDAO.getAuthorizedDealers());
        return modelAndView;
    }
    @RequestMapping("/addDealerNumber")
    public ModelAndView addAuthorizedDealers(@ModelAttribute ("dealer_number")String dealersNumber)  {
        AuthorizedDealers authorizedDealer=new AuthorizedDealers();
        authorizedDealer.setDealer_number(dealersNumber);
        ModelAndView modelAndView = new ModelAndView("admin_page");
        if(dealerDao.addLegalsDealer(authorizedDealer)){
            modelAndView.addObject("msg",standartMasege.getMessage(28));
        }
        else  modelAndView.addObject("msg",standartMasege.getMessage(30));

        return modelAndView;
    }
    @RequestMapping("/deleteAuthorizedDealer")
    public ModelAndView deleteAuthorizedDealers(@ModelAttribute ("idDealer")String dealersNumber) {
        if(dealersNumber!=null){
        dealerDao.deleteLegalsDealer(encoderId.decodeID(dealersNumber));}
        ModelAndView modelAndView = new ModelAndView("admin_page");
        return modelAndView;
    }
    @RequestMapping("/deleteOldCars")
    public ModelAndView deleteOldCars(@ModelAttribute ("month")Integer month) {
        carDAO.deleteOldCar(month);
        ModelAndView modelAndView = new ModelAndView("admin_page");
        return modelAndView;
    }

    @RequestMapping(value = "/updateBrands", method = RequestMethod.POST)
    public ModelAndView updateBrands(@ModelAttribute("uploadForm")  FileUploadForm uploadForm) {
        ModelAndView modelAndView=new ModelAndView("admin_page");
        try {
            adminServiceDAO.setBrands(uploadForm.getFiles().get(0));
            modelAndView.addObject("msg", standartMasege.getMessage(43));
        } catch (IOException e1) {
            modelAndView.addObject("msg", standartMasege.getMessage(41));
        }
        return modelAndView;

    }
    @RequestMapping(value = "/updateRegions", method = RequestMethod.POST)
    public ModelAndView updateRegions(@ModelAttribute("uploadForm")  FileUploadForm uploadForm) throws IOException {
        ModelAndView modelAndView=new ModelAndView("admin_page");

            uploadForm.getFiles()
                    .forEach(f -> {
                        if (f != null) {
                            try {
                                adminServiceDAO.setRegions(f);
                                modelAndView.addObject("msg", standartMasege.getMessage(40));

                            } catch (IOException e) {
                                modelAndView.addObject("msg", standartMasege.getMessage(41));
                            }
                        }
                    });

        return modelAndView;

    }
    @RequestMapping(value = "/updateYears", method = RequestMethod.POST)
    public ModelAndView updateYears(@ModelAttribute("uploadForm")  FileUploadForm uploadForm) {
        ModelAndView modelAndView=new ModelAndView("admin_page");
        try {
            adminServiceDAO.setYears(uploadForm.getFiles().get(0));
            modelAndView.addObject("msg", standartMasege.getMessage(42));
        } catch (IOException e1) {
            modelAndView.addObject("msg", standartMasege.getMessage(41));
        }
           return modelAndView;

    }
    @RequestMapping(value = "/updateModelByBrand", method = RequestMethod.POST)
     public ModelAndView getRegistrationForm(@ModelAttribute("uploadForm")  FileUploadForm uploadForm,@ModelAttribute("Brand") String brand) throws IOException {
        ModelAndView modelAndView=new ModelAndView("admin_page");
        if(!brand.isEmpty()) {
            uploadForm.getFiles()
                    .forEach(f -> {
                        if (f != null) {
                            try {
                                adminServiceDAO.setModelsByBrand(f, brand);
                                modelAndView.addObject("msg", standartMasege.getMessage(26));

                            } catch (IOException e) {
                                modelAndView.addObject("msg", standartMasege.getMessage(27));
                            }
                        }
                    });
        }
        else {modelAndView.addObject("msg", standartMasege.getMessage(27));}
            return modelAndView;

    }
    @RequestMapping(value = "/deleteDealer", method = RequestMethod.POST)
    public ModelAndView deleteDealer(@ModelAttribute("idDealer") String id){
        carDAO.deleteCarsByDealersID(encoderId.decodeID(id));
        dealerDao.deleteLoginAndDealerById(encoderId.decodeID(id));
        ModelAndView modelAndView = new ModelAndView("admin_page");
        modelAndView.addObject("msg", standartMasege.getMessage(24));
        return modelAndView;
    }
    @RequestMapping(value = "/delete_message",method = RequestMethod.GET)
    public ModelAndView deleteMessage(@RequestParam("id")String id,@RequestParam("all")String all){
            adminServiceDAO.deleteLetter(encoderId.decodeID(id), encoderId.decodeID(all));
      return new ModelAndView("admin_page").addObject("msg",standartMasege.getMessage(45));
    }
    @RequestMapping(value = "/get_messages",method = RequestMethod.GET)
    public ModelAndView getMessages(){
        ModelAndView modelAndView=new ModelAndView("admin_page");
        modelAndView.addObject("messages",adminServiceDAO.getMessages());
        return modelAndView;
    }
}
