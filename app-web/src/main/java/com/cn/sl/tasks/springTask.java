package com.cn.sl.tasks;

import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by shilin on 2015/6/23.
 */
public class springTask {
    @Scheduled(cron="0/5 * * * * ?")
    public void singing(){
        Date date=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println("spring定时操作："+ sdf.format(date));
    }
}
