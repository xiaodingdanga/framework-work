package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface MessageService {
	/**
	 * 根据条件查询系统通知
	 * @param paramap
	 * @return
	 */
	public String findPageByParam(Map<String,Object> paramap);
	/**
	 * 根据条件分页查询商户
	 * @param paramap
	 * @return
	 */
	public String findCustomerPageByParam(Map<String,Object> paramap);
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap);
	/**
	 * 根据ID查询系统通知
	 * @param paramap
	 * @return
	 */
	public Map<String, Object> findById(String id);
	/**
	 * 根据系统通知ID查询商户信息
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMessageId(String messageid);
	/**
	 * 更新信息
	 * @param paramap
	 * @return
	 */
	public void update(Map<String, Object> paramap);
	/**
	 * 删除
	 * @param paramap
	 * @return
	 */
	public void delete(String id);
	/**
	 * 开关
	 * @param paramap
	 * @return
	 */
	public void show(Map<String, Object> paramap);
	/**
	 * 首页根据条件查询系统通知
	 * @param paramap
	 * @return
	 */
	public String findHomePageByParam(Map<String,Object> paramap);
	/**
	 * 首页根据条件查询系统通知5条
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
}
