/**
 * Created by shilin on 2015/6/21.
 */
package com.cn.sl.controller;

import com.cn.sl.utils.BusinessException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public abstract class BaseController {
    protected Logger logger = LogManager.getLogger();

    @ExceptionHandler
    public String exp(HttpServletRequest request, Exception ex) {
        String resultViewName = "errors/error";

        // 记录日志
        logger.error(ex.getMessage(), ex);

        // 根据不同错误转向不同页面
        if (ex instanceof BusinessException) {
            resultViewName = "errors/biz-error";
        } else {
            // 异常转换
            //ex = new Exception("服务器忙，请稍候重试！");
        }

        String xRequestedWith = request.getHeader("X-Requested-With");
        if (!StringUtils.isEmpty(xRequestedWith)) {
            // ajax请求
            resultViewName = "errors/ajax-error";
        }

        request.setAttribute("ex", ex);
        return resultViewName;
    }
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // CustomDateEditor 第二个参数为true 页面日期为空时 自动转换为 null  否则会抛异常
        binder.registerCustomEditor(Date.class, new CustomDateEditor(
                dateFormat, true));
    }
}
