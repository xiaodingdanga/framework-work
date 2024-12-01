package com.lx.framework.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lx.framework.base.BaseController;
import com.lx.framework.system.service.UserService;
import com.lx.framework.utils.MD5Util;
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
@RequestMapping(value="/user")
public class UserController extends BaseController {
	Logger log = LogManager.getLogger(UserController.class.getName());
	@Resource
	private UserService userService;

	/**
	 * 用户管理首页
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(HttpServletRequest request,Model modal){
		String company=(String)request.getSession().getAttribute("company");
		JSONArray node=new JSONArray();
		JSONObject obj=new JSONObject();
		obj.put("id","0");
		obj.put("pid","");
		obj.put("name",company);
		obj.put("isParent",true);
		node.add(obj);
		modal.addAttribute("node", node);
		return new ModelAndView("modules/system/user/main");
	}
	/**
	 * 根据条件获取用户--不包含当前用户
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataList",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataList(HttpServletRequest request,Model modal){
		//获取所有机构
		Map<String,Object> user=(Map<String,Object>)request.getSession().getAttribute("user");
		String userid=user.get("id").toString();
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		paramap.put("userid", userid);
		String data=userService.findPageByParam(paramap);
		return data;
	}
	/**
	 * 根据条件获取用户--包含当前用户
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getDataLists",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getDataLists(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String data=userService.findPageByParam(paramap);
		return data;
	}
	/**
	 * 验证账号是否重复
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/checkname")
	public @ResponseBody String checkname(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		boolean ret=!userService.checkName(paramap);
		if(ret) {
			return "true";
		}else {
			return "false";
		}
	}
	/**
	 * 用户保存--更新
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/save")
	public @ResponseBody void save(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		if(id.equals("")){//保存
			userService.save(paramap);
		}else{//更新
			userService.update(paramap);
		}
	}
	/**
	 * 重置密码
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/respassword",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String respassword(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String newpassword=(int)((Math.random()*9+1)*100000)+"";
		String password= MD5Util.getMD5(newpassword);
		paramap.put("password",password);
		//重置密码
		userService.resetPassword(paramap);
		return newpassword;
	}

	/**
	 * 用户-批量删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/batchdelete")
	public @ResponseBody void batchdelete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String idstr=paramap.get("ids").toString();
		String ids[]=idstr.split(",");
		userService.batchDelete(ids);
	}
	/**
	 * 用户-删除
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody void delete(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String id=paramap.get("id").toString();
		userService.delete(id);
	}
	/**
	 * 选择用户
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/getuser")
	public ModelAndView getuser(HttpServletRequest request,Model modal){
		Map<String,Object> paramap=this.getParameter();
		modal.addAttribute("paramap",paramap);
		return new ModelAndView("modules/system/user/getuser");
	}
	/**
	 * 用户-自动补充
	 * @param request
	 * @param modal
	 */
	@RequestMapping(value="/getUser",produces={"text/json;charset=UTF-8"})
	public @ResponseBody String getUser(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		List<Map<String,Object>> list=userService.findAllByParam(paramap);
		JSONArray arr=new JSONArray();
		for(Map<String,Object> model:list){
			JSONObject obj=new JSONObject();
			obj.put("id",model.get("id").toString());
			obj.put("label",model.get("name").toString()+"--"+model.get("account").toString());
			obj.put("value",model.get("name").toString());
			arr.add(obj);
		}
		return arr.toJSONString();
	}
//	/**
//	 * 用户信息导出
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/exports")
//	public @ResponseBody void exports(HttpServletRequest request,HttpServletResponse response,Model modal) throws Exception{
//		Map<String,Object> user=(Map<String,Object>)request.getSession().getAttribute("user");
//		//获取参数
//		Map<String,Object> paramap=this.getParameter();
//		paramap.put("userid", user.get("id").toString());
//		List<Map<String,Object>> userlist=userService.findAllByParam(paramap);
//
//		//title--标题
//		String title[]={"账号","姓名","所属部门","电话","EMAIL"};
//		List<Object[]> list=new ArrayList<Object[]>();
//		for(Map<String,Object> users:userlist){
//			String account=users.get("account")!=null?users.get("account").toString():"";//账号
//			String name=users.get("name")!=null?users.get("name").toString():"";//姓名
//			String userid=users.get("id")!=null?users.get("id").toString():"";//用户ID
//			String tel=users.get("tel")!=null?users.get("tel").toString():"";//电话
//			String email=users.get("email")!=null?users.get("email").toString():"";//EMAIL
//
//			//data赋值
//			String userobj[]={account,name,"",tel,email};
//			list.add(userobj);
//		}
//		ExportExcel exportexcel = new ExportExcel();
//		// 创建工作簿实例
//		HSSFWorkbook workbook = new HSSFWorkbook();
//		String fileName = "用户信息";
//		workbook = exportexcel.exportExcel(workbook,title,list,fileName);//设置列名，及数据LIST，SHEET名称
//		// 处理中文文件名
//        response.setContentType("application/vnd.ms-excel");
//        response.setHeader("Content-disposition", "attachment;filename=" + new String((fileName+".xls").getBytes(), "iso-8859-1"));
//        OutputStream outputStream = response.getOutputStream();
//        workbook.write(outputStream);
//        outputStream.flush();
//        outputStream.close();
//	}
	/**
	 * 用户信息导入
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/imports")
	public ModelAndView imports(HttpServletRequest request,Model modal){
		return new ModelAndView("modules/system/user/imports");
	}
//	/**
//	 * 用户信息导入模板
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/template")
//	public @ResponseBody void template(HttpServletRequest request,HttpServletResponse response,Model modal) throws Exception{
//		//title--标题
//		String title[]={"账号","姓名","所属部门","电话","EMAIL"};
//		ExportExcel exportexcel = new ExportExcel();
//		// 创建工作簿实例
//		HSSFWorkbook workbook = new HSSFWorkbook();
//		String fileName = "用户信息导入模板";
//		workbook = exportexcel.exportExcel(workbook,title,null,fileName);//设置列名，及数据LIST，SHEET名称
//		// 处理中文文件名
//        response.setContentType("application/vnd.ms-excel");
//        response.setHeader("Content-disposition", "attachment;filename=" + new String((fileName+".xls").getBytes(), "iso-8859-1"));
//        OutputStream outputStream = response.getOutputStream();
//        workbook.write(outputStream);
//        outputStream.flush();
//        outputStream.close();
//	}
	/**
	 * 获取所有用户
	 * @return
	 */
	public Map<String,Object> getUsers(){
		return userService.getUsers();
	}
//	//导入用户
//	@RequestMapping(value = "/doimports")
//	public ModelAndView doimports(HttpServletRequest request,Model modal) throws IllegalStateException, IOException{
//		Map<String,Object> usermap=this.getUsers();//系统内所有用户账号Map<account,id>
//        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
//		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getSession().getServletContext());
//		//检查form中是否有enctype="multipart/form-data"
//		if(multipartResolver.isMultipart(request)){
//			//将request变成多部分request
//			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
//			//获取multiRequest 中所有的文件名
//			Iterator iter=multiRequest.getFileNames();
//			//系统路径
//			String Path=request.getSession().getServletContext().getRealPath("/");
//			//具体临时文件路径
//			String filePath="uploadfile/temp/";
//			while(iter.hasNext()){
//            	//一次遍历所有文件
//				MultipartFile file=multiRequest.getFile(iter.next().toString());
//				if(file!=null){
//					String date=util.datetostring(new Date(),"yyyy-MM-dd_HH_mm_ss");
//					String path=Path+filePath+date+file.getOriginalFilename();
//					//上传
//					File importfile=new File(path);
//					file.transferTo(importfile);
//					//开始导入
//					HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(importfile));
//					//获取第一个sheet
//					HSSFSheet sheet = wb.getSheetAt(0);
//					//获取行数从0开始
//					int rowno=sheet.getLastRowNum();
//					String msg="导入成功！";
//					//导入数据集合
//					List<String[]> datalist=new ArrayList<String[]>();
//					//错误数据集合
//					List<String[]> errorlist=new ArrayList<String[]>();
//					if(rowno>=1){//有数据
//						try{
//							for(int j=1;j<=rowno;j++){//循环行起始为0，从第1行开始
//								HSSFRow row = sheet.getRow(j);//获取一行数据
//								String account=(row.getCell(0)!=null&&!row.getCell(0).equals(""))?ExportExcel.getCellValue(row.getCell(0)).trim():"";//账号
//								String name=(row.getCell(1)!=null&&!row.getCell(1).equals(""))?ExportExcel.getCellValue(row.getCell(1)).trim():"";//姓名
//								String dep=(row.getCell(2)!=null&&!row.getCell(2).equals(""))?ExportExcel.getCellValue(row.getCell(2)).trim():"";//所属部门
//								String tel=(row.getCell(3)!=null&&!row.getCell(3).equals(""))?ExportExcel.getCellValue(row.getCell(3)).trim():"";//电话
//								String email=(row.getCell(4)!=null&&!row.getCell(4).equals(""))?ExportExcel.getCellValue(row.getCell(4)).trim():"";//EMAIL
//
//								String error="";//单行错误信息
//								//账号验证
//								if(account.equals("")){//账号为空
//									error+="账号不能为空！";
//								}else{//账号不为空
//									if(usermap.containsKey(account)){//账号重复
//										error+="账号重复！";
//									}
//								}
//								//姓名验证
//								if(name.equals("")){//姓名为空
//									error+="姓名不能为空！";
//								}
//								//所属部门验证
//								String depid="";
//								String obj[]=new String[6];
//								if(error.equals("")){//验证通过
//									obj[0]=account;//账号
//									obj[1]=name;//姓名
//									obj[2]=depid;//所属部门
//									obj[3]=tel;//电话
//									obj[4]=email;//EMAIL
//									datalist.add(obj);
//								}else{//验证不通过
//									obj[0]=account;//账号
//									obj[1]=name;//姓名
//									obj[2]=dep;//所属部门
//									obj[3]=tel;//电话
//									obj[4]=email;//EMAIL
//									obj[5]=error;//错误信息
//									errorlist.add(obj);
//								}
//							}
//							if(datalist.size()>0){
//								//导入数据--入库
//								userService.importdata(datalist);
//							}
//						}catch(Exception e){
//							e.printStackTrace();
//						}
//					}else{//无数据
//						msg="请填写用户信息！";
//					}
//					modal.addAttribute("msg",msg);
//					request.getSession().setAttribute("errorlist",errorlist);
//				}
//			}
//		}
//	    return new ModelAndView("modules/system/user/errorimports");
//	}
//	/**
//	 * 用户导入错误信息导出
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/errordownload")
//	public @ResponseBody void errordownload(HttpServletRequest request,HttpServletResponse response,Model modal) throws Exception{
//		List<Object[]> datalist=(List<Object[]>)request.getSession().getAttribute("errorlist");
//		String title[]={"账号","姓名","所属部门","电话","EMAIL","错误信息"};
//		ExportExcel exportexcel = new ExportExcel();
//		// 创建工作簿实例
//		HSSFWorkbook workbook = new HSSFWorkbook();
//		String fileName = "用户导入错误信息";
//		workbook = exportexcel.exportExcel(workbook,title,datalist,fileName);//设置列名，及数据LIST，SHEET名称
//		// 处理中文文件名
//        response.setContentType("application/vnd.ms-excel");
//        response.setHeader("Content-disposition", "attachment;filename=" + new String((fileName+".xls").getBytes(), "iso-8859-1"));
//        OutputStream outputStream = response.getOutputStream();
//        workbook.write(outputStream);
//        outputStream.flush();
//        outputStream.close();
//	}
	/**
	 * 用户添加页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toadd")
	public ModelAndView toadd(HttpServletRequest request,Model modal){
		Map<String,Object> user=(Map<String,Object>)request.getSession().getAttribute("user");
		String customerid=user.get("customerid").toString();
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		paramap.put("customerid", customerid);
		List<Map<String,Object>> userlist=userService.findAllByParam(paramap);
		modal.addAttribute("userlist", userlist);
		return new ModelAndView("modules/system/user/add");
	}
	/**
	 * 用户修改页面
	 * @param request
	 * @param modal
	 * @return
	 */
	@RequestMapping(value="/toedit")
	public ModelAndView toedit(HttpServletRequest request,Model modal){
		//获取参数
		Map<String,Object> paramap=this.getParameter();
		String userid=paramap.get("id").toString();
		Map<String,Object> usermap=userService.findById(userid);
		modal.addAttribute("valmap",usermap);
		return new ModelAndView("modules/system/user/edit");
	}
}
