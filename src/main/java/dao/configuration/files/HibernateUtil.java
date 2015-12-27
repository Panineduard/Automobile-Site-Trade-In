package dao.configuration.files;

import org.hibernate.SessionFactory;
import org.hibernate.TransientObjectException;
import org.hibernate.cfg.Configuration;


/**
 * Created by ������ on 05.09.15.
 */
public class HibernateUtil {


    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            // Create the SessionFactory from hibernate.cfg.xml
            return new Configuration().configure().buildSessionFactory();
        }
        catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }



//    private static SessionFactory sessionFactory;
//    private HibernateUtil(){}
//    static {
//       try {
//           sessionFactory = new Configuration().configure().buildSessionFactory();
//       }
//       catch (Throwable e)       {throw new ExceptionInInitializerError(e);}
//
//    }

//    public static SessionFactory getSessionFactory() {
//        return sessionFactory;
//    }
}
