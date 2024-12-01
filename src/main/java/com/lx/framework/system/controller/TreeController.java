 package com.lx.framework.system.controller;

 import com.alibaba.fastjson.JSONArray;
 import com.alibaba.fastjson.JSONObject;
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
 import java.util.List;
 import java.util.Map;

@Controller
@RequestMapping(value="/tree")
public class TreeController extends BaseController {
	Logger log = LogManager.getLogger(TreeController.class.getName());
	@Resource
	private MenuService menuService;

	/**
	 * 菜单树--点击触发事件
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/menutree")
	public ModelAndView menutree(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/tree/menutree");
	}
	/**
	 * 获取菜单
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/menudata",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String menudata(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String pid=paramap.get("pid").toString();
		List<Map<String,Object>> list=menuService.findByPid(pid);
		JSONArray data=new JSONArray();
		for(Map<String,Object> map:list){
			JSONObject obj=new JSONObject();
			obj.put("id",map.get("id").toString());
			obj.put("pid",map.get("pid").toString());
			obj.put("name",map.get("name").toString());
			int childnum=Integer.parseInt(map.get("childnum")!=null?map.get("childnum").toString():"0");
			if(childnum==0){
				obj.put("isParent",false);
			}else{
				obj.put("isParent",true);
			}
			data.add(obj);
		}
		return data.toJSONString();
	}
	/**
	 * 菜单树--点击触发事件
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/goodtypetree")
	public ModelAndView goodtypetree(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/tree/goodstypetree");
	}
	/**
	 * 区域树--点击触发事件
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/citytree")
	public ModelAndView citytree(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/tree/citytree");
	}
}