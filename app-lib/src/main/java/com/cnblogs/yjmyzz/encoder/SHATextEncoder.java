package com.cnblogs.yjmyzz.encoder;

import com.cnblogs.yjmyzz.utils.EncodeUtil;

public class SHATextEncoder implements TextEncoder {

	@Override
	public String encode(String text) {
		return EncodeUtil.encrypt(text, "SHA");
	}

}
