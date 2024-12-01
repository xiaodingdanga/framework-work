package com.lx.framework.system.dao;

import com.lx.framework.base.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReportDao extends BaseDao{
	
	/**
	 * 日计算报表查询
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	public List<Map<String,Object>> findDailySettlementReport(Map<String,Object> paramap);
	
	/**
	 * 单项日结查询
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	public List<Map<String,Object>> findDailySettlement(Map<String,Object> paramap);
	
	/**
	 * 商品销售明细
	 * @param param
	 * @return
	 */
	public int findSaleGoodsCountByParam(Map<String,Object> param);
	/**
	 *  商品销售明细
	 * @param param
	 * @return
	 */
	public List<Map<String,Object>> findSaleGoodsPageByParam(Map<String,Object> param);
	/**
	 *  商品销售明细导出
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findSaleGoodsExport(Map<String, Object> paramap);
	/**
	 * 流水明细
	 * @param param
	 * @return
	 */
	public int findRecordCountByParam(Map<String,Object> param);
	/**
	 *  流水明细
	 * @param param
	 * @return
	 */
	public List<Map<String,Object>> findRecordPageByParam(Map<String,Object> param);
	/**
	 *  流水明细导出
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findRecordExport(Map<String, Object> paramap);
	/**
	 *  根据roleid查找用户
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findUsersByRole(Map<String, Object> paramap);
	/**
	 *  在流水表中查询总流入支出
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findTotalMenoy(Map<String, Object> paramap);

}
