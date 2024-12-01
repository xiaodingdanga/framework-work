<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-3">
		<div class="box box-default">
			<div class="box-header with-border" style="padding:6px;">
          		<h3 class="box-title">
          			<input type="text" id="key" name="key" placeholder="关键字" onkeyup="changekey();">
          		</h3>
          		<div class="box-tools pull-right">
            		<!-- <span class="label label-default"></span> -->
          		</div>
        	</div>
        	<div class="box-body" id="treebody" style="min-height:400px;overflow:auto;">
        		<!-- 部门树start -->
        		<input type="hidden" id="pid" name="pid" value="0">
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
          			<c:if test="${fn:contains(button,'a5fb5873a8524d6f95bee1d2bdef3914')}">
          				<button type="button" class="btn btn-success btn-xs" onclick="add();"><i class="fa fa-plus"></i>添加</button>
          			</c:if>
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
	//初始化jqGrid--部门
	init("0",getheight()-260);
	//初始化zTree
	$.fn.zTree.init($("#tree"),setting,zNodes);
});
//初始化jqGrid--部门
function init(pid,height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/dep/getDataList',//这是Action的请求地址 
		postData:{'pid':pid},  
	    mtype:'POST',
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','部门名称','全名','部门主管','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'fullname',index:'fullname',width:60,sortable:false},  
        	{name:'dephead',index:'dephead',width:60,sortable:false}, 
         	{name:'Edit',index:'Edit',width:60}
        ],
     	multiselect:true,//是否支持多选   
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
                <c:if test="${fn:contains(button,'6bc32ca9d9a642ebbc331fe18d5b6682')}">
                	editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" onclick=\"edit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
               	</c:if>
                <c:if test="${fn:contains(button,'1c3c930db2434dcc94e56a2af9c5805a')}">
                	editBtn+="&nbsp;&nbsp;";
                	editBtn+="<button type=\"button\" class=\"btn btn-danger btn-xs\" onclick=\"del(\'"+id+"\');\"><i class=\"fa fa-times\"></i>删除</button>";
                </c:if>
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
var zNodes=${node};
var setting={
	//设置异步获取方式
	async:{
 		enable:true,
 		dataType:"text",
 		type:"post",
 		url:"<%=ctx%>/tree/depdata",
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
	var pid=treeNode.id;
	$("#pid").val(pid);
	//刷新
	var postdata={'pid':pid};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//保存-更新-删除|刷新页面数据--部门
function refresh(pid){
  	//初始化zTree
	$.fn.zTree.init($("#tree"),setting,zNodes);
	//刷新
	var postdata={'pid':pid};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//添加部门
function add(){
	var pid=$("#pid").val();
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="添加部门";
	dialog.URL="<%=ctx%>/dep/toadd?pid="+pid;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			var newpid=dialog.innerFrame.contentWindow.backpid();
			dialog.close();
			//刷新
			refresh(newpid);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//编辑部门
function edit(id){
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="修改部门";
	dialog.URL="<%=ctx%>/dep/toedit?id="+id;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			var newpid=dialog.innerFrame.contentWindow.backpid();
			dialog.close();
			//刷新
			refresh(newpid);
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//删除部门--单个删除
function del(id){
	var pid=$("#pid").val();
	Dialog.confirm('确定要删除吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/dep/delete',
				data:{'id':id},
				dataType:'text',
				async:false,
				success:function(data){
					if(data=="true"){
						//刷新
						refresh(pid);
					}else{
						Dialog.alert("请先删除子部门！");
					}
				}
			});
		}
	);
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
		 		url:"<%=ctx%>/tree/depdataquery?key="+key
		  	},
		  	callback:{
				onClick:zTreeOnClick
			},
		  	//设置显示方式
		    view:{showIcon:false}
		};
		//初始化zTree
		$.fn.zTree.init($("#tree"),settingquery,null);
	}
}
</script>