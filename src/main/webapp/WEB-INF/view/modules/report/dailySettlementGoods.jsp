<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp"%>
<%
	String ctx = request.getContextPath();
%>
<div class="row">
	<div class="col-md-12">
<%-- 		<div class="box box-default">
			<div class="box-body">
				<div class="row">
					<label class="col-xs-1 control-label"
						style="padding: 10px 0px 0px 20px;">分销商:</label>
					<div class="col-xs-3"
						style="padding: 5px 0px 0px 0px; width: 260px;">
						<input type="text" class="form-control" id="dname">
					</div>
					<label class="col-xs-1 control-label"
						style="padding: 10px 0px 0px 20px;">交易类型:</label>
					<div class="col-xs-3"
						style="padding: 5px 0px 0px 0px; width: 260px;">
						<select class="form-control" id="status" placeholder="交易类型">
							<option value="">全部</option>
							<option value="1">售票</option>
							<option value="-1">退票</option>
						</select>
					</div>
					<label class="col-xs-1 control-label"
						style="padding: 10px 0px 0px 20px;">支付方式:</label>
					<div class="col-xs-3"
						style="padding: 5px 0px 0px 0px; width: 260px;">
						<select class="form-control" id="paymentid" placeholder="支付方式">
							<option value="">全部</option>
							<c:forEach var="type" items="${listPayType }">
								<option value="${type.id }">${type.name }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<label class="col-xs-1" style="padding: 10px 0px 0px 20px;">起始日期:</label>
					<div class="col-xs-3"
						style="padding: 5px 0px 0px 0px; width: 260px;">
						<input type="text" class="form-control" style="height: 34px;"
							id="startdate" name="startdate" readonly
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="">
					</div>
					<label class="col-xs-1" style="padding: 10px 0px 0px 20px;">结束日期:</label>
					<div class="col-xs-3"
						style="padding: 5px 0px 0px 0px; width: 260px;">
						<input type="text" class="form-control" style="height: 34px;"
							id="enddate" name="enddate" readonly
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startdate\')}',maxDate:'%y-%M-{%d}'});"
							value="">
					</div>
					<div class="col-xs-4" style="padding: 10px 20px 0px 0px;">
						<div class="pull-right">
							<button type="button" class="btn btn-primary btn-sm"
								onclick="query();">
								<i class="fa fa-search"></i>查询
							</button>
							<button type="button" class="btn btn-primary btn-sm"
								onclick="rest();">
								<i class="fa fa-eraser"></i>重置
							</button>
						</div>
					</div>
				</div>
			</div>
		</div> --%>
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title" style="color: black;">&nbsp;商品销售日结对账</h3>
				<div class="box-tools pull-right">
					<!-- <button type="button" class="btn btn-info btn-xs"
						onclick="exports();">导出</button> -->
				</div>
			</div>
			<div class="box-body" id="tabbody" style="min-height: 200px;">
				<!-- 数据start -->
				<div class="jqGrid_wrapper">
					<table id="table" style="font-size: 20px;"></table>
					<div id="pager"></div>
				</div>
				<!-- 数据end -->
			</div>
		</div>
	</div>
</div>
<script>
$(window).load(function(){
	$("#tabbody").css("height",getheight()-285);
	//初始化jqGrid--景区
	init(getheight()-370);
});
//初始化jqGrid
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({ 
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/report/findDS',//这是Action的请求地址 
		postData:{'classify':'3'},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['景区','商铺','支付方式','合计金额(元)'],//列名
        colModel:[//列对应的字段
            {name:'customername',index:'customername',width:80,hidden:true,sortable:true},
            {name:'username',index:'username',width:80,sortable:false}, 
            {name:'payment',index:'payment',width:80,sortable:false}, 
            {name:'amount',index:'amount',width:80,sortable:false}
        ],
     	multiselect:false,//是否支持多选   
     	viewrecords:false,//是否显示行数 
     	rowNum:-1,//每页显示记录数-1：显示所有数据
        //rowList:[10,20,30,50,100],//可调整每页显示的记录数  
	    //pager:'pager', //分页工具栏 
	    //pagerpos:'center',//分页栏显示位置，默认center
   	    //pgtext:"当前第{0}页/共{1}页",
        //recordtext:"当前为第{0}到第{1}行数据，共{2}数据",
        emptyrecords: "无显示数据",
        loadtext: "查询中......",
        pgbuttons:false,//是否显示翻页按钮
        pginput:false,//是否显示分页跳转输入框
        forceFit:true,//调整列宽时不会改变表格宽度
        reccount:0,
        rownumbers:false,
        hidegrid:false
    });
	//自适应调整
    setjqGridWidth('table');
}
</script>