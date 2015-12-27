package wepServise;

import dao.DealerDao;
import dao.InputDB_Data;
import dao.configuration.files.HibernateUtil;
import modelClass.Contact_person;
import modelClass.Dealer;
import modelClass.Login;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 16.09.15.
 */
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/html;charset=utf-8");
        if(req.getParameter("name")==null){
            req.setAttribute("my1", "req");
            req.getSession().setAttribute("my2", "Вы перешли на страницу регистрации");
            getServletContext().getRequestDispatcher("/registration.jsp").forward(req, resp);
        }

    }


    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        String returnMassege=null;
        DealerDao dealerDao = new DealerDao();
        if (req.getParameter("pasword").equals(req.getParameter("checkPasword"))){
//           returnMassege= dealerDao.setDealer(req.getParameter("numberDealer"), req.getParameter("nameDealer"), req.getParameter("phone"),
//                    req.getParameter("personPhone"), req.getParameter("email"), req.getParameter("name"), req.getParameter("lastname"),
//                    req.getParameter("firsname"),req.getParameter("pasword") );
        }

        else {
            returnMassege = "Проверте пароль!!!";
        }

        req.getSession().setAttribute("my2", returnMassege);

        getServletContext().getRequestDispatcher("/registration.jsp").forward(req, resp);

    }


}
