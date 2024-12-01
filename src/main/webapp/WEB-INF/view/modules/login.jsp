<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp"%>
<%
	String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${proname}</title>
<jsp:include page="/WEB-INF/view/include/head.jsp" />
<script>
//cookie保存
function init(){
	var account=localStorage.account;
	var password=localStorage.password;
	$("#account").val(account);
	$("#password").val(password);
	//判断是否为顶层
	var topurl=top.location;
	var selfurl=self.location;
	if(topurl!=selfurl){//地址不相同父级页面刷新
		parent.location.href="<%=ctx%>/login/logout";
	}
}
//登陆验证
function tologin(){
	var account=$("#account").val();
	var password=$("#password").val();
	if(account==""&&password==""){
		Dialog.alert("请填写账号和密码！");
	}else if(account==""){
		Dialog.alert("请填写账号！");
	}else if(password==""){
		Dialog.alert("请填写密码！");
	}else{//验证
		$.ajax({
			type:'post',
			url:'<%=ctx%>/login/validate',
			data:{'account':account,'password':password},
			dataType:'text',
			async:false,
			success:function(data){
				if(data=="3"){
					Dialog.alert("该用户已经停用！");
				}else if(data=="4"){
					Dialog.alert("该用户已被删除！");
				}else if(data=="-1"){
					Dialog.confirm("请购买授权许可！",function(){
						var dialog=new Dialog();
						dialog.Width = 1000;
						dialog.Height = 800;
						dialog.Title="授权许可";
						dialog.URL="<%=ctx%>/login/license";
							dialog.show();
						});
					} else if (data == "1") {
						Dialog.alert("无该用户信息！");
					} else if (data == "2") {
						Dialog.alert("密码错误，请重新填写！");
					} else if (data == "0") {//data为0正常登陆
						localStorage.account = account;
						localStorage.password = password;
						$("#form").submit();
					}
				}
			});
		}
	}
	//键盘监听
	function passwordPress(e) {
		var val;
		if (!e) {
			e = window.event;
		}
		if (e.keyCode) {
			val = e.keyCode;
		} else if (e.which) {
			val = e.which;
		}
		if (val == 13) {
			tologin();
		}
	}
</script>
</head>
<body class="hold-transition login-page" onload="init();"
	onKeyPress="passwordPress(event)">
	<div>
		<span></span>
		<p>本系统支持google及IE9以上版本浏览器</p>
	</div>
	<div class="login-box">
		<div class="login-logo">
			<%-- <img src="<%=ctx %>/static/img/logo/logo.png">  --%>
			<br> <a href="#" style="color: rgba(60,141,188,0.8);"> <b id="logo">
					${logo} </b>
			</a>
		</div>
		<div class="login-box-body">
			<p class="login-box-msg" id="proname" style="font-weight: bold;">
				${proname}</p>
			<form action="<%=ctx%>/login/login" id="form" name="form"
				method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" id="account" name="account"
						placeholder="账号" onKeyPress="passwordPress(event)"> <span
						class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" id="password"
						name="password" placeholder="密码" onKeyPress="passwordPress(event)">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
			</form>
			<div class="row">
				<div class="col-xs-12">
					<button type="button" class="btn btn-primary btn-block btn-flat"
						onclick="tologin();" onKeyPress="passwordPress(event)">登录</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>