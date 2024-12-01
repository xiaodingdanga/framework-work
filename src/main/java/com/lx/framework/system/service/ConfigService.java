package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface ConfigService {
	/**
	 * 查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAll();
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id);
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap);
}
