<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<input type="hidden" id="id" name="id" value="${valmap.id}">
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">配置名称:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="name" name="name" placeholder="配置名称" readonly value="${valmap.name}">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">编码:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="code" name="code" placeholder="编码" readonly value="${valmap.code}">
	               	</div>
	            </div>
	            <div class="form-group">
					<label class="col-xs-3 control-label" style="padding:5px 0px 0px 50px;">值:</label>
					<div class="col-xs-9">
	                   	<input type="text" class="form-control" id="value" name="value" placeholder="值" value="${valmap.value}">
	               	</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>
<script>
//配置保存
function save(){
	var id=$("#id").val();
	var value=$("#value").val();
	$.ajax({
		type:'post',
		url:'<%=ctx %>/config/update',
		data:{'id':id,'value':value},
		dataType:'text',
		async:false,
		success:function(data){}
	});
	return true;
}
</script>