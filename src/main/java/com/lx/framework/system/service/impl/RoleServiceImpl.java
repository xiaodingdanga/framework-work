package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.utils.util;
import com.lx.framework.system.dao.PermDao;
import com.lx.framework.system.dao.RoleDao;
import com.lx.framework.system.dao.UlrDao;
import com.lx.framework.system.service.RoleService;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor=Exception.class)
public class RoleServiceImpl implements RoleService{
	Logger log = LogManager.getLogger(RoleServiceImpl.class.getName());
	@Resource
	private RoleDao roleDao;
	@Resource
	private PermDao permDao;
	@Resource
	private UlrDao ulrDao;
	
	public String findPageByParam(Map<String,Object> paramap){
		//当前每页行数
		int pageSize=Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize",pageSize);
		//当前页数
		int page=Integer.parseInt(paramap.get("page").toString());
		//总记录数 
		int totalRecord=roleDao.getCountByParam(paramap);
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
		List<Map<String,Object>> list=roleDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);//总页数
		pagejson.put("page", page);//当前页数
		pagejson.put("records", totalRecord);//总记录数
		
		JSONArray listjson=new JSONArray();
		for(Map<String,Object> rolemap:list){
			JSONObject obj=new JSONObject();
			obj.put("id",rolemap.get("id").toString());
			obj.put("name",rolemap.get("name").toString());
			String issys=rolemap.get("issys")!=null?rolemap.get("issys").toString():"0";
			obj.put("issys1",issys);
			if(issys.equals("1")){
				obj.put("issys","是");
			}else{
				obj.put("issys","否");
			}
			listjson.add(obj);
		}
		pagejson.put("rows",listjson);//记录列表
		return pagejson.toJSONString();
	}
	/**
	 * 验证角色名称是否重复
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String,Object> paramap){
		return roleDao.checkName(paramap);
	}
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap){
		//保存的ID
		String id=util.getUuid();
		paramap.put("id",id);
		paramap.put("issys","0");
		paramap.put("des","");
		int sort=roleDao.getMaxSort(paramap);
		paramap.put("sort",sort+5);
		paramap.put("data","2");
		roleDao.save(paramap);
	}
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id){
		return roleDao.findById(id);
	}
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap){
		String id=paramap.get("id").toString();
		Map<String,Object> rolemap=roleDao.findById(id);
		rolemap.put("name", paramap.get("name").toString());
		String data=paramap.get("data")!=null?paramap.get("data").toString():"";
		if(!data.equals("")){
			rolemap.put("data", data);
		}
		roleDao.update(rolemap);
	}
	/**
	 * 删除
	 * @param id
	 */
	public void batchDelete(String ids[]){
		//删除角色
		roleDao.batchDelete(ids);
		//删除角色权限
		permDao.deleteByRoleIds(ids);
		//删除角色所属用户
		ulrDao.deleteByRoleIds(ids);
	}
	/**
	 * 删除
	 * @param id
	 */
	public void delete(String id){
		//删除角色
		roleDao.delete(id);
		//删除角色权限
		permDao.deleteByRoleIds(id.split(","));
		//删除角色所属用户
		ulrDao.deleteByRoleIds(id.split(","));
	}
	/**
	 * 根据用户ID查询所有角色
	 * @param rolemap
	 * @return
	 */
	public List<Map<String,Object>> findRoleByUserid(String userid){
		return roleDao.findRoleByUserid(userid);
	}
	/**
	 * 根据des查询role
	 * @param des
	 * @return
	 */
	public Map<String,Object> findByDes(@Param(value="des")String des){
		return roleDao.findByDes(des);
	}
}
