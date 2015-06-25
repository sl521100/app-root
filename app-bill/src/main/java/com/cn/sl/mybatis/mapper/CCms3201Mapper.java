package com.cn.sl.mybatis.mapper;

import com.cn.sl.entity.CCms3201Entity;

import java.math.BigDecimal;

public interface CCms3201Mapper {
    int deleteByPrimaryKey(BigDecimal recid);

    int insert(CCms3201Entity record);

    int insertSelective(CCms3201Entity record);

    CCms3201Entity selectByPrimaryKey(BigDecimal recid);

    int updateByPrimaryKeySelective(CCms3201Entity record);

    int updateByPrimaryKey(CCms3201Entity record);
}