package com.cnblogs.yjmyzz.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;

import java.net.UnknownHostException;


public final class NetworkUtil extends BaseBean {

    /**
     * 获取主机IP地址
     *
     * @return
     */
    public static String getHostAddress() {
        try {
            return java.net.InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            e.printStackTrace();
            logger.error("NetworkUtil.getHostAddress error:", e);
        }
        return "";
    }

    /**
     * 获取主机计算机名
     *
     * @return
     */
    public static String getHostName() {
        try {
            return java.net.InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            e.printStackTrace();
            logger.error("NetworkUtil.getHostName error:", e);
        }
        return "";
    }


}
