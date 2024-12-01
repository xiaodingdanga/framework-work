package com.lx.framework.system.service.impl;

import com.lx.framework.system.dao.ConfigDao;
import com.lx.framework.system.service.ConfigService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly=false,rollbackFor=Exception.class)
public class ConfigServiceImpl implements ConfigService {
	Logger log = LogManager.getLogger(ConfigServiceImpl.class.getName());
	@Resource
	private ConfigDao configDao;
	/**
	 * 查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAll(){
		return configDao.findAll();
	}
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id){
		return configDao.findById(id);
	}
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap){
		String id=paramap.get("id").toString();
		Map<String,Object> map=configDao.findById(id);
		map.put("value",paramap.get("value")!=null?paramap.get("value").toString():"");
		configDao.update(map);
	}
}
