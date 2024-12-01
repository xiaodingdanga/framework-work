package com.lx.framework.system.controller;

import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.MessageService;
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
@RequestMapping(value="/homepage")
public class HomePageController extends BaseController {
	Logger log = LogManager.getLogger(HomePageController.class.getName());
	@Resource
	private MessageService messageservice;
	/**
	 * 首页页面数据加载
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request,Model modal){
		Map<String,Object> paramap=this.getParameter();
		paramap.put("start", 0);
		paramap.put("pageSize", 5);
		//系统消息
		List<Map<String,Object>> syslist=messageservice.findAllByParam(paramap);
		modal.addAttribute("syslist", syslist);
		return new ModelAndView("modules/homepage/main");
	}
	/**
	 * 查看系统消息
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/messagelook")
	public ModelAndView messagelook(HttpServletRequest request,Model modal){
		Map<String,Object> paramap=this.getParameter();
		String id = paramap.get("id").toString();
		Map<String,Object> message = messageservice.findById(id);
		modal.addAttribute("valmap",message);
		return new ModelAndView("modules/homepage/messagelook");
	}
	
	/**
	 * 系统消息自己能查看的
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/sysinfo")
	public ModelAndView sysinfo(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/homepage/sysinfo");
	}
	/**
	 * 获取系统消息
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataMessage",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataMessage(HttpServletRequest request,Model modal){
		Map<String,Object> paramap=this.getParameter();
		String data=messageservice.findHomePageByParam(paramap);
		return data;
	}
}
