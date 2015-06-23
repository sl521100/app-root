package com.cnblogs.yjmyzz.cache.service.common;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import net.sf.ehcache.Element;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
//import org.apache.log4j.Logger;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.support.CompositeCacheManager;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.consts.CacheConsts;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CacheServiceImpl implements CacheService {

	CompositeCacheManager cacheManager;

	public CacheServiceImpl(CompositeCacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	static Logger log = LogManager.getLogger();

	private Map<String, CacheItem> dataMap = new HashMap<String, CacheItem>();

	@CachePut(value = CacheConsts.CACHE_NAME, key = "#key")
	public CacheItem put(String key, CacheItem item) {
		log.debug("item[\"" + key + "\"] has put to dataMap and Cache...");
		dataMap.put(key, item);
		return item;
	}

	@Cacheable(value = CacheConsts.CACHE_NAME, key = "#key")
	public CacheItem get(String key) {
		log.debug("item[\"" + key + "\"] get from dataMap...");
		return dataMap.get((String) key);
	}

	@CacheEvict(value = CacheConsts.CACHE_NAME, key = "#key")
	public CacheItem delete(String key) {
		log.debug("item[\"" + key + "\"] is deleted from dataMap and Cache...");
		return dataMap.remove((String) key);
	}

	@SuppressWarnings("unchecked")
	public Collection<CacheItem> getAll() {

		Object obj = cacheManager.getCache(CacheConsts.CACHE_NAME)
				.getNativeCache();

		//System.out.println(obj.getClass().getName());

		// ehcache
		if (obj instanceof net.sf.ehcache.Cache) {
			net.sf.ehcache.Cache cache = (net.sf.ehcache.Cache) obj;
			HashSet<CacheItem> set = new HashSet<CacheItem>();
			for (Object k : cache.getKeys()) {
				Element element = cache.get(k.toString());
				if (element != null) {
					set.add((CacheItem) element.getObjectValue());
				}
			}
			return set;
		}

		// inMemory
		if (obj instanceof HashMap) {
			log.debug("get all CacheItems from InMemory HashMap...");
			return ((HashMap<String, CacheItem>) obj).values();
		}

		// mongodb
		if (obj instanceof DBCursor) {
			log.debug("get all CacheItems from mongodb...");
			Map<String, CacheItem> temp = new HashMap<String, CacheItem>();
			DBCursor dbCursor = (DBCursor) obj;
			for (DBObject dbObject : dbCursor) {
				if (dbObject != null) {
					temp.put((String) dbObject.get(CacheConsts.KEY_COL_NAME),
							(CacheItem) dbObject
									.get(CacheConsts.VALUE_COL_NAME));
				}
			}
			dbCursor.close();
		}

		log.debug("get all CacheItems from dataMap...");

		return dataMap.values();

	}

	@CacheEvict(value = CacheConsts.CACHE_NAME, allEntries = true, beforeInvocation = true)
	public void clear() {
		log.debug("all items are deleted from dataMap and Cache...");
		dataMap.clear();
	}

	public CompositeCacheManager getCacheManager() {
		return cacheManager;
	}

}
