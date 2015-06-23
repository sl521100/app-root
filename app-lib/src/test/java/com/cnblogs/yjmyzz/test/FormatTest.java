package com.cnblogs.yjmyzz.test;
import com.cnblogs.yjmyzz.domain.BaseBean;
import com.cnblogs.yjmyzz.test.domain.FormatSampleDto;
import com.cnblogs.yjmyzz.utils.DateUtil;
import com.cnblogs.yjmyzz.utils.ReflectionUtil;
import org.junit.Test;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.format.number.NumberFormatter;

import java.util.Date;
import java.util.Locale;
import java.util.logging.Logger;



/**
 * Created by jimmy on 2015/3/4.
 */
public class FormatTest extends BaseBean {

    public FormatSampleDto getSampleDto() {
        FormatSampleDto dto = new FormatSampleDto();
        dto.setFee(1.236);
        dto.setPcs(1);
        dto.setCreateDate(new Date());
        return dto;
    }

    @Test
    public void testFormat() {
        FormatSampleDto d = getSampleDto();

        Object createDate = ReflectionUtil.invokeGetterMethod(d, "createDate");
        if (createDate != null && createDate.getClass().equals(Date.class)) {
            //日期格式
            DateTimeFormat annotation = ReflectionUtil.getAnnotation(d, "createDate", DateTimeFormat.class);
            if (annotation != null) {
                DateFormatter dateFormatter = new DateFormatter();
                dateFormatter.setPattern(annotation.pattern());
                logger.debug("创建日期：" + dateFormatter.print((Date) createDate, Locale.CHINESE));
            }
        }

        Object fee = ReflectionUtil.invokeGetterMethod(d, "fee");
        if (fee != null && fee.getClass().getSuperclass().equals(Number.class)) {
            //数字格式
            NumberFormat annotation = ReflectionUtil.getAnnotation(d, "fee", NumberFormat.class);
            if (annotation != null) {
                NumberFormatter formatter = new NumberFormatter();
                formatter.setPattern(annotation.pattern());
                logger.debug("费用：" + formatter.print((Number) fee, Locale.CHINESE));
            }
        }

        Object pcs = ReflectionUtil.invokeGetterMethod(d, "pcs");
        if (pcs != null && pcs.getClass().getSuperclass().equals(Number.class)) {
            //数字格式
            NumberFormat annotation = ReflectionUtil.getAnnotation(d, "pcs", NumberFormat.class);
            if (annotation != null) {
                NumberFormatter formatter = new NumberFormatter();
                formatter.setPattern(annotation.pattern());
                logger.debug("件数：" + formatter.print((Number) pcs, Locale.CHINESE));
            }
        }
    }
}
