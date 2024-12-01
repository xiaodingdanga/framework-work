package com.lx.framework.system.dao;


import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserDao extends BaseDao{
	/**
	 * 批量更新isdel---批量假删除
	 * @param ids
	 */
	public void batchUpdate(String[] ids);
	/**
	 * 获取排序最大值
	 * @return
	 */
	public int getMaxSort();
	/**
	 * 重置密码
	 * @param paramap
	 */
	public void resetPassword(Map<String,Object> paramap);
	/**
	 * 根据账号获取用户信息
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> getByAccount(@Param(value="account") String account);
	/**
	 * 根据用户ID数组查询用户集合
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> findByUserIds(String userid[]);
}
