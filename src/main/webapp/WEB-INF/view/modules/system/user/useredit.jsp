<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<input type="hidden" id="id" name="id" value="${valmap.id}">
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;"><font color="red">*</font>账号:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="account" name="account" placeholder="账号" value="${valmap.account}">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;"><font color="red">*</font>姓名:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="name" name="name" placeholder="姓名" value="${valmap.name}">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">电话:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="tel" name="tel" placeholder="电话" value="${valmap.tel}">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">EMAIL:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="email" name="email" placeholder="EMAIL" value="${valmap.email}">
	               	</div>
	            </div>
	           	<hr>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">原始密码:</label>
					<div class="col-xs-9">
	                   	<input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="原始密码" value="">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">新密码:</label>
					<div class="col-xs-9">
	                   	<input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="新密码" value="">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">确认密码:</label>
					<div class="col-xs-9">
	                   	<input type="password" class="form-control" id="newpasswordok" name="newpasswordok" placeholder="确认密码" value="">
	               	</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>
<script>
//验证
var validate;
//页面初始化
$(window).load(function(){
	//密码至少有一个输入，其他就不能为空
	jQuery.validator.addMethod(
		"passwordisnull",
		function(value,element){
			var sub=true;
			var oldpassword=$("#oldpassword").val();//旧密码
			var newpassword=$("#newpassword").val();//新密码
			var newpasswordok=$("#newpasswordok").val();//新密码确认
			//三个密码都为空或三个密码都不为空的否定
			if(element.name=="oldpassword"){//原密码
				if(value==""){
					if(newpassword!=""||newpasswordok!=""){//值等于空
						sub=false;
					}
				}
			}else if(element.name=="newpassword"){//新密码
				if(value==""){
					if(oldpassword!=""||newpasswordok!=""){//值等于空
						sub=false;
					}
				}
			}else if(element.name=="newpasswordok"){//新密码确认
				if(value==""){
					if(newpassword!=""||oldpassword!=""){//值等于空
						sub=false;
					}
				}
			}
			return sub;
		},
		"不能为空！"
	);
	//两次新密码输入不一致！
	jQuery.validator.addMethod(
		"pisequal",
		function(value,element){
			var sub=true;
			var newpassword=$("#newpassword").val();//新密码
			var newpasswordok=$("#newpasswordok").val();//新密码确认
			if(newpassword!=newpasswordok){
				sub=false;
			}
	  		return sub;    
		},
		"两次新密码输入不一致！"
	);
	//validate验证
	validate=$("#form").validate({
		//debug:true,//调试模式取消submit的默认提交功能   
        //errorClass:"label.error",//默认为错误的样式类为：error   
        focusInvalid:true,//当为false时，验证无效时，没有焦点响应  
        onkeyup:false,   
        rules:{
        	account:{
            	required:true,
            	remote:{
               	    url:"<%=ctx%>/user/checkname",//后台处理程序
               	 	async:false,				//同步验证设置
               	    type:"post",               //数据发送方式
               	    dataType:"json",           //接受数据格式   
               	    data:{//要传递的数据
               	    	id:function(){
               	    		return $("#id").val();
               	    	},
               	    	account:function(){
               	        	return $("#account").val();
               	        }
               	    }
               	}
            },
            name:{
            	required:true
            },
            oldpassword:{
                passwordisnull:true,
                remote:{
               	    url:"<%=ctx %>/login/passwordcheck",//后台处理程序
               	 	async:false,				//同步验证设置
               	    type:"post",               //数据发送方式
               	    dataType:"json",           //接受数据格式   
               	    data:{                     //要传递的数据
               	    	password:function(){
	           	    		return $("#oldpassword").val();
	           	    	}
               	    }
               	}
            },
            newpassword:{
            	passwordisnull:true
            },
            newpasswordok:{
            	passwordisnull:true,
            	pisequal:true
            }
        },
        messages:{
        	account:{
                required:"请填写账号！",
                remote:"账号重复，请重新填写！"
            },
            name:{
            	required:"请填写姓名！"
            },
            oldpassword:{
            	passwordisnull:"请填写原密码！",
            	remote:"原密码不正确！"
            },
            newpassword:{
            	passwordisnull:"请填写新密码！"
            },
            newpasswordok:{
            	passwordisnull:"请填写确认密码！",
            	pisequal:"两次新密码输入不一致！"
            }
        },
        errorPlacement:function(error,element){//错误信息显示位置
        	element.after(error);
       	}
    });
});
//部门保存
function save(){
	var ret="";
	if(validate){//验证重置
		validate.resetForm();
	}
	if(validate.form()){
		var id=$("#id").val();
		var account=$("#account").val();
		var name=$("#name").val();
		var tel=$("#tel").val();
		var email=$("#email").val();
		var password=$("#newpassword").val();
		$.ajax({
			type:'post',
			url:'<%=ctx %>/user/save',
			data:{'id':id,'password':password,'account':account,'name':name,'tel':tel,'email':email},
			dataType:'text',
			async:false,
			success:function(data){
				ret="ok";
			}
		});
	}
	return ret;
}
//获取用户名
function getname(){
	return $("#name").val();
}
</script>