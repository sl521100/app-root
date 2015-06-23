package com.cnblogs.yjmyzz.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.security.crypto.codec.Base64;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.util.HtmlUtils;

public abstract class EncodeUtil {

	private EncodeUtil(){
		//工具类无需对象实例化
	}

	// static BASE64Encoder base64Encoder = new BASE64Encoder();

	// static BASE64Decoder base64Decoder = new BASE64Decoder();

	/**
	 * 把给定的二进制流变成base64码
	 * 
	 * @param in
	 * @return
	 * @throws IOException
	 */
	public static String base64Encode(InputStream in) throws IOException {
		if (in == null) {
			return null;
		}
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		FileCopyUtils.copy(in, output);
		return base64Encode(output.toByteArray());
	}

	public static String base64Encode(String in) {
		if (in == null) {
			return null;
		}
		return base64Encode(in.getBytes());
	}

	public static String base64Encode(byte[] in) {
		if (in == null) {
			return null;
		}
		// return base64Encoder.encode(in);
		return new String(Base64.encode(in));
	}

	public static byte[] base64Decode(String src) throws IOException {
		if (src == null) {
			return null;
		}
		// return base64Decoder.decodeBuffer(src);
		return Base64.decode(src.getBytes());
	}

	/**
	 * 把给定的str转换为10进制表示的unicode，格式为：&#23016; 目前只是用于mht模板的转码
	 * 
	 * @param str
	 * @return
	 */
	public static String encode2HtmlUnicode(String str) {

		if (str == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder(str.length() * 2);
		for (int i = 0; i < str.length(); i++) {
			sb.append(encode2HtmlUnicode(str.charAt(i)));
		}
		return sb.toString();
	}

	public static String encode2HtmlUnicode(char character) {
		if (character > 255) {
			return "&#" + (character & 0xffff) + ";";
		} else {
			return HtmlUtils.htmlEscape(String.valueOf(character));
			// return String.valueOf(character);
		}
	}

	public static String encode2HtmlUnicode(Character character) {
		if (character == null)
			return null;
		return encode2HtmlUnicode(character.charValue());
	}

	public static void encode2HtmlUnicode(String[] value) {

		if (value == null || value.length < 1) {
			return;
		}

		for (int i = 0; i < value.length; i++) {
			value[i] = encode2HtmlUnicode(value[i]);
		}
	}

	/**
	 * 参考Java Cryptography Architecture Standard Algorithm Name Documentation
	 * 
	 * @param text
	 * @param encodingAlgorithm
	 * @return
	 */
	public static String encrypt(String text, String algorithm) {
		if (text == null) {
			return null;
		}

		try {
			MessageDigest messageDigest = MessageDigest.getInstance(algorithm);
			messageDigest.update(text.getBytes());
			return getFormattedText(messageDigest.digest());
		} catch (NoSuchAlgorithmException e) {
			throw new SecurityException(e);
		}
	}

	/**
	 * 参考Java Cryptography Architecture Standard Algorithm Name Documentation
	 * 默认是MD5
	 * 
	 * @param text
	 * @param encodingAlgorithm
	 * @return
	 */
	public static String encrypt(String text) {
		return encrypt(text, "MD5");
	}

	private static String getFormattedText(byte[] bytes) {
		StringBuilder buf = new StringBuilder(bytes.length * 2);

		for (int j = 0; j < bytes.length; j++) {
			buf.append(HEX_DIGITS[(bytes[j] >> 4) & 0x0f]);
			buf.append(HEX_DIGITS[bytes[j] & 0x0f]);
		}
		return buf.toString();
	}

	static final char[] HEX_DIGITS = { '0', '1', '2', '3', '4', '5', '6', '7',
			'8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
}