package com.controllers;

import com.dao.AdminServiceDAO;
import com.dao.AnonymousUserDAO;
import com.dao.CarDAO;
import com.dao.DealerDao;

import com.helpers.EncoderId;
import com.helpers.PasswordHelper;
import com.helpers.SearchOptions;
import com.modelClass.*;
import com.servise.SendHTMLEmail;
import com.servise.StandartMasege;
import com.setting.Setting;
import com.sun.deploy.net.HttpResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;
import sun.plugin.liveconnect.SecurityContextHelper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * Created by Эдуард on 07.11.15.
 */
@Controller
@SessionAttributes("login")
public class UserController {
    @Autowired
    EncoderId encoderId;
    @Autowired
    SendHTMLEmail sendHTMLEmail;
    @Autowired
    StandartMasege standartMasege;
    @Autowired
    DealerDao dealerDao;
    @Autowired
    CarDAO carDAO;
    @Autowired
    ViewHalper viewHalper;
    @Autowired
    AdminServiceDAO adminServiceDAO;
    @Autowired
    AnonymousUserDAO anonymousUserDAO;


//Methods for all users
    @RequestMapping(value = "/lost_password", method = RequestMethod.GET)
    public ModelAndView getLostPassword(HttpServletRequest request){
        String key=request.getParameter("key");
        if(key==null){return new ModelAndView("lost_password");}
        KeyHolder keyHolder=dealerDao.getKeyDHolderByKeyAndDeleteKey(key);
        if(keyHolder!=null){
            dealerDao.changePasswordByIdDealer(keyHolder.getIdDealer(), keyHolder.getPass());
            ModelAndView modelAndView = new ModelAndView("successfulRegistration");
            modelAndView.addObject("msg", standartMasege.getMessage(39));
            return modelAndView;
        }
        else {return new ModelAndView("index");}

    }
    @RequestMapping(value = "/lost_password", method = RequestMethod.POST)
    public ModelAndView changeLostPassword(@RequestParam("dealers_number")String dealers_number,@RequestParam("email")String email,@RequestParam("password")String password){
        if(email==null||password==null){
            return new ModelAndView("index");
        }
            ;
            if(dealerDao.checkIdDealerByEmail(email,dealers_number)){
                String key=DigestUtils.md5Hex(dealers_number+System.currentTimeMillis() + new Random().nextInt());
                PasswordHelper passwordHelper=new PasswordHelper();
                dealerDao.setKeyHolder(new KeyHolder(dealers_number,key,passwordHelper.encode(password)));
                String msg ="<a href='"+ Setting.getHost()+"/lost_password?key="+key+"'>"+standartMasege.getMessage(35)+"</a>";
                sendHTMLEmail.sendHtmlMessage(email, msg, standartMasege.getMessage(36));
                ModelAndView modelAndView = new ModelAndView("successfulRegistration");
                modelAndView.addObject("msg",standartMasege.getMessage(37));
                return modelAndView;
            }
            else {
                ModelAndView modelAndView = new ModelAndView("successfulRegistration");
                modelAndView.addObject("msg","<a href = '/registration'>"+standartMasege.getMessage(38)+"</a>");
                return modelAndView;
            }

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
    String msg;
    ModelAndView model;
    if(dealerDao.updateRegistrationAndRoleById(idDealer))
    {
        model = new ModelAndView("successfulRegistration");
        msg=standartMasege.getMessage(9)+"<br><ul id='menu'><li><a href='/myAccount'>"+standartMasege.getMessage(3)+"</a></li></ul>";
        model.addObject("msg",msg );
    }
    else {
        model=new ModelAndView("zerroPage");
    }
    return model;
}

    @RequestMapping(value = "/save_message",method = RequestMethod.POST)
    public ModelAndView saveMessage(@RequestParam("email")String email,@RequestParam("message")String message){

        String checkEmail1 = "[a-z][a-z[0-9]\u005F\u002E\u002D]*[a-z||0-9]";
        String checkEmail2 = "([a-z]){2,4}";
        if(email.matches(checkEmail1 + "@" + checkEmail1 + "\\u002E" + checkEmail2)){
            if(message.length()>380){
                message=message.substring(0,380);
            }
            anonymousUserDAO.saveLetter(new Letter(email, message));
        }
        return new ModelAndView("index");

}
@RequestMapping(value = "/about_us",method = RequestMethod.GET)
public ModelAndView getAboutUsPage(){
    return new ModelAndView("about-us-page");
}


    //Methods for registration users

    @RequestMapping(value = {"/myAccount","*/myAccount"})
    public ModelAndView accountModel(HttpSession session){
            session.removeAttribute("chCar");
            ModelAndView modelAndView = new ModelAndView("my_account");
            return viewHalper.addingDealerAndCarsInView(modelAndView);
    }

    @RequestMapping(value = "/feedback")
    public ModelAndView getFeedbackForm(){
        ModelAndView modelAndView = new ModelAndView("feedback");
        return modelAndView;
    }


    @RequestMapping(value = "*/change_contact_person", method = RequestMethod.POST)
    public ModelAndView changeContactPersonsData(@RequestParam("manager") String manager,@RequestParam("phone") String phone,
                                                 @RequestParam("id") Integer idPerson, @RequestParam("email") String email){

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        Contact_person contact_person = new Contact_person();
        contact_person.setIdDealer(idDealer);
        if(!manager.isEmpty()){contact_person.setName(manager);}
        if(!phone.isEmpty()){contact_person.setPhone(phone);}
        if(!email.isEmpty()){contact_person.setEmail(email);}
        dealerDao.changeContactPersonsData(idDealer, idPerson, contact_person);
        ModelAndView modelAndView = new ModelAndView("my_account");
        return viewHalper.addingDealerAndCarsInView(modelAndView);
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
        return viewHalper.addingDealerAndCarsInView(modelAndView);
    }
    @RequestMapping(value = "*/delete_contact_person", method = RequestMethod.GET)
    public ModelAndView deleteContactPerson(@RequestParam("count")String id ,HttpSession session){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer=auth.getName();
        Integer idPerson = new Integer(encoderId.decodeID(id));
        if(idPerson!=null){
        dealerDao.deleteContactPersonById(idDealer,idPerson);
        }
        ModelAndView modelAndView = new ModelAndView("my_account");
        return viewHalper.addingDealerAndCarsInView(modelAndView);
    }
}
