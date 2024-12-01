package com.lx.framework.system.controller;

import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.MenuService;
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
@RequestMapping(value="/menu")
public class MenuController extends BaseController {
	Logger log = LogManager.getLogger(MenuController.class.getName());
	@Resource
	private MenuService menuService;
	/**
	 * 菜单管理首页
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/system/menu/main");
	}
	/**
	 * 菜单添加页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toadd")
	public ModelAndView toadd(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		//父级ID
		String pid=paramap.get("pid").toString();
		if(!pid.equals("")&&!pid.equals("0")){
			Map<String,Object> pmenumap=menuService.findById(pid);
			paramap.put("pname",pmenumap.get("name").toString());
		}
		modal.addAttribute("valmap",paramap);
		return new ModelAndView("modules/system/menu/edit");
	}
	/**
	 * 菜单修改页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toedit")
	public ModelAndView toedit(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		Map<String,Object> valmap=menuService.findById(id);
		//父级ID
		String pid=valmap.get("pid").toString();
		if(!pid.equals("0")){
			Map<String,Object> pdepmap=menuService.findById(pid);
			valmap.put("pname",pdepmap.get("name").toString());
		}
		modal.addAttribute("valmap",valmap);
		return new ModelAndView("modules/system/menu/edit");
	}
	/**
	 * 验证菜单名称是否重复
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/checkname")
	public @ResponseBody String checkname(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		boolean ret=!menuService.checkName(paramap);
		if(ret) {
			return "true";
		}else {
			return "false";
		}
	}
	/**
	 * 菜单保存--更新
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/save")
	public @ResponseBody void save(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		if(id.equals("")){//保存
			menuService.save(paramap);
		}else{//更新
			menuService.update(paramap);
		}
	}
	/**
	 * 菜单删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody void delete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		menuService.delete(id);
	}
}
