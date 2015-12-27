package com.springapp.mvc;

import dao.DealerDao;
import dao.LoginDao;
import dao.configuration.files.HibernateUtil;
import modelClass.Dealer;
import modelClass.Login;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Эдуард on 07.11.15.
 */
@Controller
@SessionAttributes("login")

public class UserController {
    private ModelAndView checkLogin(Login login){
        LoginDao loginDao = new LoginDao();
        if(loginDao.checkLogin(login)) {

            ModelAndView model3 = new ModelAndView("myAccount");
            Dealer dealer = new Dealer();
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            dealer = session.get(Dealer.class, login.getIdDealer());


            model3.addObject("HelloMessage", "Это ваш акаунт где вы можете добавить или убрать авто. Так же просмотреть количество просмотров авто.");
            model3.addObject("dealer",dealer);
            return model3;
        }
        else{
            ModelAndView model3 = new ModelAndView("checkLogin");
            model3.addObject("msg", "<h2>Пароль или пользователь не верен!</h2>");

            return model3;
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
                                     @RequestParam("name") String name,@RequestParam("personPhone")String personPhone){

        String returnMassege;
        DealerDao dealerDao = new DealerDao();
       try{ if (pasword.equals(checkPasword)){
            returnMassege= dealerDao.setDealer(numberDealer, nameDealer,email,name,personPhone,pasword);


        }

        else {
            returnMassege = "Проверте пароль!!!";
        }


        ModelAndView model = new ModelAndView("successfulRegistration");
        model.addObject("msg", "Здравствуйте " + name + " " + returnMassege);
        return model;}
       catch (NumberFormatException e){
//           returnMassege="Вы ввели не допустимое поле номер диллера!";
           ModelAndView model1 = new ModelAndView("registration");
           model1.addObject("msg", "Поле 'Номер диллера'! Только цифры!");
           return model1;
       }
    }
    @RequestMapping(value = "/clinSes")
    public ModelAndView getRegistrationForm(HttpServletRequest request){
        HttpSession newsession = request.getSession(false);
        if (newsession != null)
        {
            newsession.invalidate();

        }

        return new ModelAndView("index");
    }
    @RequestMapping(value = "/checkLogin")
    public ModelAndView getLoginForm(HttpSession httpSession){

    Login login = (Login)httpSession.getAttribute("login");

        if(login==null){
        ModelAndView modelAndView = new ModelAndView("checkLogin");
        modelAndView.addObject("msg","<h1>Welcome<h1>");
        return modelAndView;}
        else {return checkLogin(login);}
    }

    @RequestMapping(value = "/checkLogin",method = RequestMethod.POST)
    public ModelAndView checkUserData(@RequestParam("user") String user,@RequestParam("password") String password,HttpSession httpSession){
if(user.isEmpty()||password.isEmpty()){
    ModelAndView model3 = new ModelAndView("checkLogin");
    model3.addObject("msg", "<h2>Пароль или пользователь не верен!</h2>");

    return model3;
}
        else {
        LoginDao loginDao = new LoginDao();
        Login login = new Login();
    try {
        login.setIdDealer(new Long(user));
    }
      catch (NumberFormatException r){

          ModelAndView model1 = new ModelAndView("/checkLogin");
          model1.addObject("msg", "<h3>Номер диллера может быть только цифры!</h3>");
          return model1;
      }
        login.setPassword(password);
       httpSession.setAttribute("login",login);
       return checkLogin(login);
}


    }
}
