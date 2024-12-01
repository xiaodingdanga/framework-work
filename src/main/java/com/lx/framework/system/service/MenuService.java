package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface MenuService{
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id);
	/**
	 * 验证名称是否重复
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
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap);
	/**
	 * 删除
	 * @param ids
	 */
	public void delete(String id);
	/**
	 * 根据条件查询
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
	/**
	 * 根据父级pid获取
	 * @return
	 */
	public List<Map<String,Object>> findByPid(String pid);
	/**
	 * 根据菜单ID数组及父级菜单ID查询菜单集合
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMenuIds(String id[],String parentid);
	/**
	 * 根据菜单ID数组查询子节点数量
	 * @param ids
	 * @return
	 */
	public List<Map<String,Object>> findMenuChildnum(String ids[]);
}