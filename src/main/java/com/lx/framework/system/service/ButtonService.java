package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface ButtonService{
	/**
	 * 根据menuid获取数据
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
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
	 * 查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAll();
}
