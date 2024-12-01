<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<script type="text/javascript">
window.UEDITOR_HOME_URL = "/snoweb/static/js/UEditor/";
</script>
<script type="text/javascript" charset="utf-8" src="<%=ctx%>/static/js/UEditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=ctx%>/static/js/UEditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=ctx%>/static/js/UEditor/lang/zh-cn/zh-cn.js"></script>
<input type="hidden" id="id" name="id" value="${valmap.id}">
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;"><font color="red">*</font>标题:</label>
					<div class="col-xs-5">
	                   	<input type="text" class="form-control" id="title" name="title" placeholder="标题" value="${valmap.title}">
	               	</div>
	               	<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;">是否公开:</label>
					<div class="col-xs-2">
						<select id="flag" class="form-control">
							<option value="0">公开</option>
							<option value="1">不公开</option>
						</select>
	               	</div>
	               	<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;">消息类型:</label>
					<div class="col-xs-2">
	                   	<select id="type" class="form-control" onchange="change();">
							<option value="0">系统消息</option>
							<option value="1">个人消息</option>
						</select>
	               	</div>
	            </div>
<!-- 	            <div class="form-group has-feedback" id="showcustomer" style="display:none;"> -->
<!-- 					<label class="col-xs-1 control-label" style="padding:5px 0px 0px 8px;">接收人:</label> -->
<!-- 					<div class="col-xs-11" onclick="getuser();"> -->
<!-- 						<input type="hidden" id="receiveids" name="receiveids" value=""> -->
<!-- 						<input type="text" class="form-control" id="receivenames" name="receivenames" readonly style="cursor:pointer;" placeholder="接收人" value=""> -->
<!-- 						<span class="glyphicon glyphicon-search form-control-feedback"></span> -->
<!-- 	               	</div> -->
<!-- 	            </div> -->
				<div class="form-group">
					<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;">通知内容:</label>
					<div class="col-xs-11">
	               	<script id="contentedit" type="text/plain" style="width:100%;height:280px;">${valmap.content}</script>
	               	</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>
<script>
//页面初始化
$(window).load(function(){
	//系统消息内容
	UE.getEditor('contentedit');
	var flag='${valmap.flag}';
	if(flag!=''){
		$("#flag").val(flag);	
	}
	//消息类型初始化
	var type='${valmap.type}';
	if(type!=''){
		$("#type").val(type);	
	}
});
//保存
function save(){
	var ret="";
	var id=$("#id").val();
	var title=$("#title").val();
	var content=UE.getEditor('contentedit').getContent();
	var flag=$("#flag").val();
	var type=$("#type").val();
	var save=true;
	if(title==''){
		Dialog.alert("请填写标题！");
	}else if(content==''){
		Dialog.alert("请填写通知内容！");
	}else{
		$.ajax({
			type:'post',
			url:'<%=ctx %>/message/save',
			data:{'id':id,'title':title,'content':content,'flag':flag,'type':type},
			dataType:'text',
			async:false,
			success:function(data){
				ret="ok";
			}
		});
	}
	return ret;
}

// UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
// UE.Editor.prototype.getActionUrl = function(action) {
//     if (action == '/snoweb/file/uploadFileSave' || action == 'uploadFileSave') {
  
<%--       return '<%=ctx%>/file/uploadFileSave'; --%>
//     } else {
//         return this._bkGetActionUrl.call(this, action);
//     }
// };
</script>