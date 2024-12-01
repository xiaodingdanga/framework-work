package com.lx.framework.system.service.impl;

import com.lx.framework.system.dao.ButtonDao;
import com.lx.framework.system.service.ButtonService;
import com.lx.framework.utils.util;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly=false,rollbackFor=Exception.class)
public class ButtonServiceImpl implements ButtonService {
	Logger log = LogManager.getLogger(ButtonServiceImpl.class.getName());
	@Resource
	private ButtonDao buttonDao;
	@Resource
	private JdbcTemplate jdbcTemplate;
	/**
	 * 根据menuid获取数据
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap){
		List<Map<String,Object>> list=buttonDao.findAllByParam(paramap);
		for(Map<String,Object> map:list){
			String isuse=map.get("isuse").toString();
			if(isuse.equals("1")){
				isuse="是";
			}else{
				isuse="否";
			}
			map.put("isuse", isuse);
		}
		return list;
	}
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id){
		return buttonDao.findById(id);
	}
	/**
	 * 验证名称是否重复
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String,Object> paramap){
		return buttonDao.checkName(paramap);
	}
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap){
		paramap.put("id", util.getUuid());
		String menuid=paramap.get("menuid").toString();
		int maxsort=buttonDao.getMaxSort(menuid);
		paramap.put("sort",maxsort+5);
		buttonDao.save(paramap);
	}
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap){
		String id=paramap.get("id").toString();
		Map<String,Object> valmap=buttonDao.findById(id);
		String newmenuid=paramap.get("menuid")==null?"":paramap.get("menuid").toString();
		String oldmenuid=valmap.get("menuid")==null?"":valmap.get("menuid").toString();
		if(!newmenuid.equals(oldmenuid)){
			int maxsort=buttonDao.getMaxSort(newmenuid);
			valmap.put("sort",maxsort+5);
		}
		valmap.put("name",paramap.get("name").toString());
		valmap.put("menuid", newmenuid);
		valmap.put("isuse", paramap.get("isuse")==null?"":paramap.get("isuse").toString());
		buttonDao.update(valmap);
	}
	/**
	 * 删除
	 * @param ids
	 */
	public void delete(String id){
		//删除按钮
		buttonDao.delete(id);
		String ids=id+",";
		//处理权限
		String sql="UPDATE sys_perm SET button=REPLACE(button,'"+ids+"','')";
		jdbcTemplate.execute(sql);
	}
	/**
	 * 查询所有
	 * @return
	 */
	public List<Map<String,Object>> findAll(){
		return buttonDao.findAll();
	}
}
