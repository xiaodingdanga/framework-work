package com.lx.framework.base;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Controller
public class BaseController {
	Logger log = LogManager.getLogger(BaseController.class.getName());

	/**
	 * 获取参数
	 * 
	 * @return
	 */
	public Map<String, Object> getParameter() {
		HttpServletRequest request = this.getRequest();
		Map properties = request.getParameterMap();
		Map returnMap = new HashMap();
		Iterator entries = properties.entrySet().iterator();
		Map.Entry entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		properties = returnMap;
		return properties;
	}

	/**
	 * 获取request对象
	 * 
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		return request;
	}

	public String receivePost() {
		// 读取请求内容
		BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(this.getRequest().getInputStream()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("接收POST参数接收异常：");
			e.printStackTrace();
			return "";
		}
		String line = null;
		StringBuilder sb = new StringBuilder();
		try {
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("接收POST参数序列化异常：");
			e.printStackTrace();
			return "";
		}
		String reqBody = sb.toString();
		try {
			reqBody = URLDecoder.decode(reqBody, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			System.out.println("接收POST参数转码异常：");
			e.printStackTrace();
			return "";
		}
		return reqBody.toString();
	}

}
