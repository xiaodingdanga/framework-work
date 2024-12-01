package com.lx.framework.system.service;

import java.util.Map;

public interface SysLoginLogService{
	/**
	 * 根据条件分页查询
	 * @param paramap
	 * @return
	 */
	public String findPageByParam(Map<String,Object> paramap);
	/**
	 * 添加
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap);
}
