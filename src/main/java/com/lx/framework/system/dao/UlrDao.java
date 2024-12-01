package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface UlrDao extends BaseDao {
	/**
	 * 根据角色ID删除用户角色关联--批量删除
	 * 
	 * @param paramap
	 */
	public void deleteByRoleIds(String roleid[]);

	/**
	 * 根据角色ID获取关联用户
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findUsersByRoleid(@Param(value = "roleid") String roleid);

	/**
	 * 根据用户id删除--批量删除
	 * 
	 * @param ids
	 */
	public void deleteByUserIds(String userid[]);
}
