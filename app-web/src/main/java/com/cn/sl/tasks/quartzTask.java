package com.cn.sl.tasks;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by shilin on 2015/6/23.
 */
public class quartzTask extends BaseBean{

    public void execute() throws Exception{

        Date date=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String msg="quartz定时操作："+ sdf.format(date);
        System.out.println(msg);
        logger.info(msg);
    }


}
