package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface AccountRecordDao extends BaseDao {

	/**
	 * 押金项目数量统计
	 * 
	 * @return
	 */
	public List<Map<String, Object>> findItemNum(Map<String, Object> paramap);

}
