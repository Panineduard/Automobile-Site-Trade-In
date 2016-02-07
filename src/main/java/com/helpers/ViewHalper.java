    package com.helpers;


    import com.dao.configuration.files.HibernateUtil;
    import com.modelClass.Car;
    import com.modelClass.Dealer;
    import org.hibernate.Query;
    import org.hibernate.Session;
    import org.hibernate.Transaction;
    import org.springframework.security.core.Authentication;
    import org.springframework.security.core.context.SecurityContextHolder;
    import org.springframework.web.servlet.ModelAndView;

    import java.util.List;

    /**
     * Created by Эдуард on 25.12.15.
     */
    public class ViewHalper {
        public static ModelAndView addingDealerAndCarsInView(ModelAndView view){
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String idDealer = auth.getName();
//            System.out.println("ID DEALER FROM AUTH"+idDealer);
            Session session = HibernateUtil.getSessionFactory().openSession();
            Transaction tr=session.beginTransaction();
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
            catch (Exception e){
                if(tr!=null)tr.rollback();
                cars=null;
            }
            view.addObject("dealer",dealer);
            view.addObject("cars", cars);
            return view;

        }
    }
