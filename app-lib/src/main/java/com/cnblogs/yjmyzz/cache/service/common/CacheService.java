package com.cnblogs.yjmyzz.cache.service.common;

import java.util.Collection;

import org.springframework.cache.support.CompositeCacheManager;

import com.cnblogs.yjmyzz.cache.model.CacheItem;

/**
 * 通用缓存接口
 * 
 * @author yjmyzz@126.com
 * 
 */
public interface CacheService {

	/**
	 * 添加缓存项
	 * 
	 * @param key
	 * @param item
	 * @return
	 */

	CacheItem put(String key, CacheItem item);

	/**
	 * 获取缓存项
	 * 
	 * @param key
	 * @return
	 */

	CacheItem get(String key);

	/**
	 * 删除缓存项
	 * 
	 * @param key
	 * @return
	 */

	public CacheItem delete(String key);

	/**
	 * 取得所有缓存项
	 * 
	 * @return
	 */

	public Collection<CacheItem> getAll();

	/**
	 * 清空所有缓存项
	 */

	public void clear();
	
	
	/**
	 * 返回当前所使用的CacheManager
	 * @return
	 */
	public CompositeCacheManager getCacheManager();

}