<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<div class="box box-default" style="border-top:0px;box-shadow:0 1px 1px rgba(0, 0, 0, 0);">
        	<div class="box-body">
        		<!-- 菜单树start -->
                <div id="tree" class="ztree"></div>
                <!-- 菜单树end -->
        	</div>
      	</div>
    </div>
</div>
<script>
$(window).load(function(){
	//初始化zTree
	$.fn.zTree.init($("#tree"),setting,zNodes);
});
//默认树初始化
var zTree;
//起始节点初始化
var zNodes=[{id:"0",name:"商品分类",isParent:true}];
var setting={
	//设置异步获取方式
	async:{
 		enable:true,
 		dataType:"text",
 		type:"post",
 		url:"<%=ctx%>/tree/goodstypedata",
  		autoParam:["id=pid"]//向后台传递参数
  	},
  	callback:{
		onClick:zTreeOnClick
	},
  	//设置显示方式
    view:{showIcon:false}
};
//点击触发事件
function zTreeOnClick(event,treeId,treeNode){
	var id=treeNode.id;
	var name=treeNode.name;
	if(id=="0"){
		name="";
	}
	//调用父级关闭方法，并传值
	parentDialog.cancelButton.onclick(id,name);
}
</script>