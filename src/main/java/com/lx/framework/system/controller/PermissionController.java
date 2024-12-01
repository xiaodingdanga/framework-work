package com.lx.framework.system.controller;

import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.ButtonService;
import com.lx.framework.system.service.MenuService;
import com.lx.framework.system.service.PermService;
import com.lx.framework.system.service.RoleService;
import com.lx.framework.utils.util;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/permission")
public class PermissionController extends BaseController {
	Logger log = LogManager.getLogger(PermissionController.class.getName());
	@Resource
	private RoleService roleService;
	@Resource
	private MenuService menuService;
	@Resource
	private ButtonService buttonService;
	@Resource
	private PermService permService;

	/**
	 * 角色管理首页
	 * 
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value = "/setpermission")
	public ModelAndView setpermission(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		// 角色ID
		String roleid = paramap.get("id").toString();
		List<Map<String, Object>> permlist = permService.findByRoleId(roleid);

		// 当前角色所拥有的权限
		Map<String, Object> nowrole = (Map<String, Object>) request.getSession().getAttribute("role");
		String menulistperm = "";
		String Buttonperm = "";
		if (!nowrole.isEmpty()) {
			String nowroleid = nowrole.get("id").toString();
			List<Map<String, Object>> nowpermlist = permService.findByRoleId(nowroleid);
			for (Map<String, Object> perm : nowpermlist) {
				String menuid = perm.get("menuid").toString();
				String buttonids = perm.get("button").toString();
				menulistperm += menuid + ",";
				Buttonperm += buttonids;
			}
			if (!menulistperm.equals("")) {
				menulistperm = menulistperm.substring(0, menulistperm.length() - 1);
			}
			if (!Buttonperm.equals("")) {
				Buttonperm = Buttonperm.substring(0, Buttonperm.length() - 1);
			}
			// System.out.println("当前权限菜单！---------");
			// System.out.println("menulistperm:"+menulistperm);
			// System.out.println("Buttonperm:"+Buttonperm);
			// System.out.println("当前权限按钮！---------");
		}

		// 角色关联用户
		List<Map<String, Object>> userlist = permService.findUsersByRoleid(roleid);
		if (userlist.size() > 0) {
			String userid = "";
			String username = "";
			for (Map<String, Object> usermap : userlist) {
				String uid = usermap.get("userid").toString();
				String name = usermap.get("name").toString();
				userid += uid + ",";
				username += name + ",";
			}
			modal.addAttribute("userid", userid);
			modal.addAttribute("username", username);
		}
		// 获取角色---数据权限
		Map<String, Object> rolemap = roleService.findById(roleid);

		// 一级菜单查询参数
		Map<String, Object> firstparam = new HashMap<String, Object>();
		firstparam.put("isshow", "1");
		firstparam.put("pid", "0");
		firstparam.put("ids", !menulistperm.equals("") ? menulistperm.split(",") : "");
		List<Map<String, Object>> firstlist = menuService.findAllByParam(firstparam);// 一级菜单list

		List<Map<String, Object>> resultlist = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> firstMap : firstlist) {// 遍历一级菜单
			// 一菜单按钮查询参数
			String firstmenuid = firstMap.get("id").toString();
			Map<String, Object> firstbtparamap = new HashMap<String, Object>();
			firstbtparamap.put("menuid", firstmenuid);
			firstbtparamap.put("isuse", "1");
			firstbtparamap.put("ids", !Buttonperm.equals("") ? Buttonperm.split(",") : "");
			// 一级菜单按钮查询
			List<Map<String, Object>> firstbtnlist = buttonService.findAllByParam(firstbtparamap);
			// 二级菜单查询参数
			Map<String, Object> secondparam = new HashMap<String, Object>();
			secondparam.put("isshow", "1");
			secondparam.put("pid", firstmenuid);
			secondparam.put("ids", !menulistperm.equals("") ? menulistperm.split(",") : "");
			List<Map<String, Object>> secondlist = menuService.findAllByParam(secondparam);// 二级菜单list
			List<Map<String, Object>> secondreslutlist = new ArrayList<Map<String, Object>>();
			for (Map<String, Object> secondMap : secondlist) {// 遍历二级菜单
				// 二级菜单按钮查询参数
				String secondmenuid = secondMap.get("id").toString();
				Map<String, Object> secondbtnparamap = new HashMap<String, Object>();
				secondbtnparamap.put("menuid", secondmenuid);
				secondbtnparamap.put("isuse", "1");
				secondbtnparamap.put("ids", !Buttonperm.equals("") ? Buttonperm.split(",") : "");
				// 二级菜单按钮查询
				List<Map<String, Object>> secondbtnlist = buttonService.findAllByParam(secondbtnparamap);
				// 三级菜单查询参数
				Map<String, Object> threeparam = new HashMap<String, Object>();
				threeparam.put("isshow", "1");
				threeparam.put("pid", secondmenuid);
				threeparam.put("ids", !menulistperm.equals("") ? menulistperm.split(",") : "");
				List<Map<String, Object>> threelist = menuService.findAllByParam(threeparam);// 三级菜单list
				List<Map<String, Object>> threereslutlist = new ArrayList<Map<String, Object>>();
				for (Map<String, Object> threeMap : threelist) {
					// 三级菜单按钮查询参数
					String threemenuid = threeMap.get("id").toString();
					Map<String, Object> threebtnparamap = new HashMap<String, Object>();
					threebtnparamap.put("menuid", threemenuid);
					threebtnparamap.put("isuse", "1");
					threebtnparamap.put("ids", !Buttonperm.equals("") ? Buttonperm.split(",") : "");
					// 三级菜单按钮查询
					List<Map<String, Object>> threebtnlist = buttonService.findAllByParam(threebtnparamap);
					Map<String, Object> threeresultmap = new HashMap<String, Object>();
					// 三级菜单及按钮
					threeresultmap.put("menu", threeMap);
					threeresultmap.put("btn", threebtnlist);
					threereslutlist.add(threeresultmap);
				}
				// 二级菜单及按钮+三级菜单list
				Map<String, Object> secondresultmap = new HashMap<String, Object>();
				secondresultmap.put("menu", secondMap);
				secondresultmap.put("btn", secondbtnlist);
				secondresultmap.put("menulist", threereslutlist);
				secondreslutlist.add(secondresultmap);
			}
			// 一级菜单及按钮+二级菜单list(二级菜单及按钮+三级菜单list(//三级菜单及按钮))
			Map<String, Object> firstresultmap = new HashMap<String, Object>();
			firstresultmap.put("menu", firstMap);
			firstresultmap.put("btn", firstbtnlist);
			firstresultmap.put("menulist", secondreslutlist);
			resultlist.add(firstresultmap);
		}
		modal.addAttribute("permlist", permlist);
		modal.addAttribute("menulist", resultlist);
		modal.addAttribute("valmap", paramap);
		modal.addAttribute("rolemap", rolemap);
		return new ModelAndView("modules/system/permission/setpermission");
	}

	/**
	 * 菜单权限保存
	 * 
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value = "/savesetpermission")
	public @ResponseBody void savesetpermission(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		permService.savesetpermission(paramap);
	}

	/**
	 * 数据权限保存
	 * 
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value = "/datasave")
	public @ResponseBody void datasave(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		String roleid = paramap.get("roleid").toString();
		Map<String, Object> rolemap = roleService.findById(roleid);
		rolemap.put("data", paramap.get("data").toString());
		roleService.update(rolemap);
	}

	/**
	 * 用户权限保存
	 * 
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value = "/usersave")
	public @ResponseBody void usersave(HttpServletRequest request, Model modal) {
		// 获取参数
		Map<String, Object> paramap = this.getParameter();
		String userids = paramap.get("userids").toString();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if (!userids.equals("")) {
			userids = userids.substring(0, userids.length() - 1);
			String useridstr[] = userids.split(",");
			for (String id : useridstr) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("id", util.getUuid());
				map.put("userid", id);
				map.put("roleid", paramap.get("roleid").toString());
				list.add(map);
			}
		}
		paramap.put("list", list);
		permService.usersave(paramap);
	}
}