package com.lx.framework.system.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.utils.MD5Util;
import com.lx.framework.utils.util;
import com.lx.framework.system.dao.UlrDao;
import com.lx.framework.system.dao.UserDao;
import com.lx.framework.system.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {

	Logger log = LogManager.getLogger(UserServiceImpl.class.getName());

	@Resource
	private UserDao usersDao;

	@Resource
	private UlrDao ulrDao;

	/**
	 * 根据条件分页查询
	 */
	public String findPageByParam(Map<String, Object> paramap) {
		// 当前每页行数
		int pageSize = Integer.parseInt(paramap.get("rows").toString());
		paramap.put("pageSize", pageSize);
		// 当前页数
		int page = Integer.parseInt(paramap.get("page").toString());
		// 总记录数
		int totalRecord = usersDao.getCountByParam(paramap);
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
		List<Map<String, Object>> list = usersDao.findPageByParam(paramap);
		pagejson.put("total", totalPage);// 总页数
		pagejson.put("page", page);// 当前页数
		pagejson.put("records", totalRecord);// 总记录数
		JSONArray listjson = new JSONArray();
		for (Map<String, Object> usermap : list) {
			JSONObject obj = new JSONObject();
			String userid = usermap.get("id").toString();
			obj.put("id", userid);
			obj.put("account", usermap.get("account").toString());
			obj.put("name", usermap.get("name").toString());
			obj.put("tel", usermap.get("tel") != null ? usermap.get("tel").toString() : "");
			obj.put("email", usermap.get("email") != null ? usermap.get("email").toString() : "");
			obj.put("des", (usermap.get("des") != null && !usermap.get("des").toString().equals(""))
					? usermap.get("des").toString() : "0");
			obj.put("customerid", usermap.get("customerid") != null ? usermap.get("customerid").toString() : "");
			obj.put("customername", usermap.get("customername") != null ? usermap.get("customername").toString() : "");
			listjson.add(obj);
		}
		pagejson.put("rows", listjson);// 记录列表
		return pagejson.toJSONString();
	}

	/**
	 * 验证账号是否重复
	 * 
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String, Object> paramap) {
		return usersDao.checkName(paramap);
	}

	/**
	 * 保存
	 * 
	 * @param paramap
	 */
	public void save(Map<String, Object> paramap) {
		// 保存的ID
		String id = util.getUuid();
		String password = MD5Util.getMD5(paramap.get("password").toString());
		paramap.put("id", id);
		paramap.put("password", password);
		paramap.put("isdel", "0");
		paramap.put("des", "0");
		int sort = usersDao.getMaxSort();
		paramap.put("sort", sort + 5);
		usersDao.save(paramap);
	}

	/**
	 * 根据ID查询实例
	 * 
	 * @param paramap
	 * @return
	 */
	public Map<String, Object> findById(String id) {
		return usersDao.findById(id);
	}

	/**
	 * 根据账号获取用户信息
	 * 
	 * @param paramap
	 * @return
	 */
	public Map<String, Object> getByAccount(String account) {
		return usersDao.getByAccount(account);
	}

	/**
	 * 重置密码
	 * 
	 * @param paramap
	 */
	public void resetPassword(Map<String, Object> paramap) {
		usersDao.resetPassword(paramap);
	}

	/**
	 * 更新
	 * 
	 * @param paramap
	 */
	public void update(Map<String, Object> paramap) {
		String userid = paramap.get("id").toString();
		Map<String, Object> usermap = usersDao.findById(userid);
		usermap.put("account", paramap.get("account").toString());
		usermap.put("name", paramap.get("name").toString());
		usermap.put("tel", paramap.get("tel").toString());
		usermap.put("email", paramap.get("email").toString());
		String password = paramap.get("password") != null ? paramap.get("password").toString() : "";
		if (!password.equals("")) {
			password = MD5Util.getMD5(password);
			usermap.put("password", password);
		}
		// 更新用户
		usersDao.update(usermap);
	}

	/**
	 * 根据用户ID删除
	 * 
	 * @param paramap
	 * @return
	 */
	public void batchDelete(String ids[]) {
		// 删除用户
		usersDao.batchDelete(ids);
		// 删除用户-角色映射关系
		ulrDao.deleteByUserIds(ids);
	}

	/**
	 * 根据用户ID删除
	 * 
	 * @param paramap
	 * @return
	 */
	public void delete(String id) {
		// 删除用户
		usersDao.batchDelete(id.split(","));
		// 删除用户-角色映射关系
		ulrDao.deleteByUserIds(id.split(","));
	}

	/**
	 * 根据用户ID数组查询用户集合
	 * 
	 * @param userid
	 * @return
	 */
	public List<Map<String, Object>> findByUserIds(String userid[]) {
		return usersDao.findByUserIds(userid);
	}

	/**
	 * 用户查询
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByParam(Map<String, Object> paramap) {
		return usersDao.findAllByParam(paramap);
	}

	/**
	 * 获取所有用户
	 * 
	 * @return
	 */
	public Map<String, Object> getUsers() {
		Map<String, Object> alluser = new HashMap<String, Object>();
		List<Map<String, Object>> alllist = usersDao.findAllByParam(new HashMap<String, Object>());
		for (Map<String, Object> map : alllist) {
			String account = map.get("account").toString();
			String id = map.get("id").toString();
			alluser.put(account, id);
		}
		return alluser;
	}

	/**
	 * 批量导入
	 */
	public void importdata(List<String[]> datalist) {
		int sort = usersDao.getMaxSort();
		List<Map<String, Object>> userlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> uldlist = new ArrayList<Map<String, Object>>();
		for (Object[] obj : datalist) {
			String account = (String) obj[0];// 账号
			String name = (String) obj[1];// 姓名
			String depid = (String) obj[2];// 所属部门
			String tel = (String) obj[3];// 电话
			String email = (String) obj[4];// EMAIL
			String userid = util.getUuid();// ID
			String password = MD5Util.getMD5("123456");// 密码
			// 用户信息
			Map<String, Object> usermap = new HashMap<String, Object>();
			usermap.put("id", userid);
			usermap.put("password", password);
			usermap.put("account", account);
			usermap.put("name", name);
			usermap.put("tel", tel);
			usermap.put("email", email);
			usermap.put("isdel", "");
			usermap.put("des", "");
			sort = sort + 5;
			usermap.put("sort", sort);
			usermap.put("customerid", "");
			userlist.add(usermap);
			if (!depid.equals("")) {
				String depidstr[] = depid.split(",");
				for (String dep : depidstr) {
					if (!dep.equals("0")) {
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("id", util.getUuid());
						map.put("userid", userid);
						map.put("depid", dep);
						uldlist.add(map);
					}
				}
			}
		}
		// 用户批量保存
		usersDao.batchSave(userlist);
	}
}
