package tw.com.gss.sdsd3.module.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.lang.StringUtils;

public class MD5Util {

	// 加密測試範本
	public static void main(String[] args) throws UnsupportedEncodingException {
		String sss = textToMD5L32("qqqqq", 32);
		System.out.println(sss);
	}

	/**
	 * 對文字進行MD5加密
	 * 
	 * @param plainText 要進行加密的文字
	 * @param param     指定獲取16位/32位加密資料
	 * @return 加密後的內容
	 */
	public static String textToMD5L32(String plainText, Integer param) {
		String result = null;
		// 首先判斷是否為空
		if (StringUtils.isBlank(plainText)) {
			return null;
		}
		try {
			// 首先進行例項化和初始化
			MessageDigest md = MessageDigest.getInstance("MD5");
			// 得到一個作業系統預設的位元組編碼格式的位元組陣列
			byte[] btInput = plainText.getBytes();
			// 對得到的位元組陣列進行處理
			md.update(btInput);
			// 進行雜湊計算並返回結果
			byte[] btResult = md.digest();
			// 進行雜湊計算後得到的資料的長度
			StringBuffer sb = new StringBuffer();
			for (byte b : btResult) {
				int bt = b & 0xff;
				if (bt < 16) {
					sb.append(0);
				}
				sb.append(Integer.toHexString(bt));
			}

			if (param == 16) {
				result = sb.toString().substring(8, 24);
			} else if (param == 32) {
				result = sb.toString();
			}
			return result;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}

}
