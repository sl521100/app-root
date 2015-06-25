/**
 * Created by shilin on 2015/6/21.
 */
package com.cn.sl.web.controller;

import com.cn.sl.web.service.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

@Controller
@RequestMapping(value = "/mvc/home")
public class HomeController extends  BaseController{
    @Autowired
    HomeService homeService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        homeService.doSave3201Model(null);

        homeService.doSave3201Model2(null);
        ModelAndView model = new ModelAndView();

        model.addObject("userName", "shilin");
        model.setViewName("home/index1");
        return model;
    }
}
