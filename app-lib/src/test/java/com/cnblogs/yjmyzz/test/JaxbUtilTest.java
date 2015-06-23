package com.cnblogs.yjmyzz.test;

import java.util.Date;

import org.junit.Assert;
import org.junit.Test;

import com.cnblogs.yjmyzz.test.domain.Sample;
import com.cnblogs.yjmyzz.utils.*;

public class JaxbUtilTest {

	private Sample getSample() {
		Sample s = new Sample();
		s.setAmount(1.0);
		s.setCreateDate(new Date());
		return s;
	}

	@Test
	public void testToXml() {
		//System.out.println(JaxbUtil.toXml(getSample(), "UTF-8", true));
	}

	@Test
	public void testToObject() {
		String xmlString = JaxbUtil.toXml(getSample(), "UTF-8", true);
		Sample s = JaxbUtil.toObject(xmlString, Sample.class);
		Assert.assertTrue(getSample().equals(s));		
	}

}
