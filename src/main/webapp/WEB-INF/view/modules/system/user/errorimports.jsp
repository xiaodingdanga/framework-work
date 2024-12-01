<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
   		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
          		<div class="box-tools pull-right">
          			<c:if test="${fn:length(errorlist)>0}">
          				<button type="button" class="btn btn-info btn-sm" onclick="errordownload();">错误信息导出</button>
          			</c:if>
					<button type="button" class="btn btn-info btn-sm" onclick="back();">返回</button>
          		</div>
        	</div>
        	<div class="box-body" id="tabbody" style="min-height:400px;">
        		<!-- 数据start -->
        		<c:if test="${fn:length(errorlist)>0}">
               	<table border="1" width="100%">
	               	<tr align="center" style="font-size:14px;font-weight:bold;">
	               		<td>序号</td>
	               		<td>账号</td>
	               		<td>姓名</td>
	               		<td>所属部门</td>
	               		<td>电话</td>
	               		<td>EMAIL</td>
	               		<td>错误信息</td>
	               	</tr>
					<c:forEach items="${errorlist}" var="obj" varStatus="index">
					<tr align="center">
						<td>${index.index+1}</td>
						<td>${obj[0]}</td>
						<td>${obj[1]}</td>
						<td>${obj[2]}</td>
						<td>${obj[3]}</td>
						<td>${obj[4]}</td>
						<td>${obj[5]}</td>
					</tr>
					</c:forEach>
				</table>
				</c:if>
				<c:if test="${fn:length(errorlist)==0}">
					<center>
						<div style="color:red;font-size:20px;font-wight:bold;">
							<!-- 无用户数据或导入成功--显示信息 -->
							<c:if test="${msg!=null}">${msg}</c:if>
						</div>
					</center>
				</c:if>
                <!-- 数据end -->
        	</div>
      	</div>
    </div>
</div>
<script>
//错误信息导出
function errordownload(){
	window.location.href="<%=ctx %>/user/errordownload.action";
}
//返回
function back(){
	window.location.href="<%=ctx%>/user/imports";
}
</script>