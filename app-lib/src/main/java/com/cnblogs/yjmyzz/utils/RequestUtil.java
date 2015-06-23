package com.cnblogs.yjmyzz.utils;


import javax.servlet.http.HttpServletRequest;

import com.cnblogs.yjmyzz.consts.SsoConsts;
import com.cnblogs.yjmyzz.domain.BaseBean;

public class RequestUtil extends BaseBean {

    private RequestUtil() {
        //工具类无需对象实例化
    }

    /**
     * 返回请求的完整URL(去掉&md=xxx的部分)
     *
     * @param request
     * @return
     */
    public static String getRequestUrl(HttpServletRequest request) {
        return request.getRequestURL().toString()
                + "?"
                + request.getQueryString().replaceAll(
                "&" + SsoConsts.HASH_URL_PARAMETER_NAME + "=\\w+$", "");
    }


    /**
     * 获取当前请求的基地址（例如：http://localhost:8080/ctas/xxx.do 返回 http://localhost:8080/ctas/）
     *
     * @param request
     * @return
     */
    public static String getBaseUrl(HttpServletRequest request) {
        return request.getRequestURL().substring(0,
                request.getRequestURL().indexOf(request.getContextPath()) + request.getContextPath().length()) + "/";
    }

}
