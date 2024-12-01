<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<input type="hidden" id="id" name="id" value="${valmap.id}">
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
				<div class="form-group">
					<label class="col-xs-3 control-label"
						style="padding: 5px 0px 0px 50px;"><font color="red">*</font>区域名称:</label>
					<div class="col-xs-9">
						<input type="text" class="form-control" id="name" name="name" placeholder="区域名称" value="${valmap.name}">
					</div>
				</div>
				<div class="form-group has-feedback">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">父级区域:</label>
					<div class="col-xs-9" onclick="getcitytree();">
						<input type="hidden" id="pid" name="pid" value="${valmap.pid}">
						<input type="text" class="form-control" id="pname" name="pname" readonly style="cursor:pointer;" placeholder="父级区域" value="${valmap.pname}">
						<span class="glyphicon glyphicon-search form-control-feedback"></span>
	               	</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>
<script>
//获取部门树
function getcitytree(){
	var dialog=new Dialog();
	dialog.Width = 400;
	dialog.Height = 300;
	dialog.Title="区域树";
	dialog.URL="<%=ctx%>/tree/citytree";
	dialog.CancelEvent=function(pid,pname){
		$("#pid").val(pid);
		$("#pname").val(pname);
		dialog.close();
	};
	dialog.show();
}
//validate验证
var validate;
//页面初始化
$(window).load(function(){
	//验证
	validate=$("#form").validate({
		//debug:true,//调试模式取消submit的默认提交功能   
        //errorClass:"label.error",//默认为错误的样式类为：error
		focusInvalid:true,//当为false时，验证无效时，没有焦点响应
		onkeyup:false, 
		rules:{
    		name:{
            	required:true,
            	remote:{
               	    url:"<%=ctx%>/city/checkname",//后台处理程序
               	 	async:false,				//同步验证设置
               	    type:"post",               //数据发送方式
               	    dataType:"json",           //接受数据格式   
               	    data:{//要传递的数据
               	    	id:function(){
               	    		return $("#id").val();
               	    	},
        				name:function(){
               	        	return $("#name").val();
               	        },
               	        pid:function(){
               	        	var pid=$("#pid").val();
               	        	if(pid==""){
               	        		pid="0";
               	        	}
               	        	return pid;
               	        }
               	    }
               	}
            },
            pname:{
            	idequalspid:true
            }
        },
        
        messages:{
        	name:{
                required:"请填写区域名称！",
                remote:"区域名称重复，请重新填写！"
            },
            pname:{
            	idequalspid:"请选择其他父级区域！"
            }
        },
        errorPlacement:function(error,element){//错误信息显示位置
						element.after(error);
       	}
    });
});
//请选择其他父级部门
jQuery.validator.addMethod(
	"idequalspid",
	function(value,element){
		var sub=true;
		var id=$("#id").val();//菜单ID
		var pid=$("#pid").val();//父级菜单ID
		if(pid==""){
			pid="0";
		}
		if(id==pid){//菜单ID与父级菜单ID
			sub=false;
		}
  		return sub;    
	},
	"请选择其他父级区域！"
);
//部门保存 
function save(){
	
	var ret="" ;
	if(validate){//验证重置
		validate.resetForm();
	}
	if(validate.form()){
		var id=$("#id").val();
		var name=$("#name").val();
		var pid=$("#pid").val();
// 		alert(pid);
		if(pid==""){
			pid="0";
		}
		$.ajax({
			type:'post',
			url:'<%=ctx %>/city/save',
			data:{'id':id,'name':name,'pid':pid},//'code':code,
			dataType:'text',
			async:false,
			success:function(data){
				ret="ok";
			}
		});
	}
	return ret;
}
//返回pid 
function backpid(){
	var pid=$( "#pid").val();
	if(pid==""){
		pid="0" ;
	}
	return pid;
}
</script>