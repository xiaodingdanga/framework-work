<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<!-- left start -->
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
   	<!-- sidebar: style can be found in sidebar.less -->
   	<section class="sidebar">
   		<!-- Sidebar user panel
   		<div class="user-panel">
     		<div class="pull-left image">
       			<img src="<%=ctx %>/static/img/user2-160x160.jpg" class="img-circle" alt="User Image">
     		</div>
     		<div class="pull-left info">
       			<p>李闯</p><a href="#"><i class="fa fa-circle text-success"></i>在线</a>
     		</div>
   		</div> -->
   		<!-- search form
   		<form action="#" method="get" class="sidebar-form">
     		<div class="input-group">
       			<input type="text" name="q" class="form-control" placeholder="Search...">
           		<span class="input-group-btn">
             		<button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
           		</span>
     		</div>
   		</form> -->
   		<!-- sidebar menu: : style can be found in sidebar.less -->
   		<ul class="sidebar-menu">
       		<li class="header">导航栏</li>
       		<!-- 菜单开始 -->
      		<!-- 一级菜单 -->
      		<c:forEach var="menu" varStatus="status" items="${menulist}">
      			<li id="${menu.id}li" class="treeview">
   					<a href="<%=ctx%><c:if test="${menu.url!=''}">${menu.url}?menuid=${menu.id}</c:if>" onclick="getmenudata('${menu.id}');">
	               		<i class="fa fa-th-large"></i><span>${menu.name}</span>
						<c:if test="${menu.childnum>0}">
							<i class="fa fa-angle-left pull-right"></i>
						</c:if>
					</a>
					<c:if test="${menu.childnum>0}">
						<ul id="${menu.id}" class="treeview-menu">
							<!-- 二级菜单 -->
						</ul>
					</c:if>
          		</li>
  			</c:forEach>
           	<!-- 菜单结束 -->
   		</ul>
   	</section>
</aside>
<script>
//最后初始化：start
var menuid="${menuid}";
var menucode="${menucode}";
//父级菜单展开
if(menucode!=""){
	var code=menucode.split(",");
	for(var i=0;i<code.length;i++){
		$("#"+code[i]+"li").addClass("active");
		getmenudata(code[i]);
	}
}
//当前菜单
if(menuid!=""){
	$("#"+menuid+"li").addClass("active");
	getmenudata(menuid);
}
//最后初始化：end
//获取菜单数据
function getmenudata(parentid){
	//菜单展开
	var length=$("#"+parentid+" li").length;
	if(length==0){
		$.ajax({
			type:'post',
			url:'<%=ctx %>/login/getmenu?menuid='+parentid,
			data:"",
			dataType:'json',
			async:false,
			success:function(data){
				datatohtml(data,parentid);
			}
		});
	}
}
//拼写菜单html
function datatohtml(data,id){
	var html="";
	for(var i=0;i<data.length;i++){
		html+="<li id=\""+data[i].id+"li\">";
		var url="";
		if(data[i].url!=""){
			url=data[i].url+"?menuid="+data[i].id;
		}
		html+="<a href=\"<%=ctx%>"+url+"\" onclick=\"getmenudata(\'"+data[i].id+"\');\">";
		html+=data[i].name;
		if(data[i].childnum>0){
			html+="<i class=\"fa fa-angle-left pull-right\"></i>";
		}
		html+="</a>";
		if(data[i].childnum>0){
			html+="<ul id=\""+data[i].id+"\" class=\"treeview-menu\"></ul>";
		}
		html+="</li>";
	}
	$("#"+id).html(html);
}
</script>
<!-- left end -->