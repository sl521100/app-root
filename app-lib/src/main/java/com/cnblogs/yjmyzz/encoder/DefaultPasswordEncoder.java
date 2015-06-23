package com.cnblogs.yjmyzz.encoder;

import com.cnblogs.yjmyzz.utils.DateUtil;



public class DefaultPasswordEncoder implements TextEncoder {
	private String salt;

	private TextEncoder shaEncoder;

	private TextEncoder md5Encoder;

	public DefaultPasswordEncoder(String salt) {
		this.salt = salt;
		this.shaEncoder = new SHATextEncoder();
		this.md5Encoder = new MD5TextEncoder();
	}

	@Override
	public String encode(String password) {
		return this.md5Encoder.encode(this.shaEncoder.encode(password) + "#"
				+ DateUtil.formatDate("yyyyMMdd") + "#" + this.salt);
	}

}
