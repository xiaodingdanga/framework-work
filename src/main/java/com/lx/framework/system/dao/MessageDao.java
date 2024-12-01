package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageDao extends BaseDao{
	/**
	 * 根据条件分页查询商户总数
	 * @param paramap
	 * @return
	 */
	public int getCustomerCountByParam(Map<String,Object> paramap);
	/**
	 * 根据条件分页查询商户
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findCustomerPageByParam(Map<String,Object> paramap);
	/**
	 * 根据系统通知ID查询商户信息
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMessageId(@Param(value="messageid")String messageid);
	/**
	 * 根据系统通知ID删除商户信息
	 * @param messageid
	 */
	public void deleteByMessageId(@Param(value="messageid")String messageid);
	/**
	 * 开关
	 * @param id
	 */
	public void show(Map<String,Object> paramap);
	/**
	 * 首页根据条件查询系统通知总数
	 * @param paramap
	 * @return
	 */
	public int getHomeCountByParam(Map<String,Object> paramap);
	/**
	 * 首页根据条件查询系统通知
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findHomePageByParam(Map<String,Object> paramap);
	/**
	 * 首页根据条件查询系统通知5条
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
	/**
	 * 保存库存消息记录
	 * @param messagelist
	 */
	public void batchMessageSave(List<Map<String,Object>> messagelist);
}
