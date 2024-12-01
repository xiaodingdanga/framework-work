<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row" style="padding:15px 0px 0px 0px;">
	<div class="col-md-12">
 		<!-- 系统消息 -->
<!-- 		<div class="col-xs-6"> -->
<!-- 			<div class="box box-primary"> -->
<!--             	<div class="box-header"> -->
<!--               		<h3 class="box-title">系统消息</h3> -->
<!--             	</div> -->
<!--        			<div class="box-body" style="height:130px"> -->
<!--             		<ul class="todo-list"> -->
<%--             			<c:forEach items="${syslist}" var="map"> --%>
<%--             				<li style="padding:2px;background:#ffffff;cursor:pointer" onclick="syslook('${map.id}');"> --%>
<!-- 								<a> -->
<%-- 									<c:choose>   --%>
<%-- 									    <c:when test="${fn:length(map.title)>10}">   --%>
<%-- 									        <c:out value="${fn:substring(map.title, 0, 10)}......" />   --%>
<%-- 									    </c:when>   --%>
<%-- 									   <c:otherwise>   --%>
<%-- 									      ${map.title} --%>
<%-- 									   </c:otherwise>   --%>
<%-- 									</c:choose>  --%>
<!-- 								</a> -->
<!-- 							</li> -->
<%-- 						</c:forEach> --%>
<!--             		</ul> -->
<!--                	</div> -->
<!--             	<div class="box-footer clearfix no-border"> -->
<!--             		<a href="#0" class="pull-right" onclick="sysjump();">更多</a> -->
<!--           		</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<!-- 新闻公告 -->
<!-- 		<div class="col-xs-6" > -->
<!-- 			<div class="box box-primary"> -->
<!--             	<div class="box-header"> -->
<!--               		<h3 class="box-title">新闻公告</h3> -->
<!--             	</div> -->
<!--        			<div class="box-body" style="height:130px" > -->
<!--             		<ul class="todo-list"> -->
<%--             			<c:forEach items="${newlist}" var="map"> --%>
<%--             				<li style="padding:2px;background:#ffffff;cursor:pointer" onclick="newlook('${map.id}');"> --%>
<!-- 								<a> -->
<%-- 									<c:choose>   --%>
<%-- 									    <c:when test="${fn:length(map.title)>10}">   --%>
<%-- 									        <c:out value="${fn:substring(map.title, 0, 10)}......" />   --%>
<%-- 									    </c:when>   --%>
<%-- 									   <c:otherwise>   --%>
<%-- 									      ${map.title} --%>
<%-- 									   </c:otherwise>   --%>
<%-- 									</c:choose>  --%>
<!-- 								</a> -->
<!-- 							</li> -->
<%-- 						</c:forEach> --%>
<!--             		</ul> -->
<!--                	</div> -->
<!--                	<div class="box-footer clearfix no-border"> -->
<!--                		<a href="#0" class="pull-right" onclick="newjump();">更多</a> -->
<!--        			</div> -->
<!--  			</div> -->
<!-- 		</div> -->
	</div>
</div>
<script>
//更多系统消息
function sysjump(){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="系统消息";
	dialog.URL="<%=ctx%>/homepage/sysinfo";
	dialog.show();
}
//查看系统消息
function syslook(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="查看系统信息";
	dialog.URL="<%=ctx%>/homepage/messagelook?id="+id;
	dialog.show();
}
//更多新闻公告
function newjump(){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="查看更多新闻";
	dialog.URL="<%=ctx%>/homepage/newinfo";
	dialog.show();
}
//查看新闻公告
function newlook(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="查看新闻公告";
	dialog.URL="<%=ctx%>/homepage/newlook?id="+id;
	dialog.show();
}
</script>