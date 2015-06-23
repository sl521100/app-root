package com.cnblogs.yjmyzz.cache.model;



import java.util.Date;

import com.cnblogs.yjmyzz.utils.DateUtil;

public class DefaultCacheItem implements CacheItem {

	private static final long serialVersionUID = 1646139657577522635L;

	private String key;
	private Object value;
	private Date expirationTime;
	
	public DefaultCacheItem(){
		
	}

	public DefaultCacheItem(String key, Object value, Date expirationTime) {
		this.key = key;
		this.value = value;
		this.expirationTime = expirationTime;
	}

	public DefaultCacheItem(String key, Object value) {
		this(key, value, null);
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public String toString() {
		return "key:" + key + ",value:" + value + ",expirationTime:"
				+ DateUtil.formatDate(this.expirationTime);
	}

	public Date getExpirationTime() {
		return expirationTime;
	}

	public void setExpirationTime(Date expirationTime) {
		this.expirationTime = expirationTime;
	}

}
