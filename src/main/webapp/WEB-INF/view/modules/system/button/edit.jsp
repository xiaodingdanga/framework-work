<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<input type="hidden" id="id" name="id" value="${valmap.id}">
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;"><font color="red">*</font>按钮名称:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="name" name="name" placeholder="按钮名称" value="${valmap.name}">
	               	</div>
	            </div>
	            <div class="form-group has-feedback">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;"><font color="red">*</font>所属菜单:</label>
					<div class="col-xs-9" onclick="getmenutree();">
						<input type="hidden" id="menuid" name="menuid" value="${valmap.menuid}">
						<input type="text" class="form-control" id="menuname" name="menuname" readonly style="cursor:pointer;" placeholder="所属菜单" value="${valmap.menuname}">
						<span class="glyphicon glyphicon-search form-control-feedback"></span>
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">是否可用:</label>
					<div class="col-xs-9">
	                   	<input type="radio"  id="isuse1" name="isuse"  value="1" checked>:是
	                   	<input type="radio"  id="isuse0" name="isuse"  value="0">:否
	               	</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>
<script>
//获取部门树
function getmenutree(){
	var dialog=new Dialog();
	dialog.Width = 400;
	dialog.Height = 300;
	dialog.Title="菜单树";
	dialog.URL="<%=ctx%>/tree/menutree";
	dialog.CancelEvent=function(menuid,menuname){
		$("#menuid").val(menuid);
		$("#menuname").val(menuname);
		dialog.close();
	};
	dialog.show();
}
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
    		name:{
            	required:true,
            	remote:{
               	    url:"<%=ctx%>/button/checkname",//后台处理程序
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
               	     	menuid:function(){
               	        	var menuid=$("#menuid").val();
               	        	return menuid;
               	        }
               	    }
               	}
            },
            menuname:{
            	required:true
            }
        },
        messages:{
        	name:{
                required:"请填写按钮名称！",
                remote:"按钮名称重复，请重新填写！"
            },
            menuname:{
            	required:"请选择所属菜单！"
            }
        },
        errorPlacement:function(error,element){//错误信息显示位置
        	element.after(error);
       	}
    });
	$("#isuse${valmap.isuse}").attr("checked","checked");
});
//部门保存
function save(){
	var ret="";
	if(validate){//验证重置
		validate.resetForm();
	}
	if(validate.form()){
		var id=$("#id").val();
		var name=$("#name").val();
		var menuid=$("#menuid").val();
		var isuse=$("input[name='isuse']:checked").val();
		$.ajax({
			type:'post',
			url:'<%=ctx %>/button/save',
			data:{'id':id,'name':name,'menuid':menuid,'isuse':isuse},
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