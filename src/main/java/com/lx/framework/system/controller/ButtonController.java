package com.lx.framework.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.ButtonService;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/button")
public class ButtonController extends BaseController {
	Logger log = LogManager.getLogger(ButtonController.class.getName());
	@Resource
	private ButtonService buttonService;
	@Resource
	private MenuService menuService;
	/**
	 * 获取按钮
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataList",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataList(HttpServletRequest request,Model modal){
		JSONArray data=new JSONArray();
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		List<Map<String,Object>> list=buttonService.findAllByParam(paramap);
		for(Map<String,Object> map:list){
			JSONObject obj=new JSONObject();
			obj.put("id",map.get("id").toString());
			obj.put("name",map.get("name").toString());
			obj.put("menuname",map.get("menuname")!=null?map.get("menuname").toString():"");
			obj.put("isuse",map.get("isuse").toString());
			data.add(obj);
		}
		return data.toJSONString();
	}
	/**
	 * 按钮添加页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toadd")
	public ModelAndView toadd(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String menuid=paramap.get("menuid").toString();
		if(!menuid.equals("")&&!menuid.equals("0")){
			Map<String,Object> map=menuService.findById(menuid);
			String menuname=map.get("name").toString();
			paramap.put("menuname",menuname);
		}
		modal.addAttribute("valmap", paramap);
		return new ModelAndView("modules/system/button/edit");
	}
	/**
	 * 按钮修改页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toedit")
	public ModelAndView toedit(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		paramap=buttonService.findById(id);
		String menuid=paramap.get("menuid").toString();
		Map<String,Object> map=menuService.findById(menuid);
		String menuname=map.get("name").toString();
		paramap.put("menuname",menuname);
		modal.addAttribute("valmap",paramap);
		return new ModelAndView("modules/system/button/edit");
	}
	/**
	 * 验证相同菜单下名称是否重复
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/checkname")
	public @ResponseBody String checkname(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		boolean ret=!buttonService.checkName(paramap);
		if(ret) {
			return "true";
		}else {
			return "false";
		}
	}
	/**
	 * 按钮保存--更新
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/save")
	public @ResponseBody void save(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		if(id.equals("")){//保存
			buttonService.save(paramap);
		}else{//更新
			buttonService.update(paramap);
		}
	}
	/**
	 * 按钮删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody void delete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		buttonService.delete(id);
	}
}
