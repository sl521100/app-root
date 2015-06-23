package com.cnblogs.yjmyzz.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Locale;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.format.number.NumberFormatter;
import org.springframework.util.StringUtils;

public class NumberUtil extends BaseBean {

    private NumberUtil() {
        //工具类无需对象实例化
    }

    @SuppressWarnings("unchecked")
    public static <T extends Number> T parseNumber(String text,
                                                   Class<T> targetClass) {
        if (StringUtils.isEmpty(text)) {
            return null;
        }
        Number n = null;
        try {
            n = org.springframework.util.NumberUtils.parseNumber(text,
                    targetClass);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return (T) n;
    }

    public static long getLongValue(Long v) {
        if (v == null) {
            return 0;
        }
        return v.longValue();
    }

    public static long getLongValue(BigDecimal v) {
        if (v == null) {
            return 0;
        }
        return v.longValue();
    }

    public static int getIntValue(BigDecimal b) {
        if (b == null) {
            return 0;
        }
        return b.intValue();
    }

    public static int getIntValue(Integer b) {
        if (b == null) {
            return 0;
        }
        return b.intValue();
    }

    public static double getDoubleValue(Double b) {
        if (b == null) {
            return 0;
        }
        return b.doubleValue();
    }

    public static double getDoubleValue(BigDecimal b) {
        if (b == null) {
            return 0;
        }
        return b.doubleValue();
    }

    public static BigDecimal getBiDecimal(String s) {
        if (StringUtils.isEmpty(s)) {
            return null;
        }
        return new BigDecimal(s);
    }

    public static Long getLongValue(BigDecimal b, Boolean nullToZero) {
        if (b == null) {
            if (nullToZero) {
                return 0L;
            }
            return null;
        }
        return b.longValue();
    }

    /**
     * 数字格式化
     *
     * @param num
     * @param pattern 比如：#,###.00
     * @param locale
     * @return
     */
    public static String formatNumber(Number num, String pattern, Locale locale) {
        if (num == null) {
            return null;
        }
        NumberFormatter formatter = new NumberFormatter();
        formatter.setPattern(pattern);
        return formatter.print(num, locale);
    }

    public static String formatNumber(Number num, String pattern) {
        if (num == null) {
            return null;
        }
        NumberFormatter formatter = new NumberFormatter();
        formatter.setPattern(pattern);
        return formatter.print(num, Locale.SIMPLIFIED_CHINESE);
    }

    public static double setScale(Double b, int scale) {
        if (b == null) {
            return 0;
        }
        return setScale(b.doubleValue(), scale);
    }

    public static double setScale(BigDecimal b, int scale) {
        if (b == null) {
            return 0;
        }
        return setScale(b.doubleValue(), scale);
    }

    public static double setScale(double b, int scale) {
        BigDecimal decimal = new BigDecimal(b);
        return decimal.setScale(scale+1, RoundingMode.HALF_UP).setScale(scale, RoundingMode.HALF_UP).doubleValue();
    }

    /**
     * 数字格式化
     *
     * @param num
     * @return
     */
    public static String formatNumber(Number num) {
        return formatNumber(num, "#.##", Locale.SIMPLIFIED_CHINESE);
    }

}
