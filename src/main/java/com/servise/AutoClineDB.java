package com.servise;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/**
 * Created by volkswagen1 on 11.01.2016.
 */
public class AutoClineDB {
    private final ScheduledExecutorService scheduler =
            Executors.newScheduledThreadPool(1);
    public void beepForAnHour() {
        final Runnable beeper = new Runnable() {
            public void run() { System.out.println("beep"); }
        };
        final ScheduledFuture<?> beeperHandle =
                scheduler.scheduleAtFixedRate(beeper, 10, 10, TimeUnit.SECONDS);
//        scheduler.schedule(new Runnable() {
//            public void run() { beeperHandle.cancel(true); }
//        }, 60 * 60, TimeUnit.SECONDS);
    }
}
