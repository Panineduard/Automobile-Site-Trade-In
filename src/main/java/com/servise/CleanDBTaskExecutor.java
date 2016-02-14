package com.servise;

import com.dao.DealerDao;
import com.modelClass.Dealer;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ScheduledFuture;


/**
 * Created by volkswagen1 on 12.01.2016.
 */
public class CleanDBTaskExecutor {

//    @Scheduled(cron="*/5 * * * * ?")
    public void serviceMethod()
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
        System.out.println("hello");
    }
}
