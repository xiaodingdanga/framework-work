<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
   		<div class="box box-default">
        	<div class="box-body">
        		<form method="post" id="form" name="form" action="<%=ctx%>/user/doimports" class="form-horizontal" enctype="multipart/form-data">
					<label class="col-sm-2 control-label">导入文件：</label>
					<div class="col-sm-7" >
						<input type="file" id="file" name="file" class="form-control">
					</div>
				</form>
				<div class="ibox-tools">
					<button type="button" class="btn btn-sm btn-primary" onclick="doimportexcel();">导入</button>
					<button type="button" class="btn btn-sm btn-primary" onclick="template();">下载模板</button>
				</div>
				<hr>
        	</div>
        	<div class="box-body">
				<div style="color:red;font-size:20px;font-wight:bold;">
					注意事项：<br>
					1、"账号"、"姓名"必须填写，并且"账号"不能重复！<br>
					2、"密码"如果为空，将默认"密码"为："123456"！<br>
					3、"所属部门"可以为空，如所属多个部门，请用逗号","分隔！<br>
					4、出错信息导出后，经过修改，可以直接进行导入！<br>
				</div>
        	</div>
      	</div>
    </div>
</div>
<script>
//导入
function doimportexcel(){
	var file=$("#file").val();//文件路径
	if(file!=""){//文件不为空
		var suffix=file.substring(file.lastIndexOf(".")+1);//获取后缀
		suffix=suffix.toLowerCase();//后缀小写
		if(suffix=="xls"||suffix=="xlsx"){
			$("#form").submit();//上传
		}else{
			Dialog.alert("请选择EXCEL文件上传！");
		}
	}else{
		Dialog.alert("请选择导入文件！");
	}
}
//下载模板
function template(){
	window.location.href="<%=ctx %>/user/template.action";
}
</script>