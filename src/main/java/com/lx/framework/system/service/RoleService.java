package com.lx.framework.system.service;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleService{
	
	public String findPageByParam(Map<String,Object> paramap);
	/**
	 * 验证角色名称是否重复
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String,Object> paramap);
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap);
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id);
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap);
	/**
	 * 批量删除
	 * @param id
	 */
	public void batchDelete(String ids[]);
	/**
	 * 删除
	 * @param id
	 */
	public void delete(String id);
	/**
	 * 根据用户ID查询所有角色
	 * @param rolemap
	 * @return
	 */
	public List<Map<String,Object>> findRoleByUserid(String userid);
	/**
	 * 根据des查询role
	 * @param des
	 * @return
	 */
	public Map<String,Object> findByDes(@Param(value="des")String des);
}
