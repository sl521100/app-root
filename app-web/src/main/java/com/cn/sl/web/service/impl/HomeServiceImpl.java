package com.cn.sl.web.service.impl;

import com.cn.sl.dao.BaseDAO;
import com.cn.sl.entity.CCms3201Entity;
import com.cn.sl.mybatis.mapper.CCms3201Mapper;
import com.cn.sl.web.service.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;

/**
 * Created by shilin on 2015/6/24.
 */
@Service("homeServiceImpl")
public class HomeServiceImpl extends BaseServiceImpl implements HomeService{

    @Autowired
    CCms3201Mapper cms3201Mapper;

    @Resource
    BaseDAO<CCms3201Entity> cms3201DAO;


    @Override
    public CCms3201Entity get3201Model(long recid) {
        CCms3201Entity entity=cms3201Mapper.selectByPrimaryKey(BigDecimal.valueOf(recid));
        CCms3201Entity entity2=cms3201DAO.get(CCms3201Entity.class,recid);

        return entity;
    }

    @Override
    public void doSave3201Model(CCms3201Entity entity) {
        CCms3201Entity model=cms3201Mapper.selectByPrimaryKey(BigDecimal.valueOf(272153));

        model.setAwbNo("31517630");
        cms3201DAO.update(model);

        model.setAwbNo("31517631");
        cms3201Mapper.updateByPrimaryKeySelective(model);

    }

    @Override
    public void doSave3201Model2(CCms3201Entity entity) {
        CCms3201Entity model=cms3201Mapper.selectByPrimaryKey(BigDecimal.valueOf(272153));

        model.setAwbNo("31517630");
        cms3201DAO.update(model);

        try {
            model.setAwbNo("315176313151763131517631315176313151763131517631");
            cms3201Mapper.updateByPrimaryKeySelective(model);
        }catch (Throwable e){

        }
    }
}
