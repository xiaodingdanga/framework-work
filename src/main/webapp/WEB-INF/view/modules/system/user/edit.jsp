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
	       	</div>
       	</form>
    </div>
</div>
<script>
//验证
var validate;
//页面初始化
$(window).load(function(){
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
            }
        },
        messages:{
        	account:{
                required:"请填写账号！",
                remote:"账号重复，请重新填写！"
            },
            name:{
            	required:"请填写姓名！"
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
		var depid=$("#depid").val();
		var tel=$("#tel").val();
		var email=$("#email").val();
		$.ajax({
			type:'post',
			url:'<%=ctx %>/user/save',
			data:{'id':id,'account':account,'name':name,'depid':depid,'tel':tel,'email':email},
			dataType:'text',
			async:false,
			success:function(data){
				ret="ok";
			}
		});
	}
	return ret;
}
</script>