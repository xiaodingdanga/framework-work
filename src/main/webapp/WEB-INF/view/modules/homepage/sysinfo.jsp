<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
	            	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 0px;">标题：</label>
	            	<div class="col-xs-9" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="title" placeholder="标题">
                	</div>
                	<div class="col-xs-2" style="padding:5px 20px 0px 0px;">
                		<div class="pull-right">
	                		<button type="button" class="btn btn-primary btn-sm" onclick="query();"><i class="fa fa-search"></i>查询</button>
                		</div>
                	</div>
	            </div>
	            <!-- 数据start -->
                <div class="jqGrid_wrapper">
                 	<table id="table"></table>
                 	<div id="pager"></div>
                </div>
                <!-- 数据end -->
	       	</div>
       	</form>
    </div>
</div>
<script>
//页面初始化
$(window).load(function(){
	//初始化jqGrid--用户
	init(getheight()-150);
});
//初始化jqGrid--用户
function init(height){
	//AJAX请求列表数据x`x`
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/homepage/getDataMessage',//这是Action的请求地址 
		postData:{'title':'','customerid':'${user.customerid}'},  
	    mtype:'POST',
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','标题','发送人','创建时间','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'title',index:'title',width:200,sortable:false},    
            {name:'sendname',index:'sendname',width:60,sortable:false},   
            {name:'updatetime',index:'updatetime',width:100,sortable:false},   
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
//                 var rowData=$("#table").getRowData(id);
                var editBtn="<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"look(\'"+id+"\');\"><i class=\"fa fa-search\"></i>查看</button>";
                jQuery("#table").jqGrid('setRowData',ids[i],{Edit:editBtn});
            }
        }
    });
	//自适应调整
    setjqGridWidth('table');
}
//刷新页面数据--用户
function query(){
	var title=$("#title").val();
	var postdata={'title':title,'customerid':'${user.customerid}'};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//查看
function look(id){
	var dialog=new Dialog();
	dialog.Width = 1000;
	dialog.Height = 500;
	dialog.Title="查看系统信息";
	dialog.URL="<%=ctx%>/homepage/messagelook?id="+id;
	dialog.show();
}
</script>