package com.servise;

import com.dao.CarDAO;
import com.dao.DealerDao;
import com.email.SendHTMLEmail;
import com.modelClass.Dealer;
import com.setting.Setting;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.ScheduledFuture;


/**
 * Created by volkswagen1 on 12.01.2016.
 */
public class TaskExecutorClass {

//    @Scheduled(cron="*/5 * * * * ?")
    public void cleanDbWithoutAuth()
    {
        DealerDao dealerDao =new DealerDao();
        dealerDao.getIdDealersWithoutAuth()
                .stream()
                .filter(n ->LocalDateTime.ofInstant(Instant.ofEpochMilli(n.getDateRegistration()
                        .getTime()), ZoneId.systemDefault()).isBefore(LocalDateTime.now().minusDays(1)))
                .forEach(n -> dealerDao.deleteLoginAndDealerById(n.getNumberDealer()) );

    }
    public  void sendEmailToOwnersOldCars()
    {
        String message="<a href='"+ Setting.getHost()+"/myAccount'>"+StandartMasege.getMessage(31)+"</a>" +
                "<h2>"+StandartMasege.getMessage(33)+"</h2>";
        CarDAO carDAO=new CarDAO();
        HashSet<String> emails= carDAO.getOldCarOwnersEmails(1);
        System.out.println(emails);
        emails.forEach(e-> SendHTMLEmail.sendHtmlMessage(e,message,StandartMasege.getMessage(32)));
    }
    public void deleteOldCar(){
    CarDAO carDAO=new CarDAO();
        carDAO.deleteOldCar(3);
    }
}
