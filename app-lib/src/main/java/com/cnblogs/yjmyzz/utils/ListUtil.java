package com.cnblogs.yjmyzz.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.springframework.util.StringUtils;

import java.util.*;

public class ListUtil extends BaseBean {

    private ListUtil() {
        //工具类无需对象实例化
    }

    /**
     * 二分法查询
     *
     * @param A          待查找的List(必须已经按关键属性排好序)
     * @param x          待查找的元素
     * @param comparator 比较器
     * @param <T>
     * @return
     */
    public static <T> List<T> binarySearch(List<T> A, T x, Comparator<? super T> comparator) {
        List<T> result = new ArrayList<T>();
        int low = 0, high = A.size() - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int temp = comparator.compare(x, A.get(mid));
            if (temp == 0) {
                if (mid > 0) {
                    if (comparator.compare(x, A.get(mid - 1)) == 0) {
                        for (int i = mid - 1; i >= 0; i--) {
                            if (comparator.compare(A.get(i), x) == 0) {
                                result.add(A.get(i));
                            } else break;
                        }
                    }
                }
                result.add(A.get(mid));
                if (mid < high) {
                    if (comparator.compare(x, A.get(mid + 1)) == 0) {
                        for (int i = mid + 1; i <= high; i++) {
                            if (comparator.compare(x, A.get(i)) == 0) {
                                result.add(A.get(i));
                            } else break;
                        }
                    }
                }
                return result;

            } else if (temp < 0) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return result;
    }

    /**
     * 将list中的元素拼接成字符串
     *
     * @param list
     * @param joinStr 各元素之间的连接字符
     * @return
     */
    public static String getString(List<?> list, String joinStr) {
        if (list == null) {
            return "";
        }
        if (StringUtils.isEmpty(joinStr)) {
            joinStr = " ";
        }
        StringBuilder sb = new StringBuilder();
        for (Object o : list) {
            sb.append(o.toString() + joinStr);
        }

        String s = sb.toString();
        if (s.endsWith(joinStr)) {
            s = s.substring(0, s.length() - joinStr.length());

        }
        return s;
    }

    /**
     * 将字符串转换成List
     *
     * @param src   目标字符串，比如"A,B,C,D"
     * @param split 分割字符串，比如","
     * @return
     */
    public static List<String> getList(String src, String split) {
        if (StringUtils.isEmpty(src)) {
            return null;
        }
        String[] _ = src.split(split);
        List<String> list = new ArrayList<String>();
        for (String s : _) {
            list.add(s);
        }
        return list;
    }

    /**
     * 将list按元素的指定属性分拆成Map结构
     *
     * @param list
     * @param keyPropertyName
     * @param <T>
     * @return
     */
    public static <T> Map<String, List<T>> getMapByKeyProperty(List<T> list, String keyPropertyName) {
        if (list == null && list.size() <= 0) {
            return null;
        }

        Map<String, List<T>> mapResult = new HashMap<String, List<T>>();

        for (int i = 0; i < list.size(); i++) {
            T item = list.get(i);
            String key = ReflectionUtil.getFieldValue(item, keyPropertyName).toString();
            if (mapResult.containsKey(key)) {
                List<T> t = mapResult.get(key);
                t.add(item);
            } else {
                List<T> t = new ArrayList<T>();
                t.add(item);
                mapResult.put(key, t);
            }
        }
        return mapResult;
    }

}
