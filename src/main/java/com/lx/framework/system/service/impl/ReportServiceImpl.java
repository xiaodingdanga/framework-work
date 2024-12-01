package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.utils.util;
import com.lx.framework.system.dao.AccountRecordDao;
import com.lx.framework.system.dao.PaymentDao;
import com.lx.framework.system.dao.ReportDao;
import com.lx.framework.system.service.ReportService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class ReportServiceImpl implements ReportService {

	Logger log = LogManager.getLogger(ReportServiceImpl.class.getName());

	@Resource
	private ReportDao reportDao;

	@Resource
	private PaymentDao paymentDao;

	@Resource
	private AccountRecordDao accountRecordDao;

	@Override
	public String findSaleGoodsPageByParam(Map<String, Object> paramap) {

		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = reportDao.findSaleGoodsCountByParam(paramap);
		// 总页数
		int totalPage = 0;
		// 总数%每页数=余数：等于0----否则----总数%每页数=余数：不等于0
		if (totalRecord % pageSize == 0) {
			// 总数/每页数=总页数
			totalPage = totalRecord / pageSize;
		} else {
			// 总数/每页数+1=总页数
			totalPage = totalRecord / pageSize + 1;
		}
		// 开始记录数
		int index = (page - 1) * pageSize;
		paramap.put("start", index);
		JSONObject pagejson = new JSONObject();
		List<Map<String, Object>> listPayType = paymentDao.findByCustomerId(paramap);
		// 根据条件查询
		List<Map<String, Object>> list = reportDao.findSaleGoodsPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> listmap : list) {// id,customerid,goodsid,shopid,userid,paymentid,amount,num,price,creattime,username,customername
			JSONObject obj = new JSONObject();// goodsname
			String price = listmap.get("price") != null ? listmap.get("price").toString() : "";
			String amount = listmap.get("amount") != null ? listmap.get("amount").toString() : "";
			String paymentid = listmap.get("paymentid") != null ? listmap.get("paymentid").toString() : "";
			for (Map<String, Object> map : listPayType) {
				if (paymentid.equals(map.get("id").toString())) {
					paymentid = map.get("name").toString();
				}
			}
			obj.put("id", listmap.get("id") != null ? listmap.get("id").toString() : "");
			obj.put("paymentid", paymentid);
			obj.put("amount", this.intToDouble(amount));
			obj.put("price", this.intToDouble(price));
			obj.put("creattime", listmap.get("creattime") != null ? listmap.get("creattime").toString() : "");
			obj.put("username", listmap.get("username") != null ? listmap.get("username").toString() : "");
			obj.put("num", listmap.get("num") != null ? listmap.get("num").toString() : "");
			obj.put("customername", listmap.get("customername") != null ? listmap.get("customername").toString() : "");
			obj.put("goodsname", listmap.get("goodsname") != null ? listmap.get("goodsname").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public List<Map<String, Object>> saleGoodsExport(Map<String, Object> paramap) {
		return reportDao.findSaleGoodsExport(paramap);
	}

	@Override
	public String findRecordPageByParam(Map<String, Object> paramap) {
		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = reportDao.findRecordCountByParam(paramap);
		// 总页数
		int totalPage = 0;
		// 总数%每页数=余数：等于0----否则----总数%每页数=余数：不等于0
		if (totalRecord % pageSize == 0) {
			// 总数/每页数=总页数
			totalPage = totalRecord / pageSize;
		} else {
			// 总数/每页数+1=总页数
			totalPage = totalRecord / pageSize + 1;
		}
		// 开始记录数
		int index = (page - 1) * pageSize;
		paramap.put("start", index);
		JSONObject pagejson = new JSONObject();
		// 根据条件查询
		List<Map<String, Object>> list = reportDao.findRecordPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> listmap : list) {// id,customerid,classify,amount,pay_in,paymentid,salegoodsid,salecardid,saleticketid
			JSONObject obj = new JSONObject();// creattime,cardname,goodsname,ticketname,customername
			String amount = listmap.get("amount") != null ? listmap.get("amount").toString() : "";
			obj.put("id", listmap.get("id") != null ? listmap.get("id").toString() : "");
			obj.put("classify", listmap.get("classify") != null ? listmap.get("classify").toString() : "");
			obj.put("status", listmap.get("status") != null ? listmap.get("status").toString() : "");
			obj.put("amount", this.intToDouble(amount));
			obj.put("pay_in", listmap.get("pay_in") != null ? listmap.get("pay_in").toString() : "");
			obj.put("paymentid", listmap.get("paymentid") != null ? listmap.get("paymentid").toString() : "");
			obj.put("payment", listmap.get("payment") != null ? listmap.get("payment").toString() : "");
			obj.put("creattime", listmap.get("creattime") != null ? listmap.get("creattime").toString() : "");
			obj.put("code", listmap.get("code") != null ? listmap.get("code").toString() : "");
			obj.put("goodsname", listmap.get("goodsname") != null ? listmap.get("goodsname").toString() : "");
			obj.put("ticketname", listmap.get("ticketname") != null ? listmap.get("ticketname").toString() : "");
			obj.put("username", listmap.get("username") != null ? listmap.get("username").toString() : "");
			obj.put("customername", listmap.get("customername") != null ? listmap.get("customername").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public List<Map<String, Object>> recordExport(Map<String, Object> paramap) {
		return reportDao.findRecordExport(paramap);
	}

	public double intToDouble(String price) {
		int price_int = Integer.parseInt(price);
		double price_double = ((double) price_int) / 100;
		return price_double;
	}

	public int doubleToInt(String price) {
		double price_double = Double.parseDouble(price);
		int price_int = (int) (price_double * 100);
		return price_int;
	}

	public String retainTwo(double d) {
		DecimalFormat df = new DecimalFormat("#.00");
		if (d < 1) {
			return "0" + df.format(d);
		} else {
			return df.format(d);
		}
	}

	@Override
	public String findAdvanceRecordPageByParam(Map<String, Object> paramap) {
		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = accountRecordDao.getCountByParam(paramap);
		// 总页数
		int totalPage = 0;
		// 总数%每页数=余数：等于0----否则----总数%每页数=余数：不等于0
		if (totalRecord % pageSize == 0) {
			// 总数/每页数=总页数
			totalPage = totalRecord / pageSize;
		} else {
			// 总数/每页数+1=总页数
			totalPage = totalRecord / pageSize + 1;
		}
		// 开始记录数
		int index = (page - 1) * pageSize;
		paramap.put("start", index);
		JSONObject pagejson = new JSONObject();
		// 根据条件查询
		List<Map<String, Object>> list = accountRecordDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> listmap : list) {
			JSONObject obj = new JSONObject();
			obj.put("id", listmap.get("id") != null ? listmap.get("id").toString() : "");
			obj.put("dname", listmap.get("dname") != null ? listmap.get("dname").toString() : "");
			obj.put("status", listmap.get("status") != null ? listmap.get("status").toString() : "");
			obj.put("ticketname", listmap.get("ticketname") != null ? listmap.get("ticketname").toString() : "");
			String amount = listmap.get("amount") != null ? listmap.get("amount").toString() : "";
			obj.put("amount", this.intToDouble(amount));
			String price = listmap.get("price") != null ? listmap.get("price").toString() : "";
			obj.put("price", this.intToDouble(price));
			String num = String.valueOf(Integer.valueOf(amount) / Integer.valueOf(price));
			obj.put("num", num);
			obj.put("pname", listmap.get("pname") != null ? listmap.get("pname").toString() : "");
			obj.put("creattime", listmap.get("creattime") != null ? listmap.get("creattime").toString() : "");
			obj.put("username", listmap.get("username") != null ? listmap.get("username").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public List<Map<String, Object>> findAllByParam(Map<String, Object> paramap) {
		return accountRecordDao.findAllByParam(paramap);
	}

	@Override
	public List<Map<String, Object>> findUsersByRole(Map<String, Object> paramap) {
		return reportDao.findUsersByRole(paramap);
	}

	@Override
	public List<Map<String, Object>> findTotalMenoy(Map<String, Object> paramap) {
		return reportDao.findTotalMenoy(paramap);
	}

	@Override
	public String findDailySettlement(Map<String, Object> paramap) {
		// 根据条件查询
		List<Map<String, Object>> list = reportDao.findDailySettlement(paramap);
		JSONObject pagejson = new JSONObject();
		JSONArray listjson = new JSONArray();
		if (null != list && !list.isEmpty() && null != list.get(0)) {
			Integer amountSum = 0;
			JSONObject obj = null;
			for (Map<String, Object> listmap : list) {
				obj = new JSONObject();
				Integer amount = Integer.valueOf(listmap.getOrDefault("amount", 0).toString());
				amountSum += amount;
				obj.put("amount", this.intToDouble(amount.toString()));
				obj.put("customername", listmap.getOrDefault("customername", "").toString());
				obj.put("username", listmap.getOrDefault("username", "").toString());
				obj.put("payment", listmap.getOrDefault("payment", "").toString());
				obj.put("paymentid", listmap.getOrDefault("paymentid", "").toString());
				obj.put("classify", listmap.getOrDefault("classify", "").toString());
				listjson.add(obj);
			}
			obj = new JSONObject();
			obj.put("amount", this.intToDouble(amountSum.toString()));
			obj.put("customername", "");
			obj.put("username", "日期：" + util.datetostring(new Date(), "yyyy年MM月dd日"));
			obj.put("payment", "合计收入金额:");
			obj.put("paymentid", "");
			obj.put("classify", "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public String findDailySettlementReport(Map<String, Object> paramap) {
		// 根据条件查询
		List<Map<String, Object>> list = reportDao.findDailySettlementReport(paramap);
		JSONObject pagejson = new JSONObject();
		JSONArray listjson = new JSONArray();
		if (null != list && !list.isEmpty() && null != list.get(0)) {
			JSONObject obj = null;
			obj = new JSONObject();
			obj.put("payment", "");
			obj.put("customername", "");
			obj.put("username", "");
			obj.put("amount", "日期：" + paramap.get("startdate").toString() + " - " + paramap.get("enddate").toString());
			obj.put("classify", "");
			listjson.add(obj);
			for (Map<String, Object> listmap : list) {
				obj = new JSONObject();
				obj.put("customername", listmap.getOrDefault("customername", "").toString());
				Double amount = this.intToDouble(listmap.getOrDefault("amount", 0).toString());
				String username = listmap.getOrDefault("username", "").toString();
				String payment = listmap.getOrDefault("payment", "").toString();
				String classify = listmap.getOrDefault("classify", "").toString();
				obj.put("username", username);
				obj.put("payment", payment);
				obj.put("classify", classify);
				obj.put("amount", username + " " + payment + " " + classify + "金额：" + amount);
				listjson.add(obj);
			}
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	@Override
	public String findItemNum(Map<String, Object> paramap) {
		// 根据条件查询
		List<Map<String, Object>> list = accountRecordDao.findItemNum(paramap);
		JSONObject pagejson = new JSONObject();
		JSONArray listjson = new JSONArray();
		if (null != list && !list.isEmpty() && null != list.get(0)) {
			Integer sum = 0;
			JSONObject obj = new JSONObject();
			obj.put("num", "");
			obj.put("ticketname",
					"日期：" + paramap.get("startdate").toString() + " - " + paramap.get("enddate").toString());
			listjson.add(obj);
			for (Map<String, Object> listmap : list) {
				obj = new JSONObject();
				obj.put("ticketname", listmap.getOrDefault("ticketname", "").toString());
				Integer num = Integer.valueOf(listmap.getOrDefault("num", 0).toString());
				sum += num;
				obj.put("num", num.toString());
				listjson.add(obj);
			}
			obj = new JSONObject();
			obj.put("num", sum.toString());
			obj.put("ticketname", "合计数量：");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}
}
