package com.controllers;

import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.Scheduled;

import java.util.Date;
import java.util.concurrent.ScheduledFuture;


/**
 * Created by volkswagen1 on 12.01.2016.
 */
public class CleanDBTaskExecutor {

//    @Scheduled(cron="*/5 * * * * ?")
    public void serviceMethod()
    {
        System.out.println("Method executed at every 5 seconds. Current time is :: "+ new Date());
    }

}
