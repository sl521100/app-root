package com.cnblogs.yjmyzz.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.util.Assert;

public class ApplicationContextUtil extends BaseBean {

	private ApplicationContextUtil(){
		//工具类无需对象实例化
	}

	public static <T> T getBean(BeanFactory factory, String name, Class<T> clazz) {
		Assert.notNull(factory, "BeanFactory must not be null");
		if (factory.containsBean(name)) {
			return factory.getBean(name, clazz);
		}
		return null;
	}

}
