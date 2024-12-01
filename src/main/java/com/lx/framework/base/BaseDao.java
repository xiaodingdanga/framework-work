package com.lx.framework.base;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BaseDao {
	/**
	 * 查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAll();
	/**
	 * 根据条件获取总数
	 * @param paramap
	 * @return
	 */
	public int getCountByParam(Map<String,Object> paramap);
	/**
	 * 根据条件分页查询
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findPageByParam(Map<String,Object> paramap);
	/**
	 * 根据条件查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
	/**
	 * 保存数据
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap);
	/**
	 * 批量保存数据
	 * @param datalist
	 */
	public void batchSave(List<Map<String,Object>> datalist);
	/**
	 * 修改数据
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap);
	/**
	 * 验证名称是否重复
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String,Object> paramap);
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(@Param(value="id") String id);
	/**
	 * 批量删除
	 * @param paramap
	 */
	public void batchDelete(String ids[]);
	/**
	 * 删除
	 * @param id
	 */
	public void delete(String id);
}
