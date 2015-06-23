package com.cnblogs.yjmyzz.cache.service.sso;

import java.util.Collection;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.cache.support.CompositeCacheManager;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.cache.service.common.CacheServiceImpl;

public class SsoCacheServiceImpl extends CacheServiceImpl implements
		SsoCacheService {

	static Logger log = LogManager.getLogger();

	public SsoCacheServiceImpl(CompositeCacheManager cacheManager) {
		super(cacheManager);
	}

	public CacheItem getByUserName(String userName) {
		log.debug("SsoCacheServiceImpl.getByUserName() is called!");
		Collection<CacheItem> allCacheItems = getAll();
		log.debug(allCacheItems.size());
		for (CacheItem cacheItem : allCacheItems) {
			if (cacheItem != null && cacheItem.getValue().equals(userName)) {
				return cacheItem;
			}
		}
		return null;
	}

}
