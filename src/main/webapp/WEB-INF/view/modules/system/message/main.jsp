<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
   <input type="hidden" id="depid" name="depid" value="id">
    <div class="col-md-12">
		<div class="box box-default">
            <div class="box-body">
              	<div class="row">
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">标题:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="title">
                	</div>
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">类型:</label>
                	<div class="col-xs-3" style="padding:5px 10px 0px 0px;">
                  		<select id="type" class="form-control">
                  			<option value=""></option>
                  			<option value="0">系统消息</option>
                  			<option value="1">个人消息</option>
                  		</select>
                	</div>
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">是否公开:</label>
                	<div class="col-xs-3" style="padding:5px 20px 0px 0px;">
                  		<select id="flag" class="form-control">
                  			<option value=""></option>
                  			<option value="0">公开</option>
                  			<option value="1">不公开</option>
                  		</select>
                	</div>
                </div>
              	<div class="row">
                	<div class="col-xs-12"  style="padding:5px 20px 0px 20px;">
                  		<div class="pull-right">
		          			<button type="button" class="btn btn-primary btn-sm" onclick="query();"><i class="fa fa-search"></i>查询</button>
		      				<button type="button" class="btn btn-primary btn-sm" onclick="rest();"><i class="fa fa-eraser"></i>重置</button>
		          		</div>
                	</div>
              	</div>
          	</div>
  		</div>
   		<div class="box box-default">
			<div class="box-header with-border">
          		<h3 class="box-title">&nbsp;</h3>
          		<div class="box-tools pull-right">
          			<button type="button" class="btn btn-success btn-xs" onclick="add();"><i class="fa fa-plus"></i>添加</button>
          		</div>
        	</div>
        	<div class="box-body" id="tabbody" style="min-height:200px;">
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
	$("#tabbody").css("height",getheight()-300);
	//初始化jqGrid--用户
	init(getheight()-380);
});
//初始化jqGrid--用户
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/message/getDataList',//这是Action的请求地址 
		postData:{'title':'','type':'','flag':''},  
	    mtype:'POST',
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','标题','是否公开','类型','创建时间','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'title',index:'title',width:100,sortable:false},
        	{name:'flag',index:'flag',width:40,sortable:false,formatter:"select",editoptions:{value:"0:公开;1:不公开"}},  
        	{name:'type',index:'type',width:40,sortable:false,formatter:"select",editoptions:{value:"0:系统消息;1:个人消息"}},
        	{name:'updatetime',index:'updatetime',width:40,sortable:false},  
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
                var flag=rowData.flag;
                var editBtn="";//此处会将点击行id传给_edit(id) js函数
	            	editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" onclick=\"edit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
	             	editBtn+="&nbsp;&nbsp;";
             		editBtn+="<button type=\"button\" class=\"btn btn-danger btn-xs\" onclick=\"del(\'"+id+"\');\"><i class=\"fa fa-times\"></i>删除</button>";
                   	editBtn+="&nbsp;&nbsp;";
                   	editBtn+="<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"look(\'"+id+"\');\"><i class=\"fa fa-search\"></i>查看</button>";
             		editBtn+="&nbsp;&nbsp;";
             		if(flag=='1'){
             			editBtn+="<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"show(\'"+id+"\',\'0\');\">公开</button>";
             		}else{
             			editBtn+="<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"show(\'"+id+"\',\'1\');\">不公开</button>";
             		}
                jQuery("#table").jqGrid('setRowData',ids[i],{Edit:editBtn});
            }
		}
    });
	//自适应调整
    setjqGridWidth('table');
}
//保存-更新-删除|刷新页面数据--用户
function query(){
	var title=$("#title").val();
	var type=$("#type").val();
	var flag=$("#flay").val();
	var postdata={'title':title,'type':type,'flag':flag}
	$("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//重置
function rest(){
	$("#title").val('');
	$("#type").val('');
	$("#flag").val('');
}
//添加通知
function add(){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="添加系统通知";
	dialog.URL="<%=ctx%>/message/toadd";
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			query();
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//修改通知
function edit(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="修改系统通知";
	dialog.URL="<%=ctx%>/message/toedit?id="+id;
	dialog.OKEvent=function(){
		var ret=dialog.innerFrame.contentWindow.save();
		if(ret=="ok"){
			dialog.close();
			//刷新
			query();
		}
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
//删除
function del(id){
	Dialog.confirm('此数据删除不可恢复，确定要删除吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/message/delete',
				data:{'id':id},
				dataType:'text',
				async:false,
				success:function(data){
					//刷新
					query();
				}
			});
		}
	);
}
//查看
function look(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="查看详细信息";
	dialog.URL="<%=ctx%>/message/look?id="+id;
	dialog.show();
}
//开关按钮
function show(id,flag){
	Dialog.confirm('确定要更改当前状态吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/message/show',
				data:{'id':id,'flag':flag},
				dataType:'text',
				async:false,
				success:function(data){
					//刷新
					query();
				}
			});
		}
	);
}
</script>