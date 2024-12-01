package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface UserService{
	/**
	 * 根据条件分页查询
	 * @param paramap
	 * @return
	 */
	public String findPageByParam(Map<String,Object> paramap);
	/**
	 * 验证账号是否重复
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
	 * 根据账号获取用户信息
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> getByAccount(String account);
	/**
	 * 重置密码
	 * @param paramap
	 */
	public void resetPassword(Map<String,Object> paramap);
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap);
	/**
	 * 根据用户ID删除
	 * @param paramap
	 * @return
	 */
	public void batchDelete(String ids[]);
	/**
	 * 根据用户ID删除
	 * @param paramap
	 * @return
	 */
	public void delete(String id);
	/**
	 * 根据用户ID数组查询用户集合
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> findByUserIds(String userid[]);
	/**
	 * 用户查询
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
	/**
	 * 获取所有用户
	 * @return
	 */
	public Map<String,Object> getUsers();
	/**
	 * 批量导入
	 */
	public void importdata(List<String[]> datalist);
}
