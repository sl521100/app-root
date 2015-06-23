package com.cnblogs.yjmyzz.cache.manager.couchbase;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

//import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.couchbase.client.CouchbaseClient;
import com.couchbase.client.CouchbaseConnectionFactory;
import com.couchbase.client.CouchbaseConnectionFactoryBuilder;

public final class CouchbaseUtil {

	/**
	 * 客户端对象
	 */
	private static CouchbaseClient couchebaseClient;

	//Logger log = Logger.getLogger(this.getClass());

	/**
	 * Couchebase server IP
	 */
	private String host;

	/**
	 * Couchebase端口号
	 */
	private int port;

	/**
	 * 类似于dbname,默认为default
	 */
	private String bucketName;

	private String password;

	public CouchbaseUtil() {
		this("localhost", 8091, "default", "");
	}

	public CouchbaseUtil(String host, int port, String bucketName,
			String password) {
		if (!StringUtils.isEmpty(host)) {
			this.host = host;
		}
		this.host = this.host.toLowerCase().trim();
		if (!this.host.startsWith("http://")) {
			this.host = "http://" + this.host;
		}
		if (port != 0) {
			this.port = port;
		}
		if (!StringUtils.isEmpty(bucketName)) {
			this.bucketName = bucketName;
		}
		this.password = StringUtils.isEmpty(password) ? "" : password;
		initialized();
	}

	/**
	 * 初始化数据库连接
	 */
	public void initialized() {
		if (StringUtils.isEmpty(this.host) || StringUtils.isEmpty(this.port)
				|| StringUtils.isEmpty(this.bucketName)) {
			throw new RuntimeException("初始化参数错误！");
		}
		// 服务器地址，支持集群
		List<URI> baseURIs = new ArrayList<URI>();
		String uri = host + ":" + port + "/pools";
		URI base = URI.create(uri);
		baseURIs.add(base);

		try {
			CouchbaseConnectionFactoryBuilder cfb = new CouchbaseConnectionFactoryBuilder();
			cfb.setOpTimeout(10000);// 设置连接超时为10s
			CouchbaseConnectionFactory cf = cfb.buildCouchbaseConnection(
					baseURIs, bucketName, password);
			// 创建数据库连接
			couchebaseClient = new CouchbaseClient(cf);

			//log.info("Couchbase db is connected...");
		} catch (Exception e) {
			e.printStackTrace();
			//log.info("get Couchbase instance failed");
		}
	}

	public void dispose() {
		//log.info("Disconnecting from Couchbase Cluster");
		couchebaseClient.shutdown(60, TimeUnit.SECONDS);
	}

	/**
	 * @return the couchebaseClient
	 */
	public CouchbaseClient getInstance() {
		return couchebaseClient;
	}

	/**
	 * @return the host
	 */
	public String getHost() {
		return host;
	}

	/**
	 * @param host
	 *            the host to set
	 */
	public void setHost(String host) {
		this.host = host;
	}

	/**
	 * @return the port
	 */
	public int getPort() {
		return port;
	}

	/**
	 * @param port
	 *            the port to set
	 */
	public void setPort(int port) {
		this.port = port;
	}

	/**
	 * @return the bucketName
	 */
	public String getBucketName() {
		return bucketName;
	}

	/**
	 * @param bucketName
	 *            the bucketName to set
	 */
	public void setBucketName(String bucketName) {
		this.bucketName = bucketName;
	}

}
