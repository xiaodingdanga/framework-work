package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.system.dao.CustomerDao;
import com.lx.framework.system.service.CustomerService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

	Logger log = LogManager.getLogger(CustomerServiceImpl.class.getName());

	@Resource
	private CustomerDao customerDao;

	@Override
	public void save(Map<String, Object> paramap) {
		customerDao.save(paramap);
	}

	@Override
	public Map<String, Object> findById(String id) {
		return customerDao.findById(id);
	}

	@Override
	public void update(Map<String, Object> paramap) {
		customerDao.update(paramap);
	}

	@Override
	public void batchDelete(String[] ids) {
		customerDao.batchDelete(ids);
	}

	@Override
	public void delete(String id) {
		customerDao.delete(id);
	}

	@Override
	public String findPageByParam(Map<String, Object> paramap) {
		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = customerDao.getCountByParam(paramap);
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
		List<Map<String, Object>> list = customerDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> OrderMap : list) {
			JSONObject obj = new JSONObject();
			// id,name
			obj.put("id", OrderMap.get("id") != null ? OrderMap.get("id").toString() : "");
			obj.put("name", OrderMap.get("name") != null ? OrderMap.get("name").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public String findAllByParam(Map<String, Object> paramap) {
		JSONObject pagejson = new JSONObject();
		// 根据条件查询
		List<Map<String, Object>> list = customerDao.findAllByParam(paramap);
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> OrderMap : list) {
			JSONObject obj = new JSONObject();
			// id,name
			obj.put("id", OrderMap.get("id") != null ? OrderMap.get("id").toString() : "");
			obj.put("name", OrderMap.get("name") != null ? OrderMap.get("name").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

}