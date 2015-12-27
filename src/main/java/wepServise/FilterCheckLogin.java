package wepServise;

import dao.LoginDao;
import modelClass.Login;
import org.apache.catalina.filters.FilterBase;
import org.apache.juli.logging.Log;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Эдуард on 29.09.15.
 */
public class FilterCheckLogin extends FilterBase {
    @Override
    protected Log getLogger() {
        return null;
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        String user = servletRequest.getParameter("user");
        String password = servletRequest.getParameter("password");
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (user != null && !user.isEmpty() && password != null && !password.isEmpty()) {
            LoginDao loginDao = new LoginDao();
            Login login = new Login();
            login.setPassword(password);
//            login.setIdLogin(new Long(user));
            if(loginDao.checkLogin(login)) {
//                request.getSession().setAttribute("login",loginDao.getLoginForIdLogin(login.getidDealer()));
                filterChain.doFilter(servletRequest,servletResponse);
            }
            else {
                request.getSession().setAttribute("my2", "Вам необходимо зарегестрироваться");
                response.sendRedirect("/registration.jsp");}
        }
        else {
            request.getSession().setAttribute("my3", "Вы оставили пустое поле.");
            response.sendRedirect("/checkLogin.jsp");
        }
    }



}
