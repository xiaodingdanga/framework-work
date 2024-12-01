package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface PermService{
	/**
	 * 保存角色菜单及按钮权限
	 * @param paramap
	 */
	public void savesetpermission(Map<String,Object> paramap);
	/**
	 * 根据角色ID获取权限
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByRoleId(String roleid);
	/**
	 * 保存角色相关用户
	 * @param paramap
	 */
	public void usersave(Map<String,Object> paramap);
	/**
	 * 根据角色ID查询用户
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findUsersByRoleid(String roleid);
}