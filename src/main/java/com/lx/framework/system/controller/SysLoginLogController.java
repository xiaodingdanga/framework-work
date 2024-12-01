package com.lx.framework.system.controller;

import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.SysLoginLogService;
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
@RequestMapping(value="/log")
public class SysLoginLogController extends BaseController {
	Logger log = LogManager.getLogger(SysLoginLogController.class.getName());
	
	@Resource
	private SysLoginLogService sysLoginLogService;
	/**
	 * 首页
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/system/log/main");
	}
	
	/**
	 * 根据条件获取日志
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataList",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataList(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String data=sysLoginLogService.findPageByParam(paramap);
		return data;
	}
}
