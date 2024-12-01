package com.lx.framework.system.service.impl;

import com.lx.framework.utils.util;
import com.lx.framework.system.dao.PermDao;
import com.lx.framework.system.dao.UlrDao;
import com.lx.framework.system.service.PermService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor=Exception.class)
public class PermServiceImpl implements PermService{
	Logger log = LogManager.getLogger(PermServiceImpl.class.getName());
	@Resource
	private PermDao permDao;
	@Resource
	private UlrDao ulrDao;
	
	/**
	 * 保存角色菜单及按钮权限
	 * @param paramap
	 */
	public void savesetpermission(Map<String,Object> paramap){
		//删除原有权限
		String roleid=paramap.get("roleid").toString();
		permDao.deleteByRoleIds(roleid.split(","));
		//重新授权
		String str=(paramap.get("str")!=null&&!paramap.get("str").toString().equals(""))?paramap.get("str").toString():"";
		if(!str.equals("")){
			List<Map<String,Object>> permissionlist=new ArrayList<Map<String,Object>>();
			String mbs[]=str.split(";");
			for(int i=0;i<mbs.length;i++){
				String mb[]=mbs[i].split(":");
				String menuid=mb[0];
				String buttonids="";
				if(mb.length>1){
					buttonids=mb[1];
				}
				Map<String,Object> per=new HashMap<String,Object>();
				per.put("id",util.getUuid());
				per.put("roleid",roleid);
				per.put("menuid",menuid);
				per.put("button",buttonids);
				permissionlist.add(per);
			}
			permDao.batchSave(permissionlist);
		}
	}
	/**
	 * 根据角色ID获取权限
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByRoleId(String roleid){
		return permDao.findByRoleId(roleid);
	}
	/**
	 * 保存角色相关用户
	 * @param paramap
	 */
	public void usersave(Map<String,Object> paramap){
		//删除角色关联用户
		String roleid=paramap.get("roleid").toString();
		ulrDao.deleteByRoleIds(roleid.split(","));
		List<Map<String,Object>> list=(List<Map<String,Object>>)paramap.get("list");
		if(list.size()>0){
			//保存新的角色关联用户
			ulrDao.batchSave(list);
		}
	}
	/**
	 * 根据角色ID查询用户
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findUsersByRoleid(String roleid){
		return ulrDao.findUsersByRoleid(roleid);
	}
}