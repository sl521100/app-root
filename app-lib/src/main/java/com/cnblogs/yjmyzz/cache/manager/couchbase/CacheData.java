package com.cnblogs.yjmyzz.cache.manager.couchbase;




//import org.apache.log4j.Logger;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;

import com.cnblogs.yjmyzz.cache.model.DefaultCacheItem;

public class CacheData implements Cache {
	//Logger log = Logger.getLogger(this.getClass());
	private CouchbaseUtil couchbaseUtil;

	private String host;
	private int port;
	private String bucketName;
	// bucket 密码
	private String password;

	// 缓存有效期
	private int expiredSeconds;

	private CouchbaseUtil getCouchbaseUtil() {
		if (couchbaseUtil == null) {
			couchbaseUtil = new CouchbaseUtil(host, port, bucketName, password);
		}
		return couchbaseUtil;
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

	public Object getNativeCache() {
		return getCouchbaseUtil().getInstance();
	}

	public ValueWrapper get(Object key) {
		//log.debug("couchbase.CacheData.get() is called!");
		ValueWrapper result = null;
		if (key == null) {
			return null;
		}
		Object value = getCouchbaseUtil().getInstance().get(key.toString());
		if (value == null)
			return null;
		result = new SimpleValueWrapper(new DefaultCacheItem((String) key,
				value));

		return result;
	}

	// 写缓存
	public void put(Object key, Object value) {
		//log.debug("couchbase.CacheData.put() is called!");
		DefaultCacheItem thevalue = (DefaultCacheItem) value;
		try {
			// expiry 单位是s
			if (thevalue != null) {
				getCouchbaseUtil().getInstance()
						.set(key.toString(), expiredSeconds, thevalue).get();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	// 删除指定缓存
	public void evict(Object key) {
		getCouchbaseUtil().getInstance().delete(key.toString());

	}

	/**
	 * 清空所有缓存
	 */
	public void clear() {
		getCouchbaseUtil().getInstance().flush();
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the bucketname
	 */
	public String getBucketName() {
		return bucketName;
	}

	/**
	 * @param bucketname
	 *            the bucketname to set
	 */
	public void setBucketName(String bucketName) {
		this.bucketName = bucketName;
	}

	public int getExpiredSeconds() {
		return expiredSeconds;
	}

	public void setExpiredSeconds(int expiredSeconds) {
		this.expiredSeconds = expiredSeconds;
	}

	@Override
	public <T> T get(Object key, Class<T> type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ValueWrapper putIfAbsent(Object key, Object value) {
		// TODO Auto-generated method stub
		return null;
	}
}
