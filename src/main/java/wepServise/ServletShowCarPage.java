package wepServise;

import dao.CarDAO;
import modelClass.Car;
import modelClass.Login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Эдуард on 09.10.15.
 */
public class ServletShowCarPage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        if(req.getSession().getAttribute("login")==null){
            req.getSession().setAttribute("my3", "Не правильные данные");
            response.sendRedirect("/checkLogin.jsp");
        }
        Integer id = new Integer(req.getParameter("idCar"));
//        Long idFoundDealer= ((Login) req.getSession().getAttribute("login")).getidDealer();

        CarDAO carDAO = new CarDAO();
        List<Car> cars = new ArrayList<Car>();
//        cars=carDAO.getCarByIdDealer(idFoundDealer);
        Car car = cars.get(id);
        req.setAttribute("foundCar",car);
        response.sendRedirect("/showCarPage.jsp");
            }


    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");

    }
}
