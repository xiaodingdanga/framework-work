package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.system.dao.SysLoginLogDao;
import com.lx.framework.system.service.SysLoginLogService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly=false,rollbackFor=Exception.class)
public class SysLoginLogServiceImpl implements SysLoginLogService{
	Logger log = LogManager.getLogger(SysLoginLogServiceImpl.class.getName());
	@Resource
	private SysLoginLogDao SysUserLogAccessDao;
	/**
	 * 根据条件分页查询
	 */
	public String findPageByParam(Map<String,Object> paramap){
		//当前每页行数
		int pageSize=Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize",pageSize);
		//当前页数
		int page=Integer.parseInt(paramap.get("page").toString());
		//总记录数 
		int totalRecord=SysUserLogAccessDao.getCountByParam(paramap);
		//总页数
		int totalPage=0;
		//总数%每页数=余数：等于0----否则----总数%每页数=余数：不等于0
		if(totalRecord%pageSize==0){
			//总数/每页数=总页数
			totalPage=totalRecord/pageSize;
		}else{
			//总数/每页数+1=总页数
			totalPage=totalRecord/pageSize+1;
		}
		//开始记录数  
		int index=(page-1)*pageSize;
		paramap.put("start",index);
		JSONObject pagejson=new JSONObject();
		//根据条件查询
		List<Map<String,Object>> list=SysUserLogAccessDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);//总页数
		pagejson.put("page", page);//当前页数
		pagejson.put("records", totalRecord);//总记录数
		
		JSONArray listjson=new JSONArray();
		for(Map<String,Object> loginlog:list){
			JSONObject obj=new JSONObject();
			obj.put("account",loginlog.get("account")!=null?loginlog.get("account").toString():"");
			obj.put("name",loginlog.get("name")!=null?loginlog.get("name").toString():"");
			obj.put("ip",loginlog.get("ip")!=null?loginlog.get("ip").toString():"");
			obj.put("createDate",loginlog.get("createDate")!=null?loginlog.get("createDate").toString():"");
			listjson.add(obj);
		}
		pagejson.put("rows",listjson);//记录列表
		return pagejson.toJSONString();
	}
	/**
	 * 添加
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap){
		SysUserLogAccessDao.save(paramap);
	}
}
