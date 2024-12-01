package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface UploadFileDao extends BaseDao {

	/**
	 * 根据条件查询所有
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByParam(String idarr[]);

	/**
	 * 根据商品ID查询所有
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByGoodsId(@Param(value = "goodsid") String goodsid);
}
