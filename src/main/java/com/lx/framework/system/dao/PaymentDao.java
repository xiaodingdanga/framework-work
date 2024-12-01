package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Mapper
public interface PaymentDao extends BaseDao{
	/**
	 * 根据CustomerId查询
	 * @param paramapmap
	 * @return
	 */
	public List<Map<String, Object>> findByCustomerId(Map<String, Object> paramapmap);
}
