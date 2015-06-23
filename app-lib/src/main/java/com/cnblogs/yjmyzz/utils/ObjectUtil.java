package com.cnblogs.yjmyzz.utils;

import java.math.BigDecimal;

import com.cnblogs.yjmyzz.domain.BaseBean;

public class ObjectUtil extends BaseBean {

    private ObjectUtil() {
        //工具类无需对象实例化
    }

    public static String getStringValue(Object o) {
        if (o == null) {
            return null;
        }
        return o.toString();
    }

    public static String getStringValue(Object o, String defaultValue) {
        if (o == null) {
            if (defaultValue != null) {
                return defaultValue;
            }
            return null;
        }
        return o.toString();
    }
}
