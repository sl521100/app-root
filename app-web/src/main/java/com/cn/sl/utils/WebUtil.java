package com.cn.sl.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;
import com.cnblogs.yjmyzz.utils.RequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;


@Component
public final class WebUtil extends BaseBean {

    private static String VERSION = "1.0";

    private static String REPORT_BASE_URL = "";



    @PostConstruct
    public void init() {

    }

    /**
     * 向页面添加css
     *
     * @param cssPath
     * @return
     */
    public static String addCss(String cssPath) {
        try {
            if (RequestContextHolder.getRequestAttributes() != null) {
                ServletRequestAttributes servletRequestAttributes = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
                if (servletRequestAttributes != null) {
                    HttpServletRequest request = servletRequestAttributes.getRequest();
                    return "<link rel=\"Stylesheet\" type=\"text/css\" href=\"" + RequestUtil.getBaseUrl(request) + cssPath + "?v=" + VERSION + "\" />";
                }
            }
            return "<link rel=\"Stylesheet\" type=\"text/css\" href=\"" + cssPath + "?v=" + VERSION + "\" />";
        } catch (Exception e) {
            logger.error("addCss Error:", e);
        }
        return "";
    }

    /**
     * 向页面添加javascript
     *
     * @param jsPath
     * @return
     */
    public static String addJs(String jsPath) {
        try {
            if (RequestContextHolder.getRequestAttributes() != null) {
                ServletRequestAttributes servletRequestAttributes = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
                if (servletRequestAttributes != null) {
                    HttpServletRequest request = servletRequestAttributes.getRequest();
                    return "<script type=\"text/javascript\" src=\"" + RequestUtil.getBaseUrl(request) + jsPath + "?v=" + VERSION + "\"></script>";
                }
            }
            return "<script type=\"text/javascript\" src=\"" + jsPath + "?v=" + VERSION + "\"></script>";
        } catch (Exception e) {
            logger.error("addJs Error:", e);
        }
        return "";
    }

    /**
     * 获取基路径（类似http://localhost:8080/ctas/）
     *
     * @return
     */
    public static String getBaseUrl() {
        try {
            if (RequestContextHolder.getRequestAttributes() != null) {
                ServletRequestAttributes servletRequestAttributes = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
                if (servletRequestAttributes != null) {
                    HttpServletRequest request = servletRequestAttributes.getRequest();
                    return RequestUtil.getBaseUrl(request);
                }
            }
        } catch (Exception e) {
            logger.error("getBaseUrl Error:", e);
        }
        return "";
    }

//    public static boolean endsWith(String src, String endStr) {
//        return src.endsWith(endStr);
//    }
//
//    public static boolean startWith(String src, String startStr) {
//        return src.startsWith(startStr);
//    }
//
//    public static boolean contain(String src, String targetSrc) {
//        return src.contains(targetSrc);
//    }
//
//    public static int indexOf(String src, String targetSrc) {
//        return src.indexOf(targetSrc);
//    }

    public static String buildMenuUrl(String menuUrl) {
        if (menuUrl.endsWith(".cpt")) {
            return REPORT_BASE_URL + menuUrl;
        }
        return menuUrl;
    }

}
