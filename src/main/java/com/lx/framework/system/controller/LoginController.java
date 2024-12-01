package com.lx.framework.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.*;
import com.lx.framework.utils.MD5Util;
import com.lx.framework.utils.util;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.*;

@Controller
@RequestMapping(value = "/login")
public class LoginController extends BaseController {
	Logger log = LogManager.getLogger(LoginController.class.getName());
	@Resource
	private UserService usersService;
	@Resource
	private MenuService menuService;
	@Resource
	private RoleService roleService;
	@Resource
	private PermService permService;
	@Resource
	private ButtonService buttonService;
	@Resource
	private ConfigService configService;
	@Resource
	private SysLoginLogService sysLoginLogService;

	/**
	 * 跳转到登陆页面
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value = "/tologin")
	public ModelAndView tologin(HttpServletRequest request, Model modal) {
		HttpSession session = request.getSession();
		List<Map<String, Object>> configlist = configService.findAll();
		for (Map<String, Object> map : configlist) {
			String code = map.get("code") != null ? map.get("code").toString() : "";
			String value = map.get("value") != null ? map.get("value").toString() : "";
			session.setAttribute(code, value);
		}
		return new ModelAndView("modules/login");
	}

	/**
	 * 登陆验证
	 *
	 * @param request
	 * @param modal
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validate", produces = { "text/json;charset=UTF-8" })
	public @ResponseBody String validate(HttpServletRequest request, Model modal) throws Exception {
		String ret = "0";// 默认通过
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(600 * 60);// 设置session的有效时间单位秒
		// if (true) {// LicenseGenerator.validate()){//license验证通过
		Map<String, Object> map = this.getParameter();
		// 账号
		String account = map.get("account").toString();
		// 密码
		String password = map.get("password").toString();
		Map<String, Object> user = usersService.getByAccount(account);
		if (user != null) {// 账号存在
			// MD5转换后的密码
			String md5password = MD5Util.getMD5(password);
			// 查询出的密码
			String datapassword = user.get("password").toString();
			if (!md5password.equals(datapassword) && !password.equals(datapassword)) {// 密码不一致
				ret = "2";
			} else {// 登陆成功--用户信息放入session
				session.setAttribute("user", user);
			}
		} else {// 账号不存在
			ret = "1";
		}
		// } else {// license验证不通过
		// ret = "-1";
		// }
		return ret;
	}

	/**
	 * CAS登陆验证
	 *
	 * @param request
	 * @param modal
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/casvalidate")
	public @ResponseBody String casvalidate(HttpServletRequest request, Model modal) throws Exception {
		List<Map<String, Object>> configlist = configService.findAll();
		for (Map<String, Object> map : configlist) {
			String code = map.get("code") != null ? map.get("code").toString() : "";
			String value = map.get("value") != null ? map.get("value").toString() : "";
			request.getSession().setAttribute(code, value);
		}
		String ret = "0";// 默认通过
		Map<String, Object> map = this.getParameter();
		// 账号
		String account = map.get("account").toString();
		Map<String, Object> user = usersService.getByAccount(account);
		// 登陆成功--用户信息放入session
		request.getSession().setAttribute("user", user);
		if (user == null) {// 账号不存在
			ret = "1";
		}
		return ret;
	}

	/**
	 * 登陆成功
	 *
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, Model modal) {
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(600 * 60);// 设置session的有效时间单位秒
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		String userid = user.get("id").toString();
		// 重置菜单
		session.setAttribute("menuid", "");
		session.setAttribute("menucode", "");

		// 当前用户所有角色
		List<Map<String, Object>> rolelist = roleService.findRoleByUserid(userid);
		session.setAttribute("rolelist", rolelist);

		// 获取页面参数--更改后的部门ID与角色ID
		Map<String, Object> paramap = this.getParameter();
		String roleid = paramap.get("roleid") != null ? paramap.get("roleid").toString() : "";

		// 当前角色--所有角色中的第一个
		Map<String, Object> role = new HashMap<String, Object>();
		if (!roleid.equals("")) {
			role = roleService.findById(roleid);
		} else {
			if (rolelist.size() > 0) {
				role = (Map<String, Object>) rolelist.get(0);
			}
		}
		if (!role.isEmpty() || userid.equals("1")) {
			session.setAttribute("role", role);
			// 菜单权限
			List<Map<String, Object>> menulist = getmenudata(user, role, "0");
			session.setAttribute("menulist", menulist);
			// 按钮权限
			String buttons = getButton(user, role);
			session.setAttribute("button", buttons);
		}
		// 登录日志
		Map<String, Object> loginlog = new HashMap<String, Object>();
		loginlog.put("id", util.getUuid());
		loginlog.put("userid", userid);
		loginlog.put("createDate", new Date());
		loginlog.put("ip", getIpAddr(request));
		loginlog.put("type", "0");
		loginlog.put("customerid", user.get("customerid") != null ? user.get("customerid").toString() : "");
		sysLoginLogService.save(loginlog);
		return new ModelAndView("redirect:/homepage/main");
	}

	/**
	 * 注销
	 *
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletRequest request, Model modal) {
		// 清空session
		request.getSession().invalidate();
		return new ModelAndView("redirect:/login/tologin");
	}

	/**
	 * 修改个人信息
	 *
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value = "/usertoedit")
	public ModelAndView usertoedit(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		String userid = paramap.get("id").toString();
		Map<String, Object> usermap = usersService.findById(userid);

		modal.addAttribute("valmap", usermap);
		return new ModelAndView("modules/system/user/useredit");
	}

	/**
	 * 刷新session--user
	 *
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value = "/reloadsession", produces = { "text/json;charset=UTF-8" })
	public @ResponseBody void reloadsession(HttpServletRequest request, Model modal) {
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(600 * 60);// 设置session的有效时间单位秒
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		String userid = paramap.get("id").toString();
		Map<String, Object> user = usersService.findById(userid);
		session.setAttribute("user", user);
	}

	/**
	 * 验证密码
	 *
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value = "/passwordcheck")
	public @ResponseBody String passwordcheck(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String password = user.get("password").toString();
		Map<String, Object> paramap = this.getParameter();
		String oldpassword = paramap.get("password").toString();
		String md5oldpassword = MD5Util.getMD5(oldpassword);
		if (!password.equals(md5oldpassword) && !password.equals(oldpassword)) {// 原密码不正确
			return "false";
		} else {// 正确
			return "true";
		}
	}

	/**
	 * 根据父级ID获取菜单权限
	 *
	 * @param parentid
	 * @param request
	 */
	@RequestMapping(value = "/getmenu", method = RequestMethod.POST, produces = { "text/json;charset=UTF-8" })
	public @ResponseBody String getmenu(HttpServletRequest request) {
		Map<String, Object> paramap = this.getParameter();
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		Map<String, Object> role = (Map<String, Object>) request.getSession().getAttribute("role");
		List<Map<String, Object>> menulist = getmenudata(user, role, paramap.get("menuid").toString());
		JSONArray arr = new JSONArray();
		for (Map<String, Object> menu : menulist) {
			JSONObject obj = new JSONObject();
			obj.put("id", menu.get("id").toString());
			obj.put("name", menu.get("name").toString());
			obj.put("url", menu.get("url").toString());
			obj.put("parentid", menu.get("parentid"));
			obj.put("code", menu.get("code").toString());
			obj.put("childnum", menu.get("childnum").toString());
			arr.add(obj);
		}
		return arr.toJSONString();
	}

	/**
	 * 根据角色ID及菜单父级ID获取菜单权限
	 *
	 * @param parentid
	 */
	public List<Map<String, Object>> getmenudata(Map<String, Object> user, Map<String, Object> role, String parentid) {
		List<Map<String, Object>> menulist = new ArrayList<Map<String, Object>>();
		String userid = user.get("id").toString();
		if (!userid.equals("1")) {// 其他人员----非最大系统管理员
			String roleid = role.get("id").toString();
			// 根据角色ID获取权限集合
			List<Map<String, Object>> perlist = permService.findByRoleId(roleid);
			String menusql = "";
			if (perlist.size() > 0) {
				for (Map<String, Object> permission : perlist) {
					menusql += permission.get("menuid").toString() + ",";
				}
				if (!menusql.equals("")) {
					menusql = menusql.substring(0, menusql.length() - 1);
					String menuids[] = menusql.split(",");
					menulist = menuService.findByMenuIds(menuids, parentid);
					menusql = menusql.substring(0, menusql.length());
					List<Map<String, Object>> menuchildnumlist = menuService.findMenuChildnum(menusql.split(","));
					// 查询权限内，菜单的子集个数,并赋值给菜单
					List<Map<String, Object>> mlist = new ArrayList<Map<String, Object>>();
					for (Map<String, Object> menu : menulist) {
						String menuid = menu.get("id").toString();
						for (Map<String, Object> childnum : menuchildnumlist) {
							String id = childnum.get("id").toString();
							int count = Integer.parseInt(childnum.get("COUNT").toString());
							if (menuid.equals(id)) {
								menu.put("childnum", count);
							}
						}
						mlist.add(menu);
					}
					menulist = mlist;
				}
			}
		} else {// 最大系统管理员
			menulist = menuService.findByPid(parentid);
		}
		return menulist;
	}

	/**
	 * 根据角色ID获取按钮权限
	 *
	 * @param user
	 * @param role
	 * @return
	 */
	public String getButton(Map<String, Object> user, Map<String, Object> role) {
		String buttonids = "";
		String userid = user.get("id").toString();
		if (!userid.equals("1")) {// 其他人员----非最大系统管理员
			// 角色ID
			String roleid = role.get("id").toString();
			List<Map<String, Object>> perlist = permService.findByRoleId(roleid);
			if (perlist.size() > 0) {
				for (Map<String, Object> permission : perlist) {
					String button = permission.get("button").toString();
					if (!button.equals("")) {// 按钮为空
						buttonids += button + ",";
					}
				}
			}
		} else {// 最大系统管理员
			List<Map<String, Object>> buttonlist = buttonService.findAll();// 全部按钮
			for (Map<String, Object> button : buttonlist) {
				String id = button.get("id").toString();
				buttonids += id + ",";
			}
		}
		return buttonids;
	}

	// /**
	// * 授权填写页面
	// * @param request
	// * @param modal
	// * @return
	// */
	// @RequestMapping(value="/license")
	// public ModelAndView license(HttpServletRequest request,Model modal){
	// return new ModelAndView("modules/license");
	// }
	// /**
	// * 授权请求码
	// * @param request
	// * @param modal
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping(value="/getlicenserequest")
	// public @ResponseBody String getlicenserequest(HttpServletRequest
	// request,Model modal) throws Exception{
	// //获取参数
	// Map<String,Object> paramap=this.getParameter();
	// String name=paramap.get("name").toString();
	// String today=util.today();
	// String licensestatic="name:"+name+";starttime:"+today+";";
	// return LicenseGenerator.licenserequest(licensestatic);
	// }
	// /**
	// * 授权码保存
	// * @param request
	// * @param modal
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping(value="/licensesave")
	// public @ResponseBody String licensesave(HttpServletRequest request,Model
	// modal) throws Exception{
	// //获取参数
	// Map<String,Object> paramap=this.getParameter();
	// String license=paramap.get("license").toString();
	//// System.out.println(license);
	// LicenseGenerator.save(license);
	// return "OK";
	// }
	// /**
	// * 系统信息页面
	// * @param request
	// * @param modal
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping(value="/systeminfo")
	// public ModelAndView systeminfo(HttpServletRequest request,Model modal)
	// throws Exception{
	// //系统信息
	// Map<String,Object> licensemap=LicenseGenerator.systeminfo();
	// modal.addAttribute("info",licensemap);
	// return new ModelAndView("modules/systeminfo");
	// }
	public String getIpAddr(HttpServletRequest request) {
		String ipAddress = request.getHeader("x-forwarded-for");
		if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getRemoteAddr();
			if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
				// 根据网卡取本机配置的IP
				InetAddress inet = null;
				try {
					inet = InetAddress.getLocalHost();
				} catch (UnknownHostException e) {
					e.printStackTrace();
				}
				ipAddress = inet.getHostAddress();
			}
		}
		// 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
		if (ipAddress != null && ipAddress.length() > 15) { // "***.***.***.***".length()
															// = 15
			if (ipAddress.indexOf(",") > 0) {
				ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
			}
		}
		return ipAddress;
	}
}
