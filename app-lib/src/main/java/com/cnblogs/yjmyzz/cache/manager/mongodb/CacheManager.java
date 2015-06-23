package com.cnblogs.yjmyzz.cache.manager.mongodb;

import java.util.Collection;
import org.springframework.cache.support.AbstractCacheManager;

public class CacheManager extends AbstractCacheManager {
	private Collection<? extends CacheData> caches;

	public void setCaches(Collection<? extends CacheData> caches) {
		this.caches = caches;
	}

	@Override
	protected Collection<? extends CacheData> loadCaches() {
		return this.caches;
	}
	


}