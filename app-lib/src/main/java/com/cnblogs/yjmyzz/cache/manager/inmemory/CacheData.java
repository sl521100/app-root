package com.cnblogs.yjmyzz.cache.manager.inmemory;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;

import com.cnblogs.yjmyzz.cache.model.CacheItem;

public class CacheData implements Cache {		
	
	static Logger log = LogManager.getLogger();

	private String name;

	private Map<String, CacheItem> store = new HashMap<String, CacheItem>();

	public CacheData() {
	}

	public CacheData(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Object getNativeCache() {
		return store;
	}

	public ValueWrapper get(Object key) {
		log.debug("inmemory.CacheData.get() is called!");
		ValueWrapper result = null;
		CacheItem thevalue = store.get(key);
		if (thevalue != null) {
			result = new SimpleValueWrapper(thevalue);
		}
		return result;
	}

	public void put(Object key, Object value) {
		log.debug("inmemory.CacheData.put() is called!");
		CacheItem thevalue = (CacheItem) value;
		store.put((String) key, thevalue);
	}

	public void evict(Object key) {
		store.remove((String) key);
	}

	public void clear() {
		store.clear();
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> T get(Object key, Class<T> type) {
		log.debug("inmemory.CacheData.get<T>() is called!");
		ValueWrapper result = null;
		CacheItem thevalue = store.get(key);
		if (thevalue != null) {
			result = new SimpleValueWrapper(thevalue);
		}
		return (T)result;
	}

	@Override
	public ValueWrapper putIfAbsent(Object key, Object value) {
		// TODO Auto-generated method stub
		return null;
	}
}
