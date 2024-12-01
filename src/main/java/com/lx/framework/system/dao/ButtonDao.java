package com.lx.framework.system.dao;


import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
public interface ButtonDao extends BaseDao {
	/**
	 * 获取排序最大值
	 * @return
	 */
	public int getMaxSort(@Param(value="menuid") String menuid);
	/**
	 * 根据菜单ID删除按钮
	 */
	public void deleteByMenuId(@Param(value="menuid") String menuid);
}
