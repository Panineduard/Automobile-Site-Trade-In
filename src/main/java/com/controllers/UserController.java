package com.controllers;

import com.dao.CarDAO;
import com.dao.DealerDao;
import com.email.SendEmailText;
import com.modelClass.Car;
import com.modelClass.Contact_person;
import com.servise.StandartMasege;
import com.sun.deploy.net.HttpResponse;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;
import sun.plugin.liveconnect.SecurityContextHelper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.IdentityHashMap;

/**
 * Created by Эдуард on 07.11.15.
 */
@Controller
@SessionAttributes("login")

public class UserController {
    @RequestMapping(value = "/replacing_the_page_number", method = RequestMethod.GET)
    public ModelAndView replacePage(@RequestParam("page") Integer page,HttpSession session){
        System.out.println("Номер страницы= "+page);
        session.setAttribute("page", page);
        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public ModelAndView getRegistrationForm(){
        ModelAndView modelAndView = new ModelAndView("registration");
        return modelAndView;
    }
    @RequestMapping(value = "/registration",method = RequestMethod.POST)
    public ModelAndView saveUserData(@RequestParam("pasword") String pasword,@RequestParam("checkPasword") String checkPasword,@RequestParam("numberDealer")
                String numberDealer,@RequestParam("nameDealer") String nameDealer,@RequestParam("email") String email,
                @RequestParam("name") String name,@RequestParam("personPhone")String personPhone,
                @RequestParam("city")String city) {

        String returnMassege;
        DealerDao dealerDao = new DealerDao();
       try{ if (pasword.equals(checkPasword)){
            returnMassege= dealerDao.setDealer(numberDealer, nameDealer,email,name,personPhone,pasword,city);

        }
        else {
            returnMassege = StandartMasege.getMessage(6);
        }
        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", StandartMasege.getMessage(7) +" "+ name + " " + returnMassege);
        return model;}
        catch (NumberFormatException e){

           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", StandartMasege.getMessage(8));
           return model1;
        }
    }

@RequestMapping(value = "/ConfirmationOfRegistration", method = RequestMethod.GET)
public  ModelAndView registrationComp(@RequestParam("id") String idDealer){
    DealerDao dealerDao = new DealerDao();
    String msg;
    ModelAndView model;
    if(dealerDao.updateRegistrationAndRoleById(idDealer))
    {
        model = new ModelAndView("successfulRegistration");
        msg=StandartMasege.getMessage(9);
        model.addObject("msg",msg );
    }
    else {

        model=new ModelAndView("zerroPage");
    }

    return model;
}
    @RequestMapping(value = "/myAccount")
    public ModelAndView accountModel(){
            ModelAndView modelAndView = new ModelAndView("my_account");
            return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/feedback")
    public ModelAndView getFeedbackForm(){
        ModelAndView modelAndView = new ModelAndView("feedback");
        return modelAndView;
    }

    @RequestMapping(value = "/carPage",method = RequestMethod.GET)
    public ModelAndView getDealer(@RequestParam ("idCar") String idCar){
        ModelAndView modelAndView= new ModelAndView("auto");
        Car car=null;
        CarDAO carDAO =new CarDAO();
        if(!idCar.isEmpty()){
            car=carDAO.getCarById(idCar);
            DealerDao dealerDao=new DealerDao();
            modelAndView.addObject("car", car);
            modelAndView.addObject("dealer",dealerDao.getDealerById(car.getIdDealer()));
        }


        return modelAndView;
    }
    @RequestMapping(value = "/change_contact_person", method = RequestMethod.POST)
    public ModelAndView changeContactPersonsData(@RequestParam("manager") String manager,@RequestParam("phone") String phone,
                                                 @RequestParam("id") Integer idPerson, @RequestParam("email") String email){
        System.out.println(idPerson);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        Contact_person contact_person = new Contact_person();
        DealerDao dealerDao= new DealerDao();
        if(!manager.isEmpty()){contact_person.setName(manager);}
        if(!phone.isEmpty()){contact_person.setPhone(phone);}
        if(!email.isEmpty()){contact_person.setEmail(email);}
        dealerDao.changeContactPersonsData(idDealer, idPerson, contact_person);
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/add_contact_person", method = RequestMethod.POST)
    public ModelAndView addContactPersonsData(@RequestParam("manager") String manager,@RequestParam("phone") String phone,
                                                 @RequestParam("email") String email){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        Contact_person contact_person = new Contact_person();
        DealerDao dealerDao= new DealerDao();
        if(!manager.isEmpty()){contact_person.setName(manager);}
        if(!phone.isEmpty()){contact_person.setPhone(phone);}
        if(!email.isEmpty()){contact_person.setEmail(email);}
        dealerDao.changeContactPersonsData(idDealer, null, contact_person);
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }
    @RequestMapping(value = "/delete_contact_person", method = RequestMethod.GET)
    public ModelAndView deleteContactPerson(@RequestParam("count")Integer idPerson,HttpSession session){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        DealerDao dealerDao= new DealerDao();
        if(idPerson!=null){
        dealerDao.deleteContactPersonById(idDealer,idPerson);
        }
        ModelAndView modelAndView = new ModelAndView("my_account");
        return ViewHalper.addingDealerAndCarsInView(modelAndView);
    }
}
