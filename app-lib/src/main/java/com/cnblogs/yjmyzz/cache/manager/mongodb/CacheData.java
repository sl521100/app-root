package com.cnblogs.yjmyzz.cache.manager.mongodb;





//import org.apache.log4j.Logger;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;

import com.cnblogs.yjmyzz.cache.model.DefaultCacheItem;
import com.cnblogs.yjmyzz.consts.CacheConsts;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CacheData implements Cache {
	
	//Logger log = Logger.getLogger(this.getClass());

	private MongoUtil mongoUtil;

	private String host;
	private int port;

	protected MongoUtil getMongoUtil() {
		if (mongoUtil == null) {
			mongoUtil = new MongoUtil(host, port);
		}
		return mongoUtil;
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

		return getMongoUtil().getColl().find();
	}

	public ValueWrapper get(Object key) {
		//log.debug("mongodb.CacheData.get() is called!");
		ValueWrapper result = null;
		BasicDBObject objFind = new BasicDBObject(CacheConsts.KEY_COL_NAME,
				(String) key);
		BasicDBObject objFindResult = (BasicDBObject) getMongoUtil().getColl()
				.findOne(objFind);

		//log.debug(objFindResult);

		if (objFindResult != null) {
			result = new SimpleValueWrapper(new DefaultCacheItem((String) key,
					objFindResult.get(CacheConsts.VALUE_COL_NAME)));
		}
		return result;
	}

	public void put(Object key, Object value) {
		//log.debug("mongodb.CacheData.put() is called!");
		DefaultCacheItem thevalue = (DefaultCacheItem) value;
		if (thevalue != null) {
			DBObject objPut = getMongoUtil().toDBObject(thevalue);
			BasicDBObject objFind = new BasicDBObject(CacheConsts.KEY_COL_NAME,
					(String) key);
			if (getMongoUtil().getColl().findOne(objFind) == null) {
				getMongoUtil().getColl().insert(objPut);
			} else {
				getMongoUtil().getColl().update(objFind, objPut);
			}
		}

	}

	public void evict(Object key) {
		BasicDBObject objDel = new BasicDBObject(CacheConsts.KEY_COL_NAME,
				(String) key);
		getMongoUtil().getColl().remove(objDel);
	}

	public void clear() {
		DBCursor cursor = getMongoUtil().getColl().find();
		for (DBObject dbObject : cursor) {
			BasicDBObject objDel = (BasicDBObject) dbObject;
			getMongoUtil().getColl().remove(objDel);
		}
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
