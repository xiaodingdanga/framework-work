<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-3">
		<div class="box box-default">
			<div class="box-header with-border">
          		<h3 class="box-title">&nbsp;</h3>
          		<div class="box-tools pull-right">
            		<button type="button" class="btn btn-success btn-xs" onclick="menuadd();"><i class="fa fa-plus"></i>添加菜单</button>
          		</div>
        	</div>
        	<div class="box-body" id="treebody" style="min-height:400px;overflow:auto;">
        		<!-- 菜单树start -->
        		<input type="hidden" id="menuid" name="menuid" value="">
                <div id="tree" class="ztree"></div>
                <!-- 部门树end -->
        	</div>
      	</div>
    </div>
    <div class="col-md-9">
		<div class="box box-default">
			<div class="box-header with-border">
          		<h3 class="box-title">&nbsp;</h3>
          		<div class="box-tools pull-right">
          			<button type="button" class="btn btn-success btn-xs" onclick="btnadd();"><i class="fa fa-plus"></i>添加按钮</button>
          		</div>
        	</div>
        	<div class="box-body" id="tabbody" style="min-height:400px;">
        		<!-- 数据start -->
                <div class="jqGrid_wrapper">
                 	<table id="table"></table>
                 	<div id="pager"></div>
                </div>
                <!-- 数据end -->
        	</div>
      	</div>
    </div>
</div>
<script>
$(window).load(function(){
	$("#treebody").css("height",getheight()-210);
	$("#tabbody").css("height",getheight()-210);
	//初始化jqGrid--按钮
	init("",getheight()-260);
	//初始化zTree
	$.fn.zTree.init($("#tree"),setting,zNodes);
});
//初始化jqGrid--按钮
function init(menuid,height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/button/getDataList',//这是Action的请求地址 
		postData:{'menuid':menuid},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','按钮名称','所属菜单','是否可用','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'menuname',index:'menuname',width:60,sortable:false},   
        	{name:'isuse',index:'isuse',width:60,sortable:false},  
         	{name:'Edit',index:'Edit',width:60}
        ],
//      	multiselect:true,//是否支持多选   
     	viewrecords:true,//是否显示行数 
   		rowNum:-1,//每页显示记录数-1：显示所有数据
        //rowList:[10,20,30,50,100],//可调整每页显示的记录数  
	        //pager: 'pager', //分页工具栏 
   	    //pgtext:"当前第{0}页/共{1}页",
        //recordtext:"当前为第{0}到第{1}行数据，共{2}数据",
        //pginput:true,//是否显示分页跳转输入框
        forceFit:true,//调整列宽时不会改变表格宽度
        reccount:0,
        rownumbers:true,
        hidegrid:false,
        gridComplete:function(){
            var ids=jQuery("#table").jqGrid('getDataIDs');
            for(var i=0;i<ids.length;i++){
                var id = ids[i];
                var rowData=$("#table").getRowData(id);
                var editBtn="";//此处会将点击行id传给_edit(id) js函数
                editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" onclick=\"btnedit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
               	editBtn+="&nbsp;&nbsp;";
                editBtn+="<button type=\"button\" class=\"btn btn-danger btn-xs\" onclick=\"btndel(\'"+id+"\');\"><i class=\"fa fa-times\"></i>删除</button>";
                jQuery("#table").jqGrid('setRowData',ids[i],{Edit:editBtn});
            }
		} 
    });
	//自适应调整
    setjqGridWidth('table');
}
//默认树初始化
var zTree;
//起始节点初始化
var zNodes=[{id:"0",name:"菜单树",isParent:true}];
var setting={
	//设置异步获取方式
	async:{
 		enable:true,
 		dataType:"text",
 		type:"post",
 		url:"<%=ctx%>/tree/menudata",
  		autoParam:["id=pid"]//向后台传递参数
  	},
  	callback:{
		onClick:zTreeOnClick,
		beforeEditName:zTreeBeforeEditName,
		beforeRemove:zTreeBeforeRemove
	},
	edit:{
		enable:true,
		showRenameBtn:true,
		renameTitle:"修改菜单",
		showRemoveBtn:true,
		removeTitle:"删除菜单"
	},
  	//设置显示方式
    view:{showIcon:false}
};
//点击触发事件
function zTreeOnClick(event,treeId,treeNode){
	var menuid=treeNode.id;
	if(menuid=="0"){
		menuid="";
	}
	$("#menuid").val(menuid);
	//刷新
	var postdata={'menuid':menuid};
  	$("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//删除菜单
function zTreeBeforeRemove(treeId,treeNode){
	var id=treeNode.id;
	if(id=="0"){
		return false;
	}else{
		if(treeNode.isParent){
			Dialog.alert("请先删除子菜单！");
		}else{
			Dialog.confirm('确定要删除吗？',
				function(){
					$.ajax({
						type:'post',
						url:'<%=ctx %>/menu/delete',
						data:{'id':treeNode.id},
						dataType:'text',
						async:false,
						success:function(data){
							//js页面删除选中菜单
							$.fn.zTree.getZTreeObj("tree").removeNode(treeNode);
							//刷新按钮列表
							refreshbtn("");
						}
					});
				}
			);
		}
	}
	return false;
}
//修改菜单
function zTreeBeforeEditName(treeId,treeNode){
	var id=treeNode.id;
	if(id=="0"){
		return false;
	}
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="修改菜单";
	dialog.URL="<%=ctx%>/menu/toedit?id="+id;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//初始化zTree
			$.fn.zTree.init($("#tree"),setting,zNodes);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
	return false;
}
//添加菜单
function menuadd(){
	var menuid=$("#menuid").val();
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="添加菜单";
	dialog.URL="<%=ctx%>/menu/toadd?pid="+menuid;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//初始化zTree
			$.fn.zTree.init($("#tree"),setting,zNodes);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//保存-更新-删除|刷新页面数据--按钮
function refreshbtn(menuid){
	//刷新
	var postdata={'menuid':menuid};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//添加按钮
function btnadd(){
	var menuid=$("#menuid").val();
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="添加按钮";
	dialog.URL="<%=ctx%>/button/toadd?menuid="+menuid;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			refreshbtn(menuid);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//编辑按钮
function btnedit(id){
	var menuid=$("#menuid").val();
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="修改按钮";
	dialog.URL="<%=ctx%>/button/toedit?id="+id;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			refreshbtn(menuid);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//删除按钮--单个删除
function btndel(id){
	var menuid=$("#menuid").val();
	Dialog.confirm('确定要删除吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/button/delete',
				data:{'id':id},
				dataType:'text',
				async:false,
				success:function(data){
					//刷新
					refreshbtn(menuid);
				}
			});
		}
	);
}
</script>