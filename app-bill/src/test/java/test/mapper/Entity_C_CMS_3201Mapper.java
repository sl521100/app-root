package test.mapper;

import java.math.BigDecimal;
import test.entity.Entity_C_CMS_3201;

public interface Entity_C_CMS_3201Mapper {
    int deleteByPrimaryKey(BigDecimal recid);

    int insert(Entity_C_CMS_3201 record);

    int insertSelective(Entity_C_CMS_3201 record);

    Entity_C_CMS_3201 selectByPrimaryKey(BigDecimal recid);

    int updateByPrimaryKeySelective(Entity_C_CMS_3201 record);

    int updateByPrimaryKey(Entity_C_CMS_3201 record);
}