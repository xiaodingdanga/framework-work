package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface ReportService {
	
	/**
	 * 日计算报表查询
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	public String findDailySettlementReport(Map<String,Object> paramap);

	
	/**
	 * 单项日结查询
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	public String findDailySettlement(Map<String,Object> paramap);
	
	/**
	 * 根据条件分页查询（预售票明细）
	 * @param paramap
	 * @return
	 */
	public String findAdvanceRecordPageByParam(Map<String,Object> paramap);
	
	/**
	 * 根据条件查询所有（预售票明细）
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap);
	
	/**
	 * 根据条件分页查询（商品销售）
	 * @param paramap
	 * @return
	 */
	public String findSaleGoodsPageByParam(Map<String,Object> paramap);
	/**
	 * 商品销售导出
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> saleGoodsExport(Map<String, Object> paramap);
	
	/**
	 * 根据条件分页查询（流水）
	 * @param paramap
	 * @return
	 */
	public String findRecordPageByParam(Map<String,Object> paramap);
	/**
	 * 流水导出
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> recordExport(Map<String, Object> paramap);
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
	/**
	 * 押金项目数量统计
	 * 
	 * @return
	 */
	public String findItemNum(Map<String, Object> paramap);
}
