package com.lx.framework.system.service;

import java.util.Map;

public interface CustomerService {

	/**
	 * 根据条件查询所有
	 * 
	 * @return
	 */
	public String findAllByParam(Map<String, Object> paramap);

	/**
	 * 根据条件分页查询
	 * 
	 * @param paramap
	 * @return
	 */
	public String findPageByParam(Map<String, Object> paramap);

	/**
	 * 保存主订单
	 * 
	 * @param paramap
	 */
	public void save(Map<String, Object> paramap);

	/**
	 * 根据ID查询
	 * 
	 * @param paramap
	 * @return
	 */
	public Map<String, Object> findById(String id);

	/**
	 * 更新
	 * 
	 * @param paramap
	 */
	public void update(Map<String, Object> paramap);

	/**
	 * 批量删除
	 * 
	 * @param paramap
	 * @return
	 */
	public void batchDelete(String ids[]);

	/**
	 * 根据用户ID删除主订单
	 * 
	 * @param paramap
	 * @return
	 */
	public void delete(String id);

}
