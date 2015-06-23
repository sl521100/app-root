package com.cnblogs.yjmyzz.cache.service.sso;

import java.util.Collection;
import java.util.Date;
//import org.apache.log4j.Logger;







import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.cache.model.DefaultCacheItem;
import com.cnblogs.yjmyzz.consts.CacheConsts;
import com.cnblogs.yjmyzz.utils.DateUtil;



public class SsoCacheServiceFacade {

	static Logger log = LogManager.getLogger();

	/**
	 * 过期时间(秒)
	 */
	private int expiredSeconds = 0;

	protected SsoCacheService cacheService;

	public SsoCacheServiceFacade(SsoCacheService cacheService) {
		this.cacheService = cacheService;
	}

	private String getCacheProviderName() {
		return cacheService.getCacheManager().getCache(CacheConsts.CACHE_NAME)
				.getClass().getName().toLowerCase();
	}

	private boolean isSupportExpiration() {
		String cacheProviderName = getCacheProviderName();
		if (cacheProviderName.contains("ehcache")
				|| cacheProviderName.contains("redis")
				|| cacheProviderName.contains("couchbase")) {
			return true;
		}
		return false;
	}

	private long getCacheManagerExpiredSeconds() {
		String cacheProviderName = getCacheProviderName();
		
		if (cacheProviderName.contains("ehcache")) {
			net.sf.ehcache.Cache cache = (net.sf.ehcache.Cache) cacheService
					.getCacheManager().getCache(CacheConsts.CACHE_NAME)
					.getNativeCache();
			return cache.getCacheConfiguration().getTimeToLiveSeconds();
		}
		return Long.MAX_VALUE;
	}

	public CacheItem put(String key, CacheItem item) {
		DefaultCacheItem cacheItem = (DefaultCacheItem) item;

		// 如果当前CacheManager不支持自动过期
		if (!isSupportExpiration()) {
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
		} else {
			// 支持自动过期的，则取CacheManager上的设置
			int cacheManagerExpiredSeconds = (int) this
					.getCacheManagerExpiredSeconds();
			if (cacheManagerExpiredSeconds > 0) {
				cacheItem.setExpirationTime(DateUtil
						.addSeconds(cacheManagerExpiredSeconds));
			} else {
				cacheItem.setExpirationTime(DateUtil
						.addSeconds(Integer.MAX_VALUE));
			}
		}
		return cacheService.put(key, item);
	}

	public CacheItem get(String key) {
		return getCacheItem(cacheService.get(key));
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

	public CacheItem getByUserName(String userName) {
		return getCacheItem(cacheService.getByUserName(userName));
	}

	private CacheItem getCacheItem(CacheItem cacheItem) {
		// 如果当前CacheManager不支持自动过期，则人工判断
		if (!isSupportExpiration() && cacheItem.getExpirationTime() != null) {
			if (new Date().after(cacheItem.getExpirationTime())) {
				log.debug("CacheItem[\"" + cacheItem.getKey()
						+ "\"] has expired!");
				cacheService.delete(cacheItem.getKey());// 已过期，删除！
				return null;
			}
		}
		return cacheItem;
	}

}
