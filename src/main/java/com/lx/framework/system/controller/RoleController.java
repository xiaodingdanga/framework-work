package com.lx.framework.system.controller;

import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.RoleService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping(value="/role")
public class RoleController extends BaseController {
	Logger log = LogManager.getLogger(RoleController.class.getName());
	@Resource
	private RoleService roleService;
	/**
	 * 角色管理首页
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/system/role/main");
	}
	/**
	 * 获取角色
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataList",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataList(HttpServletRequest request,Model modal){
		Map<String,Object> paramap=this.getParameter();
		String data=roleService.findPageByParam(paramap);
		return data;
	}
	/**
	 * 角色添加页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toadd")
	public ModelAndView toadd(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		modal.addAttribute("valmap",paramap);
		return new ModelAndView("modules/system/role/edit");
	}
	/**
	 * 角色修改页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toedit")
	public ModelAndView toedit(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		paramap=roleService.findById(id);
		modal.addAttribute("valmap",paramap);
		return new ModelAndView("modules/system/role/edit");
	}
	/**
	 * 验证角色名称是否重复
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/checkname")
	public @ResponseBody String checkname(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		boolean ret=!roleService.checkName(paramap);
		if(ret) {
			return "true";
		}else {
			return "false";
		}
	}
	/**
	 *角色保存--更新
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/save")
	public @ResponseBody void save(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		if(id.equals("")){//保存
			roleService.save(paramap);
		}else{//更新
			roleService.update(paramap);
		}
	}
	/**
	 * 角色-批量删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/batchdelete")
	public @ResponseBody void batchdelete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String idstr=paramap.get("ids").toString();
		String ids[]=idstr.split(",");
		roleService.batchDelete(ids);
	}
	/**
	 * 角色-删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody void delete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		roleService.delete(id);
	}
}