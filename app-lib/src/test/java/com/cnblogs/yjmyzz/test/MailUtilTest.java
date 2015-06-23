package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.utils.MailUtil;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Properties;

/**
 * Created by jimmy on 2015/2/12.
 */
public class MailUtilTest {

    @Test
    public void testSendMail() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-context.xml");
        MailUtil mailUtil = ctx.getBean(MailUtil.class);
        mailUtil.sendHtmlMail("数据导入出错！", "<font color=red>错误:</font><h1>数据导入发生错误！</h1><b>不要紧张，只是测试mail代码发送！</b>");
        ((ClassPathXmlApplicationContext) ctx).close();
    }
}
