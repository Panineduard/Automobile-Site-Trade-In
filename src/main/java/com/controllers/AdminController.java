package com.controllers;

import com.dao.AdminServiceDAO;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.helpers.EncoderId;
import com.helpers.FileUploadForm;
import com.servise.StandartMasege;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * Created by volkswagen1 on 14.02.2016.
 */
@Controller
public class AdminController {
    @RequestMapping("/update_dealers_list")
    public ModelAndView getAdminPage(){
        ModelAndView modelAndView = new ModelAndView("admin_page");
        AdminServiceDAO adminServiceDAO=new AdminServiceDAO();
        modelAndView.addObject("dealers",adminServiceDAO.getAllDealers());
        return modelAndView;
    }

    @RequestMapping(value = "/updateModelBy", method = RequestMethod.GET)
     public void getRegistrationForm(@ModelAttribute("ModelFile") File modelsFile,@ModelAttribute("Brand") String brand){




    }
    @RequestMapping(value = "/deleteDealer", method = RequestMethod.POST)
    public ModelAndView deleteDealer(@ModelAttribute("idDealer") String id){
        CarDAO carDAO=new CarDAO();
        carDAO.deleteCarsByDealersID(EncoderId.decodeID(id));
        DealerDao dealerDao = new DealerDao();
        dealerDao.deleteLoginAndDealerById(EncoderId.decodeID(id));
        ModelAndView modelAndView = new ModelAndView("admin_page");
        modelAndView.addObject("msg", StandartMasege.getMessage(24));
        return modelAndView;



    }
}
