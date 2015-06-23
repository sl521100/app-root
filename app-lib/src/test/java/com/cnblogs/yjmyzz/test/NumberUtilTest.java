package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.utils.NumberUtil;
import org.junit.Test;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Created by jimmy on 2015/2/4.
 */
public class NumberUtilTest {

    @Test
    public void testFormatter(){
        System.out.println(NumberUtil.formatNumber(10000102.3355));
    }


    @Test
    public void testScale(){
        double d = 301353.05;
        BigDecimal decimal = new BigDecimal(d);
        //System.out.println(decimal);//301353.0500000001047737896442413330078125
        //System.out.println(decimal.setScale(1, RoundingMode.HALF_UP));//301353.1
        System.out.println(NumberUtil.setScale(decimal,1));//301353.1
    }
}
