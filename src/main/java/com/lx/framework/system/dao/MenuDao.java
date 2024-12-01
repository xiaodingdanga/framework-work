package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface MenuDao extends BaseDao{
	/**
	 * 根据父级pid获取
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByPid(@Param(value="pid")String pid);
	/**
	 * 获取排序最大值
	 * @return
	 */
	public int getMaxSort(@Param(value="pid")String pid);
	/**
	 * 根据菜单ID数组及父级菜单ID查询菜单集合
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMenuIds(@Param(value="id")String id[],@Param(value="pid")String pid);
	/**
	 * 根据菜单ID数组查询子节点数量
	 * @param ids
	 * @return
	 */
	public List<Map<String,Object>> findMenuChildnum(String ids[]);
}
