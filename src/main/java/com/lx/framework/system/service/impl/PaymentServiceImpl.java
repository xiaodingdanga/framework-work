package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.utils.util;
import com.lx.framework.system.dao.PaymentDao;
import com.lx.framework.system.service.PaymentService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class PaymentServiceImpl implements PaymentService {

	Logger log = LogManager.getLogger(PaymentServiceImpl.class.getName());
	@Resource
	private PaymentDao paymentDao;

	@Override
	public String findPageByParam(Map<String, Object> paramap) {
		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = paymentDao.getCountByParam(paramap);
		// 总页数
		int totalPage = 0;
		// 总数%每页数=余数：等于0----否则----总数%每页数=余数：不等于0
		if (totalRecord % pageSize == 0) {
			// 总数/每页数=总页数
			totalPage = totalRecord / pageSize;
		} else {
			// 总数/每页数+1=总页数
			totalPage = totalRecord / pageSize + 1;
		}
		// 开始记录数
		int index = (page - 1) * pageSize;
		paramap.put("start", index);
		JSONObject pagejson = new JSONObject();
		// 根据条件查询
		List<Map<String, Object>> list = paymentDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> DistributorMap : list) {
			JSONObject obj = new JSONObject();
			// id,name
			obj.put("id", DistributorMap.get("id") != null ? DistributorMap.get("id").toString() : "");
			obj.put("name", DistributorMap.get("name") != null ? DistributorMap.get("name").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public void save(Map<String, Object> paramap) {
		String id=util.getUuid();
		paramap.put("id", id);
		paymentDao.save(paramap);
	}

	@Override
	public void update(Map<String, Object> paramap) {
		String payid=paramap.get("id").toString();
		Map<String, Object> paymap=paymentDao.findById(payid);
		paymap.put("name",paramap.get("name").toString());
		paymentDao.update(paymap);
	}

	@Override
	public Map<String, Object> findById(String id) {
		return paymentDao.findById(id);
	}

	@Override
	public void delete(String disid) {
		paymentDao.delete(disid);
	}

	@Override
	public boolean checkName(Map<String, Object> paramap) {
		return paymentDao.checkName(paramap);
	}
	@Override
	public String loadpaymentid(Map<String, Object> paramap) {
		List<Map<String,Object>> list=paymentDao.findByCustomerId(paramap);
		JSONArray jsonArray=new JSONArray();
		for (Map<String,Object> maplist : list) {
			JSONObject obj=new JSONObject();
			obj.put("id", maplist.get("id").toString());
			obj.put("name", maplist.get("name").toString());
			jsonArray.add(obj);
		}
		return jsonArray.toString();
	}

	@Override
	public List<Map<String, Object>> findAllByCustomerId(String customerid) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("customerid", customerid);
		return paymentDao.findByCustomerId(map);
	}
}
