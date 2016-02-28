package com.controllers;

import com.dao.CarDAO;
import com.dao.DealerDao;

import com.helpers.EncoderId;
import com.helpers.PasswordHelper;
import com.helpers.SearchOptions;
import com.modelClass.Address;
import com.modelClass.Car;
import com.modelClass.Contact_person;
import com.modelClass.Dealer;
import com.servise.StandartMasege;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;
import sun.plugin.liveconnect.SecurityContextHelper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.IdentityHashMap;
import java.util.Map;

/**
 * Created by Эдуард on 07.11.15.
 */
@Controller
@SessionAttributes("login")
public class UserController {
    @Autowired
    StandartMasege standartMasege;
    @Autowired
    DealerDao dealerDao;
    @Autowired
    CarDAO carDAO;


    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public ModelAndView getRegistrationForm(){
        ModelAndView modelAndView = new ModelAndView("registration");
        return modelAndView;
    }
    @RequestMapping(value = "/registration",method = RequestMethod.POST)
    public ModelAndView saveUserData(@RequestParam("pasword") String pasword,@RequestParam("checkPasword") String checkPasword,@RequestParam("numberDealer")
                String numberDealer,@RequestParam("nameDealer") String nameDealer,@RequestParam("email") String email,
                @RequestParam("name") String name,@RequestParam("personPhone")String personPhone,
                @RequestParam("city")String city,@RequestParam("captcha")String input_captcha,HttpSession session,
                                     ModelMap modelMap) {
                String captcha =(String)session.getAttribute("CAPTCHA");
        PasswordHelper passwordHelper = new PasswordHelper();


        if(captcha==null || (captcha!=null && !passwordHelper.matches(input_captcha, captcha))){
            ModelAndView modelAndView = new ModelAndView("registration");
            modelAndView.addAllObjects(modelMap);
            modelAndView.addObject("msg",standartMasege.getMessage(22)+"<br>"+standartMasege.getMessage(23));
            return modelAndView;
        }
        String returnMessage;
//        DealerDao dealerDao = new DealerDao();
       try{ if (pasword.equals(checkPasword)){

            returnMessage= dealerDao.setDealer(numberDealer, nameDealer,email,name,personPhone,pasword,city);

        }
        else {
            returnMessage = standartMasege.getMessage(6);
        }
        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", standartMasege.getMessage(7) +" "+ name + " " + returnMessage);
        return model;}
        catch (NumberFormatException e){

           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", standartMasege.getMessage(8));
           return model1;
        }
    }

@RequestMapping(value = "/ConfirmationOfRegistration", method = RequestMethod.GET)
public  ModelAndView registrationComp(@RequestParam("id") String idDealer){
//    DealerDao dealerDao = new DealerDao();
    String msg;
    ModelAndView model;
    if(dealerDao.updateRegistrationAndRoleById(idDealer))
    {
        model = new ModelAndView("successfulRegistration");
        msg=standartMasege.getMessage(9);
        model.addObject("msg",msg );
    }
    else {

        model=new ModelAndView("zerroPage");
    }

    return model;
}
    @RequestMapping(value = {"/myAccount","*/myAccount"})
    public ModelAndView accountModel(){

            ModelAndView modelAndView = new ModelAndView("my_account");
            return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/feedback")
    public ModelAndView getFeedbackForm(){
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        auth.getPrincipal();
        ModelAndView modelAndView = new ModelAndView("feedback");
        return modelAndView;
    }

    @RequestMapping(value = "/carPage",method = RequestMethod.GET)
    public ModelAndView getDealer(@RequestParam ("idCar") String idCar){
        ModelAndView modelAndView= new ModelAndView("auto");
        Car car=null;
//        CarDAO carDAO =new CarDAO();
        if(!idCar.isEmpty()){
            car=carDAO.getCarById(idCar);
//            DealerDao dealerDao=new DealerDao();
            modelAndView.addObject("car", car);
            modelAndView.addObject("dealer",dealerDao.getDealerById(car.getIdDealer()));
        }


        return modelAndView;
    }
    @RequestMapping(value = "*/change_contact_person", method = RequestMethod.POST)
    public ModelAndView changeContactPersonsData(@RequestParam("manager") String manager,@RequestParam("phone") String phone,
                                                 @RequestParam("id") Integer idPerson, @RequestParam("email") String email){

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        Contact_person contact_person = new Contact_person();
//        DealerDao dealerDao= new DealerDao();
        if(!manager.isEmpty()){contact_person.setName(manager);}
        if(!phone.isEmpty()){contact_person.setPhone(phone);}
        if(!email.isEmpty()){contact_person.setEmail(email);}
        dealerDao.changeContactPersonsData(idDealer, idPerson, contact_person);
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "*/changeAddress", method = RequestMethod.POST)
    public ModelAndView addContactPersonsData(@RequestParam("index") String index,@RequestParam("street") String street,
                                                 @RequestParam("house_number") String house_number){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
//        DealerDao dealerDao= new DealerDao();
        if(index.isEmpty()){index="";}
        if(street.isEmpty()){street="";}
        if(house_number.isEmpty()){house_number="";}
        dealerDao.changeDealersAddress(idDealer,index,street,house_number);
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }
    @RequestMapping(value = "*/delete_contact_person", method = RequestMethod.GET)
    public ModelAndView deleteContactPerson(@RequestParam("count")String id ,HttpSession session){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
//        DealerDao dealerDao= new DealerDao();
        Integer idPerson = new Integer(EncoderId.decodeID(id));
        if(idPerson!=null){
        dealerDao.deleteContactPersonById(idDealer,idPerson);
        }
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }
}
