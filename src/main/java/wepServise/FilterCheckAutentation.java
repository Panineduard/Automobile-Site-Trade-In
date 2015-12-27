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
 * Created by Эдуард on 02.10.15.
 */
public class FilterCheckAutentation extends FilterBase{
    @Override
    protected Log getLogger() {
        return null;
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        LoginDao loginDao = new LoginDao();
        Login login =(Login)request.getSession().getAttribute("login");
        if(loginDao.checkLogin(login)){
            filterChain.doFilter(servletRequest,servletResponse);
        }
        else {

            request.getSession().setAttribute("my3", "Перерегестрируйтесь еще раз.");
            response.sendRedirect("/checkLogin.jsp");
        }
    }
}
