package com.cnblogs.yjmyzz.cache.manager.mongodb;

import java.net.UnknownHostException;

//import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoOptions;
import com.mongodb.ServerAddress;
import com.mongodb.util.JSON;

public final class MongoUtil {

	public MongoUtil(String host, int port) {
		if (!StringUtils.isEmpty(host)) {
			this.host = host;
		}
		if (port != 0) {
			this.port = port;
		}

		try {
			MongoOptions options = new MongoOptions();
			options.autoConnectRetry = true;
			options.connectionsPerHost = 1000;
			options.maxWaitTime = 5000;
			options.socketTimeout = 0;
			options.connectTimeout = 15000;
			options.threadsAllowedToBlockForConnectionMultiplier = 5000;
			mongo = new Mongo(new ServerAddress(this.host, this.port), options);
			//log.info("mongo db is connected...");
		} catch (UnknownHostException e) {
			//log.info("get mongo instance failed");
		}
	}

	public MongoUtil() {
		this("localhost", 27017);
	}

	private Mongo mongo;
	//Logger log = Logger.getLogger(this.getClass());
	private DB db;

	/**
	 * mongodb server IP
	 */
	private String host;

	/**
	 * 端口号
	 */
	private int port;

	/**
	 * db名称
	 */
	private String dbName;

	/**
	 * 集合(表)名
	 */
	private String colName;

	public DB getDB() {
		if (db == null) {
			db = mongo.getDB(getDbName());
		}

		return db;
	}

	public Mongo getMong() {
		return mongo;
	}

	public DBCollection getColl(String collname) {
		return getDB().getCollection(collname);
	}

	public DBCollection getColl() {
		return getDB().getCollection(getColName());
	}

	public String getDbName() {
		if (StringUtils.isEmpty(dbName)) {
			dbName = "test";
		}
		return dbName;
	}

	public void setDbName(String databaseName) {
		dbName = databaseName;
	}

	public String getColName() {
		if (StringUtils.isEmpty(colName)) {
			colName = "cache";
		}
		return colName;
	}

	public void setColName(String collectionName) {
		colName = collectionName;
	}

	public DBObject toDBObject(Object obj) {
		Gson gson = new Gson();
		String json = gson.toJson(obj);
		return (DBObject) JSON.parse(json);
	}

}
