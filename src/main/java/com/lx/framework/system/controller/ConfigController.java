package com.lx.framework.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.ConfigService;
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
@RequestMapping(value="/config")
public class ConfigController extends BaseController {
	Logger log = LogManager.getLogger(ConfigController.class.getName());
	@Resource
	private ConfigService configService;
	/**
	 * 系统配置首页
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request, Model modal){
		return new ModelAndView("modules/system/config/main");
	}
	/**
	 * 获取系统配置
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataList",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataList(HttpServletRequest request,Model modal){
		List<Map<String,Object>> list=configService.findAll();
		JSONArray data=new JSONArray();
		for(Map<String,Object> map:list){
			JSONObject obj=new JSONObject();
			obj.put("id",map.get("id").toString());
			obj.put("name",map.get("name").toString());
			obj.put("code",map.get("code").toString());
			obj.put("value",map.get("value").toString());
			data.add(obj);
		}
		return data.toJSONString();
	}
	/**
	 * 系统配置修改页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toedit")
	public ModelAndView toedit(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		paramap=configService.findById(id);
		modal.addAttribute("valmap",paramap);
		return new ModelAndView("modules/system/config/edit");
	}
	/**
	 * 菜单保存--更新
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/update")
	public @ResponseBody void update(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		configService.update(paramap);
	}
}
