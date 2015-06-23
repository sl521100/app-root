package com.cnblogs.yjmyzz.utils;

import java.text.NumberFormat;

import javax.xml.bind.annotation.adapters.XmlAdapter;

public class JaxbNumber3Adapter extends XmlAdapter<String, Number> {
	
	

	@Override
	public Number unmarshal(String v) throws Exception {
		if (v == null) {
			return null;
		}
		NumberFormat format = getFormat();
		return format.parse(v);
	}

	@Override
	public String marshal(Number v) throws Exception {
		NumberFormat format = getFormat();
		return format.format(v);
	}

	private NumberFormat getFormat() {
		NumberFormat format = NumberFormat.getNumberInstance();
		format.setMaximumFractionDigits(3);
		format.setMinimumFractionDigits(3);
		format.setGroupingUsed(false);
		return format;
	}

	
}