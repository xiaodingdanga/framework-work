<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
		<div class="box box-default">
			<div class="box-header with-border">
          		<h3 class="box-title" style="width:20%;"></h3>
          		<div class="box-tools pull-right">
          			<c:if test="${fn:contains(button,'e9f33cece9e54c66a5c22129c708e857')}">
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
	$("#tabbody").css("height",getheight()-210);
	//初始化jqGrid--角色
	init(getheight()-290);
});
//初始化jqGrid--角色
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({ 
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/role/getDataList',//这是Action的请求地址 
		postData:{'customerid':'${user.customerid}','createrid':'${user.id}'},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','issys1','角色名称','是否预制','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'issys1',index:'issys1',width:30,hidden:true,sortable:false},
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'issys',index:'issys',width:60,sortable:false},   
         	{name:'Edit',index:'Edit',width:100}
        ],
     	multiselect:false,//是否支持多选   
     	viewrecords:true,//是否显示行数 
     	rowNum:10,//每页显示记录数-1：显示所有数据
        rowList:[10,20,30,50,100],//可调整每页显示的记录数  
	    pager:'pager', //分页工具栏 
	    pagerpos:'center',//分页栏显示位置，默认center
   	    pgtext:"当前第{0}页/共{1}页",
        recordtext:"当前为第{0}到第{1}行数据，共{2}数据",
        emptyrecords: "无显示数据",
        loadtext: "查询中......",
        pgbuttons:true,//是否显示翻页按钮
        pginput:true,//是否显示分页跳转输入框
        forceFit:true,//调整列宽时不会改变表格宽度
        reccount:0,
        rownumbers:true,
        hidegrid:false,
        gridComplete:function(){
            var ids=jQuery("#table").jqGrid('getDataIDs');
            for(var i=0;i<ids.length;i++){
                var id = ids[i];
                var rowData=$("#table").getRowData(id);
                var issys=rowData.issys1;
                var editBtn="";//此处会将点击行id传给_edit(id) js函数
                if(issys=="0"){
                	<c:if test="${fn:contains(button,'698e9e271ab840558e18103d767c5ccc')}">
		                editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" onclick=\"edit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
	                </c:if>
	               	<c:if test="${fn:contains(button,'1245737fe48142dfa6fe578f8fb7fb4f')}">
	               		editBtn+="&nbsp;&nbsp;";
		               	editBtn+="<button type=\"button\" class=\"btn btn-danger btn-xs\" onclick=\"del(\'"+id+"\');\"><i class=\"fa fa-times\"></i>删除</button>";
	               	</c:if>
                }
                <c:if test="${fn:contains(button,'2201e8bd98b84890ba10e70cb75cd06e')}">
	               	editBtn+="&nbsp;&nbsp;";
	        		editBtn+="<button type=\"button\" class=\"btn btn-info btn-xs\" onclick=\"permission(\'"+id+"\');\"><i class=\"fa fa-cog\"></i>权限设置</button>";
	       		</c:if>
            	jQuery("#table").jqGrid('setRowData',ids[i],{Edit:editBtn});
            }
		} 
    });
	//自适应调整
    setjqGridWidth('table');
}
//保存-更新-删除|刷新页面数据--角色
function refresh(){
	//刷新列表
	var postdata={'customerid':'${user.customerid}','createrid':'${user.id}'};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//添加角色
function add(){
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="添加角色";
	dialog.URL="<%=ctx%>/role/toadd";
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			refresh();
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//编辑角色
function edit(id){
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="修改角色";
	dialog.URL="<%=ctx%>/role/toedit?id="+id;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			refresh();
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//删除角色--批量删除
function batchdel(){
	var idobj=$("#table").jqGrid('getGridParam','selarrrow');
	if(idobj.length>0){
		Dialog.confirm('确定要删除吗？',
			function(){
				var ids="";
				for(var i=0;i<idobj.length;i++){
					ids+=idobj[i]+",";
				}
				ids=ids.substring(0,ids.length-1);
				$.ajax({
					type:'post',
					url:'<%=ctx %>/role/batchdelete',
					data:{'ids':ids},
					dataType:'text',
					async:false,
					success:function(data){
						//刷新
						refresh();
					}
				});
			}
		);
	}else{
		Dialog.alert('请选择要删除的数据！');
	}
}
//删除角色--单个删除
function del(id){
	Dialog.confirm('确定要删除吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/role/delete',
				data:{'id':id},
				dataType:'text',
				async:false,
				success:function(data){
					//刷新
					refresh();
				}
			});
		}
	);
}
//角色权限设置
function permission(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="设置权限";
	dialog.URL="<%=ctx%>/permission/setpermission?id="+id;
	dialog.show();
}
</script>