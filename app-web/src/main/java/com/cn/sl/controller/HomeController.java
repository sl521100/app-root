/**
 * Created by shilin on 2015/6/21.
 */
package com.cn.sl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping(value = "/mvc/home")
public class HomeController extends  BaseController{
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView model = new ModelAndView();

        model.addObject("userName", "shilin");
        model.setViewName("home/index1");
        return model;
    }
}
