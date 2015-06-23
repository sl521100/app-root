package com.cnblogs.yjmyzz.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.StringUtils;

public class HttpUtil extends BaseBean {

	private HttpUtil(){
		//工具类无需对象实例化
	}

	public static String get(String url, String proxyHost, Integer proxyPort) {
		String response = null;
		HttpClient client = new DefaultHttpClient();

		if (!StringUtils.isEmpty(proxyHost) && proxyHost != null) {

			HttpHost host = new HttpHost(proxyHost, proxyPort);
			client.getParams()
					.setParameter(ConnRoutePNames.DEFAULT_PROXY, host);

		}
		HttpGet httpGet = new HttpGet(url);
		try {
			HttpResponse httpResponse = client.execute(httpGet);
			logger.debug(httpResponse.getStatusLine().getStatusCode() + " " + url);
			response = EntityUtils.toString(httpResponse.getEntity());
			logger.debug(response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("调用服务失败，服务地址：" + url + "，异常类型："
					+ e.getClass() + "，错误原因：" + e.getMessage());
		}
		return response;

	}

	public static String get(String url) {
		return get(url, null, null);
	}

	public static String post(String url, String postData, String mediaType,
			String proxyHost, Integer proxyPort) {
		String response = null;
		HttpClient client = new DefaultHttpClient();

		if (!StringUtils.isEmpty(proxyHost) && proxyHost != null) {
			HttpHost host = new HttpHost(proxyHost, proxyPort);
			client.getParams()
					.setParameter(ConnRoutePNames.DEFAULT_PROXY, host);
		}
		HttpPost httpPost = new HttpPost(url);
		try {
			httpPost.setEntity(new StringEntity(postData, mediaType, HTTP.UTF_8));
			HttpResponse httpResponse = client.execute(httpPost);
			logger.debug(httpResponse.getStatusLine().getStatusCode() + " " + url);
			byte[] bytes = EntityUtils.toByteArray(httpResponse.getEntity());
			response = new String(bytes, HTTP.UTF_8);
			logger.debug(response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("调用服务失败，服务地址：" + url + "，异常类型："
					+ e.getClass() + "，错误原因：" + e.getMessage());
		}
		return response;

	}

	public static String post(String url, String postData, String mediaType) {
		return post(url, postData, mediaType, null, null);
	}

}
