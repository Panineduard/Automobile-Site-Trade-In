package com.servise;

import com.dao.CarDAO;
import com.dao.DealerDao;
import com.setting.Setting;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashSet;


/**
 * Created by volkswagen1 on 12.01.2016.
 */
public class TaskExecutorClass {
    @Autowired
    StandartMasege standartMasege;
    @Autowired DealerDao dealerDao;

//    @Scheduled(cron="*/5 * * * * ?")
    public void cleanDbWithoutAuth()
    {
        dealerDao.getIdDealersWithoutAuth()
                .stream()
                .filter(n ->LocalDateTime.ofInstant(Instant.ofEpochMilli(n.getDateRegistration()
                        .getTime()), ZoneId.systemDefault()).isBefore(LocalDateTime.now().minusDays(1)))
                .forEach(n -> dealerDao.deleteLoginAndDealerById(n.getNumberDealer()) );
        dealerDao.deleteOldKeyHolders();

    }
    public  void sendEmailToOwnersOldCars()
    {
        String message="<a href='"+ Setting.getHost()+"/myAccount'>"+standartMasege.getMessage(31)+"</a>" +
                "<h2>"+standartMasege.getMessage(33)+"</h2>";
        CarDAO carDAO=new CarDAO();
        HashSet<String> emails= carDAO.getOldCarOwnersEmails(1);
        System.out.println(emails);
        emails.forEach(e-> new SendHTMLEmail().sendHtmlMessage(e, message, standartMasege.getMessage(32)));
    }
    public void deleteOldCar(){
    CarDAO carDAO=new CarDAO();
        carDAO.deleteOldCar(3);
    }
}
