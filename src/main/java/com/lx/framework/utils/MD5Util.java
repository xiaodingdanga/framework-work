package com.lx.framework.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 加密工具类
 */
public class MD5Util {
	static Logger log=LogManager.getLogger(MD5Util.class.getName());
	/**
	 * 返回经MD5加密后的数据，如失败将返回null
	 * @param password:密码
	 * @return
	 */
	public static String getMD5(String password){
		if(password==null||password.trim().equals("")){
			return null;
		}
		StringBuffer md5SB=new StringBuffer();
		MessageDigest mD=null;
		try {
			mD=MessageDigest.getInstance("MD5");
			mD.reset();
			mD.update(password.getBytes("UTF-8"));
		}catch(NoSuchAlgorithmException e){
			log.info("未发现MD5算法！");
		}catch(UnsupportedEncodingException e){
			log.info("密码采用UTF-8编码时出错！");
		}
		if(null!=mD){
			byte[] byteArray=mD.digest();  
	        for(int i=0;i<byteArray.length;i++){        
	        	if(Integer.toHexString(0xFF&byteArray[i]).length()==1){
	        		md5SB.append("0").append(Integer.toHexString(0xFF&byteArray[i]));  
	        	}else{
	        		md5SB.append(Integer.toHexString(0xFF&byteArray[i]));  
	        	}
	        }
			return md5SB.toString();
		}
		return null;
	}
	public static String MD5Encode(String origin, String charsetname) {
		String resultString = null;
		try {
			resultString = new String(origin);
			MessageDigest md = MessageDigest.getInstance("MD5");
			if (charsetname == null || "".equals(charsetname))
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes()));
			else
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes(charsetname)));
		} catch (Exception exception) {
		}
		return resultString;
	}
	public static void main(String[] args){
		System.out.println(getMD5("ceode"));
	}
	private static String byteArrayToHexString(byte b[]) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++)
			resultSb.append(byteToHexString(b[i]));

		return resultSb.toString();
	}
	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n += 256;
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];
	}
	private static final String hexDigits[] = { "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
}
