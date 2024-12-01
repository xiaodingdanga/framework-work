<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
		<div class="box box-default">
			<!-- 
			<div class="box-header with-border">
				<h3 class="box-title">Different Width</h3>
            </div> -->
            <div class="box-body">
              	<div class="row">
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">账号:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="account">
                	</div>
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">姓名:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="name">
                	</div>
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">IP:</label>
                	<div class="col-xs-3" style="padding:5px 20px 0px 0px;">
                  		<input type="text" class="form-control" id="ip">
                	</div>
              	</div>
              	<div class="row">
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">登录时间:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="Wdate form-control" style="height:34px;" id="createTimestart" name="createTimestart" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="">
                	</div>
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 40px;">至</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="Wdate form-control" style="height:34px;" id="createTimeend" name="createTimeend" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="">
                	</div>
                	<div class="col-xs-4" style="padding:10px 20px 0px 20px;">
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
	$("#tabbody").css("height",getheight()-335);
	//初始化jqGrid--用户
	init(getheight()-415);
});
//初始化jqGrid--用户
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/log/getDataList',//这是Action的请求地址 
		postData:{'account':'','name':'','ip':'','createTimestart':'','createTimeend':'','customerid':'${user.customerid}'},  
	    mtype:'POST',
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['账号','姓名','IP','登录时间'],//列名
        colModel:[//列对应的字段
            {name:'account',index:'account',width:60,sortable:false},  
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'ip',index:'ip',width:60,sortable:false},   
        	{name:'createDate',index:'createDate',width:60,sortable:false},  
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
        hidegrid:false
    });
	//自适应调整
    setjqGridWidth('table');
}
//保存-更新-删除|刷新页面数据--用户
function query(){
	var account=$("#account").val();
	var name=$("#name").val();
	var ip=$("#ip").val();
	var createTimestart=$("#createTimestart").val();
	var createTimeend=$("#createTimeend").val();
	var postdata={'account':account,'name':name,'ip':ip,'createTimestart':createTimestart,'createTimeend':createTimeend};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//重置
function rest(){
	$("#account").val('');
	$("#name").val('');
	$("#ip").val('');
	$("#createTimestart").val('');
	$("#createTimeend").val('');
}
</script>