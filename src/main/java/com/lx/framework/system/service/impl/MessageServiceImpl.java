package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.utils.util;
import com.lx.framework.system.dao.MessageDao;
import com.lx.framework.system.service.MessageService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor=Exception.class)
public class MessageServiceImpl implements MessageService {
	Logger log = LogManager.getLogger(RoleServiceImpl.class.getName());
	@Resource
	private MessageDao messagedao;
	/**
	 * 根据条件查询系统通知
	 * @param paramap
	 * @return
	 */
	public String findPageByParam(Map<String,Object> paramap){
		//当前每页行数
		int pageSize=Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize",pageSize);
		//当前页数
		int page=Integer.parseInt(paramap.get("page").toString());
		//总记录数 
		int totalRecord=messagedao.getCountByParam(paramap);
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
		List<Map<String,Object>> list=messagedao.findPageByParam(paramap);
		pagejson.put("total", totalPage);//总页数
		pagejson.put("page", page);//当前页数
		pagejson.put("records", totalRecord);//总记录数
		JSONArray listjson=new JSONArray();
		for(Map<String,Object> messagemap:list){
			JSONObject obj=new JSONObject();
			obj.put("id",messagemap.get("id").toString());
			obj.put("title", messagemap.get("title").toString());
			obj.put("flag",messagemap.get("flag").toString());
			obj.put("type",messagemap.get("type").toString());
			obj.put("updatetime", messagemap.get("updatetime").toString());
			listjson.add(obj);
		}
		pagejson.put("rows",listjson);//记录列表
		return pagejson.toJSONString();
	}
	/**
	 * 根据条件分页查询商户
	 * @param paramap
	 * @return
	 */
	public String findCustomerPageByParam(Map<String,Object> paramap){
		//当前每页行数
		int pageSize=Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize",pageSize);
		//当前页数
		int page=Integer.parseInt(paramap.get("page").toString());
		//总记录数 
		int totalRecord=messagedao.getCustomerCountByParam(paramap);
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
		List<Map<String,Object>> list=messagedao.findCustomerPageByParam(paramap);
		pagejson.put("total", totalPage);//总页数
		pagejson.put("page", page);//当前页数
		pagejson.put("records", totalRecord);//总记录数
		
		JSONArray listjson=new JSONArray();
		for(Map<String,Object> customermap:list){
			JSONObject obj=new JSONObject();
			String customerid=customermap.get("id").toString();
			obj.put("id",customerid);
			obj.put("customername",customermap.get("name")!=null?customermap.get("name").toString():"");
			listjson.add(obj);
		}
		pagejson.put("rows",listjson);//记录列表
		return pagejson.toJSONString();
	}
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap){
		String id=util.getUuid();
		paramap.put("id",id);
		messagedao.save(paramap);
	}
	/**
	 * 根据ID查询系统通知
	 * @param paramap
	 * @return
	 */
	public Map<String, Object> findById(String id){
		return messagedao.findById(id);
	}
	/**
	 * 根据系统通知ID查询商户信息
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMessageId(String messageid){
		return messagedao.findByMessageId(messageid);
	}
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap){
		String id=paramap.get("id").toString();
		Map<String,Object> message=messagedao.findById(id);
		String title=paramap.get("title").toString();
		String type=paramap.get("type").toString();
		String flag=paramap.get("flag").toString();
		String content=paramap.get("content").toString();
		String receive=paramap.get("receive")!=null?paramap.get("receive").toString():"";
		message.put("title", title);
		message.put("type", type);
		message.put("flag", flag);
		message.put("content", content);
		message.put("receive", receive);
		messagedao.update(message);
	}
	/**
	 * 删除
	 * @param id
	 */
	public void delete(String id){
		messagedao.delete(id);
	}
	/**
	 * 开关
	 * @param id
	 */
	public void show(Map<String,Object> paramap){
		messagedao.show(paramap);
	}
	/**
	 * 首页根据条件查询系统通知
	 * @param paramap
	 * @return
	 */
	public String findHomePageByParam(Map<String,Object> paramap){
		//当前每页行数
		int pageSize=Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize",pageSize);
		//当前页数
		int page=Integer.parseInt(paramap.get("page").toString());
		//总记录数 
		int totalRecord=messagedao.getHomeCountByParam(paramap);
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
		List<Map<String,Object>> list=messagedao.findHomePageByParam(paramap);
		pagejson.put("total", totalPage);//总页数
		pagejson.put("page", page);//当前页数
		pagejson.put("records", totalRecord);//总记录数
		JSONArray listjson=new JSONArray();
		for(Map<String,Object> messagemap:list){
			JSONObject obj=new JSONObject();
			obj.put("id",messagemap.get("id").toString());
			obj.put("title", messagemap.get("title").toString());
			obj.put("sendname", messagemap.get("sendname")!=null?messagemap.get("sendname").toString():"");
			obj.put("updatetime", messagemap.get("updatetime").toString());
			listjson.add(obj);
		}
		pagejson.put("rows",listjson);//记录列表
		return pagejson.toJSONString();
	}
	/**
	 * 首页根据条件查询系统通知5条
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap){
		return messagedao.findAllByParam(paramap);
	}
}
