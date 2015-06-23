package com.cnblogs.yjmyzz.cache.service.sso;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.cache.service.common.CacheService;

public interface SsoCacheService extends CacheService {

	/**
	 * 通过用户名，找到缓存项(对于sso缓存，存放的结果是token-username的key-value结构)
	 * 
	 * @param userName
	 * @return
	 */
	CacheItem getByUserName(String userName);

}
