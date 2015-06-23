package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.utils.ListUtil;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jimmy on 2015/1/30.
 */
public class ListUtilTest {

    @Test
    public void test(){
        List<String> list = new ArrayList<String>();

        list.add("a");
        list.add("b");
        list.add("c");
        list.add("d");

        System.out.println(ListUtil.getString(list, ","));
    }
}
