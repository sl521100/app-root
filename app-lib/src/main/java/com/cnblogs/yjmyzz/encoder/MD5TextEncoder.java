package com.cnblogs.yjmyzz.encoder;

import com.cnblogs.yjmyzz.utils.EncodeUtil;




public class MD5TextEncoder implements TextEncoder {

	@Override
	public String encode(String text) {
		return EncodeUtil.encrypt(text);
	}

}
