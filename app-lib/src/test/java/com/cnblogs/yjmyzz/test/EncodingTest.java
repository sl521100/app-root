package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.utils.EncodingUtil;
import org.junit.Test;

/**
 * Created by jimmy on 2015/2/12.
 */
public class EncodingTest {

    @Test
    public void test() {
        EncodingUtil parse = new EncodingUtil();


        System.out.println("中国大陆：");
        System.out.println("测试字符串，编码格式=" + parse.getEncoding("百度".getBytes()));
        System.out.println("测试站点，编码格式=" + parse.getEncoding("http://www.baidu.com"));
        System.out.println();
        System.out.println("中国台湾：");
        System.out.println("测试字符串，编码格式=" + parse.getEncoding("い地チ瓣".getBytes()));
        System.out.println("测试站点，编码格式=" + parse.getEncoding("http://tw.yahoo.com/"));
        System.out.println("测试站点(繁体字，UTF编码)，编码格式=" + parse.getEncoding("http://www.javaworld.com.tw/jute"));
        System.out.println();
        System.out.println("日本：");
        System.out.println("测试字符串，编码格式=" + parse.getEncoding("その機能".getBytes()));
        System.out.println("测试站点，编码格式=" + parse.getEncoding("http://www.4gamer.net"));
        System.out.println();
        System.out.println("自称蚩尤后代那群……：");
        System.out.println("测试站点，编码格式=" + parse.getEncoding("http://www.easyjava.co.kr/"));
    }
}
