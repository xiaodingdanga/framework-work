<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<div class="box box-default" style="border-top:0px;box-shadow:0 1px 1px rgba(0, 0, 0, 0);">
        	<div class="box-body">
        		<!-- 部门树start -->
        		<input type="text" class="form-control" id="key" name="key" placeholder="关键字" onkeyup="changekey();">
        		<input type="hidden" id="depid" value="">
        		<input type="hidden" id="depname" value="">
                <div id="tree" class="ztree"></div>
                <!-- 部门树end -->
        	</div>
      	</div>
    </div>
</div>
<script>
$(window).load(function(){
	$("#depid").val('${valmap.depid}');
	$("#depname").val('${valmap.depname}');
	//初始化zTree
	$.fn.zTree.init($("#tree"),setting,zNodes);
});
//默认树初始化
var zTree;
//起始节点初始化
var zNodes=${node};
var setting={
	//设置异步获取方式
	async:{
 		enable:true,
 		dataType:"text",
 		type:"post",
 		url:"<%=ctx%>/tree/depdata",
  		autoParam:["id=pid"],//向后台传递参数
  		dataFilter:filter//返回数据处理方法
  	},
  	callback:{
  		onCheck: zTreeOnCheck//勾选点击回调函数
	},
  	check: {//checkbox
		enable:true,//checkbox是否显示
		chkStyle:"checkbox",
		chkboxType:{"Y":"","N":""}
	},
  	//设置显示方式
    view:{showIcon:false}
};
//返回数据处理方法
function filter(treeId,parentNode,childNodes){
	if(childNodes){
		var depid=$("#depid").val();//选中的部门ID
  		for(var i=0;i<childNodes.length;i++){
  	  		var id=childNodes[i].id;
  	  		if(depid.indexOf(id)>=0){
  	  			childNodes[i].checked=true;
  	  		}
  		}
  	}
	return childNodes;
}
//选择触发事件
function zTreeOnCheck(event,treeId,treeNode){
	var id=treeNode.id;//选中ID
	var name=treeNode.name;//选中名称
	var checked=treeNode.checked;//是否选中
	var depid=$("#depid").val();
	var depname=$("#depname").val();
	if(id!="0"){
		if(checked){//选中
			depid+=id+",";
			depname+=name+",";
		}else{//取消
			depid=depid.replace(id+",","");
			depname=depname.replace(name+",","");
		}
		$("#depid").val(depid);
		$("#depname").val(depname);
	}
}
//返回部门id
function getdepids(){
	return $("#depid").val();
}
//返回部门name
function getdepnames(){
	return $("#depname").val();
}
//关键字查询
function changekey(){
	var key=$("#key").val();
	if(key==""){
		//初始化zTree
		$.fn.zTree.init($("#tree"),setting,zNodes);
	}else{
		$.fn.zTree.destroy();
		//起始节点初始化
		var settingquery={
			//设置异步获取方式
			async:{
		 		enable:true,
		 		dataType:"text",
		 		type:"post",
		 		url:"<%=ctx%>/tree/depdataquery?key="+key,
		  		dataFilter:filter//返回数据处理方法
		  	},
		  	callback:{
		  		onCheck: zTreeOnCheck//勾选点击回调函数
			},
		  	check: {//checkbox
				enable:true,//checkbox是否显示
				chkStyle:"checkbox",
				chkboxType:{"Y":"","N":""}
			},
		  	//设置显示方式
		    view:{showIcon:false}
		};
		//初始化zTree
		$.fn.zTree.init($("#tree"),settingquery,null);
	}
}
</script>