    package servise;


    import dao.CarDAO;
    import dao.configuration.files.HibernateUtil;
    import modelClass.Car;
    import modelClass.Dealer;
    import modelClass.Login;
    import org.hibernate.Query;
    import org.hibernate.Session;
    import org.springframework.web.servlet.ModelAndView;

    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpSession;
    import java.util.List;

    /**
     * Created by Эдуард on 25.12.15.
     */
    public class ViewHalper {
        public static ModelAndView addingDealerAndCarsInView(ModelAndView view,HttpServletRequest request){
            Login login = (Login)request.getSession().getAttribute("login");
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String idDealer = login.getIdDealer();
            Dealer dealer= session.get(Dealer.class, idDealer);
            List<Car> cars;
            try {
                Query query = session.createQuery("from Car car where car.idDealer = :code ");
                query.setParameter("code", idDealer);
                List list = query.list();
                cars=list;
            }
            catch (NullPointerException n){
                cars=null;
            }
            view.addObject("dealer",dealer);
            view.addObject("cars", cars);
            return view;

        }
    }
