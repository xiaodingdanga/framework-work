package com.lx.framework.interceptor;

import com.lx.framework.system.service.MenuService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;


public class AccessInterceptor implements HandlerInterceptor {
	Logger log = LogManager.getLogger(AccessInterceptor.class.getName());
	@Resource
	private MenuService menuService;
	
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler)throws Exception{
		log.info(request.getRequestURI());
		Object user=request.getSession().getAttribute("user"); 
        if(user==null){//session超时  
            throw new SessionTimeoutException();  
        }else{//未超时  
            return true;  
        }  
	}

	public void postHandle(HttpServletRequest request,HttpServletResponse response,Object handler,ModelAndView modelAndView)throws Exception{
//		log.info("AccessInterceptor="+request.getParameter("menuid"));
		String menuid=request.getParameter("menuid");
		if(menuid!=null&&!menuid.equals("")){
			String oldmenuid=(String)request.getSession().getAttribute("menuid");
			if(!menuid.equals(oldmenuid)){
				request.getSession().setAttribute("menuid",menuid);//保存菜单ID
				Map<String,Object> menu=menuService.findById(menuid);//获取当前菜单实体
				String menucode=menu.get("code").toString();
				request.getSession().setAttribute("menucode",menucode);//保存菜单CODE
				String title="";
				if(!menucode.equals("")){
					String code[]=menucode.split(",");
					for(int i=0;i<code.length;i++){
						Map<String,Object> parentmenu=menuService.findById(code[i]);
						if(i==code.length-1){//最后一个
							title+="<li class=\"active\">"+parentmenu.get("name").toString()+"</li>";
						}else{
							title+="<li><a href=\'#\'>"+parentmenu.get("name").toString()+"</a></li>";
						}
					}
				}
				request.getSession().setAttribute("title",title);//保存导航
			}
		}else{
			request.getSession().setAttribute("menuid","");//清空
		}
	}

	public void afterCompletion(HttpServletRequest request,HttpServletResponse response,Object handler,Exception e)throws Exception{
	}
}
