package com.cnblogs.yjmyzz.test;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.junit.Assert;
import org.junit.Test;

import com.cnblogs.yjmyzz.utils.DateUtil;

public class DateUtilTest extends BaseBean {

	@Test
	public void testParseDate() throws ParseException {

		String d = "2015-01-01 00:00:00";
		logger.debug(DateUtil.parseDate(d, "yyyy-MM-dd HH:mm:ss"));
//		Date date1 = DateUtil.parseDate("2012-12-31 23:34:01",
//				"yyyy-MM-dd HH:mm:ss");
//		Calendar calendar = Calendar.getInstance();
//		calendar.set(2012, 11, 31, 23, 34, 01);
//		Date date2 = calendar.getTime();
//
////		System.out.println(DateUtil.formatDate(date1));
////		System.out.println(DateUtil.formatDate(date2));
//
//		Assert.assertTrue(DateUtil.formatDate(date1).equals(
//				DateUtil.formatDate(date2)));
	}
}
