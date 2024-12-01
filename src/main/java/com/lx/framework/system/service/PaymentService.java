package com.lx.framework.system.service;

import java.util.List;
import java.util.Map;

public interface PaymentService {

	public String findPageByParam(Map<String, Object> paramap);

	public void save(Map<String, Object> paramap);

	public void update(Map<String, Object> paramap);

	public Map<String, Object> findById(String id);

	public void delete(String disid);

	public boolean checkName(Map<String, Object> paramap);
	
	public String loadpaymentid(Map<String,Object> paramap);
	
	public List<Map<String,Object>> findAllByCustomerId(String customerid);
}
