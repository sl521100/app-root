package com.cn.sl.web.service;

import com.cn.sl.entity.CCms3201Entity;

/**
 * Created by Jacob on 2015/3/12.
 */
public interface HomeService {
   CCms3201Entity get3201Model(long recid);
    void doSave3201Model(CCms3201Entity entity);
    void doSave3201Model2(CCms3201Entity entity);
}
