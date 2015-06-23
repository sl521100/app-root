package com.cnblogs.yjmyzz.cache.model;

import java.io.Serializable;
import java.util.Date;

public interface CacheItem extends Serializable {

	public String getKey();

	public Object getValue();
	
	public Date getExpirationTime();

}
