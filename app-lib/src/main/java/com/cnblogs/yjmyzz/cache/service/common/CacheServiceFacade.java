package com.cnblogs.yjmyzz.cache.service.common;



import java.util.Collection;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.cache.model.DefaultCacheItem;
import com.cnblogs.yjmyzz.consts.CacheConsts;
import com.cnblogs.yjmyzz.utils.DateUtil;



public class CacheServiceFacade {

	static Logger log = LogManager.getLogger();

	/**
	 * 过期时间(秒)
	 */
	private int expiredSeconds = 0;

	protected CacheService cacheService;

	public CacheServiceFacade(CacheService cacheService) {
		this.cacheService = cacheService;
	}

	private boolean isSupportExpiration() {
		String cacheProviderName = cacheService.getCacheManager()
				.getCache(CacheConsts.CACHE_NAME).getClass().getName()
				.toLowerCase();		
		log.debug(cacheProviderName);
		if (cacheProviderName.contains("ehcache")
				|| cacheProviderName.contains("redis")
				|| cacheProviderName.contains("couchbase")) {
			return true;
		}
		return false;
	}

	public CacheItem put(String key, CacheItem item) {
		// 如果当前CacheManager不支持自动过期
		if (!isSupportExpiration()) {
			DefaultCacheItem cacheItem = (DefaultCacheItem) item;

			// 如果未设置过期时间
			if (item.getExpirationTime() == null) {
				if (expiredSeconds > 0) {
					cacheItem.setExpirationTime(DateUtil
							.addSeconds(expiredSeconds));
				} else {
					cacheItem.setExpirationTime(DateUtil
							.addSeconds(Integer.MAX_VALUE));
				}
			}

		}
		return cacheService.put(key, item);
	}

	public CacheItem get(String key) {
		CacheItem cacheItem = cacheService.get(key);
		// 如果当前CacheManager不支持自动过期，则人工判断
		if (!isSupportExpiration() && cacheItem.getExpirationTime() != null) {
			if (new Date().after(cacheItem.getExpirationTime())) {
				log.debug("CacheItem[\"" + key + "\"] has expired!");
				cacheService.delete(key);// 已过期，删除！
				return null;
			}
		}
		return cacheItem;
	}

	public CacheItem delete(String key) {
		return cacheService.delete(key);
	}

	public Collection<CacheItem> getAll() {
		return cacheService.getAll();
	}

	public void clear() {
		cacheService.clear();
	}

	public int getExpiredSeconds() {
		return expiredSeconds;
	}

	public void setExpiredSeconds(int expiredSeconds) {
		this.expiredSeconds = expiredSeconds;
	}

}
