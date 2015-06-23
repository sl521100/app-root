package com.cnblogs.yjmyzz.cache.manager.redis;

import java.io.Serializable;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;

import com.cnblogs.yjmyzz.cache.model.CacheItem;
import com.cnblogs.yjmyzz.cache.model.DefaultCacheItem;

public class CacheData implements Cache, Serializable {

	private static final long serialVersionUID = -2649787881237616163L;

	static Logger log = LogManager.getLogger();

	JedisConnectionFactory jedisConnectionFactory;

	private static ObjectRedisTemplate<DefaultCacheItem> objectRedisTemplate;

	private ObjectRedisTemplate<DefaultCacheItem> getObjectRedisTemplate() {
		if (objectRedisTemplate == null) {
			objectRedisTemplate = new ObjectRedisTemplate<DefaultCacheItem>(
					jedisConnectionFactory, DefaultCacheItem.class);
		}
		return objectRedisTemplate;
	}

	private String name;

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

	/**
	 * 返回所有redis的Key
	 */
	public Object getNativeCache() {
		return objectRedisTemplate.keys("*");
	}

	public ValueWrapper get(Object key) {
		log.debug("redis.CacheData.get() is called!");
		ValueWrapper result = null;
		CacheItem thevalue = getObjectRedisTemplate().opsForValue().get(
				key.toString());
		if (thevalue != null) {
			result = new SimpleValueWrapper(thevalue);
		}
		return result;
	}

	public void put(Object key, Object value) {
		log.debug("redis.CacheData.put() is called!");
		evict(key);
		DefaultCacheItem thevalue = (DefaultCacheItem) value;
		getObjectRedisTemplate().opsForValue().set(key.toString(), thevalue);
	}

	public void evict(Object key) {
		getObjectRedisTemplate().delete(key.toString());
	}

	public void clear() {
		Set<String> keys = getObjectRedisTemplate().keys("*");
		getObjectRedisTemplate().delete(keys);
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> T get(Object key, Class<T> type) {
		log.debug("redis.CacheData.get<T>() is called!");
		ValueWrapper result = null;
		CacheItem thevalue = getObjectRedisTemplate().opsForValue().get(
				key.toString());
		;
		if (thevalue != null) {
			result = new SimpleValueWrapper(thevalue);
		}
		return (T) result;
	}

	@Override
	public ValueWrapper putIfAbsent(Object key, Object value) {
		DefaultCacheItem thevalue = (DefaultCacheItem) value;
		getObjectRedisTemplate().opsForValue().setIfAbsent(key.toString(),
				thevalue);
		return new SimpleValueWrapper(thevalue);

	}

	public void setJedisConnectionFactory(
			JedisConnectionFactory jedisConnectionFactory) {
		this.jedisConnectionFactory = jedisConnectionFactory;
	}
}
