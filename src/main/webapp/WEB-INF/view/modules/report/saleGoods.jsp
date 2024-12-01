<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp"%>
<%
	String ctx = request.getContextPath();
%>
<div class="row">
	<div class="col-md-12">
		<div class="box box-default">
			<div class="box-body">
				<div class="row">
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">商品名称:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" id="goodsname">
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">商铺名称:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<select class="form-control" id="username" placeholder="商铺名称">
							<option value="">全部</option>
							<c:forEach var="user" items="${userlist }">
								<option value="${user.userid }">${user.username }</option>
							</c:forEach>
						</select>
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">支付方式:</label>
					<div class="col-xs-3" style="padding: 5px 20px 0px 0px;">
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
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" style="height: 34px;" id="startdate" name="startdate" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="">
					</div>
					<label class="col-xs-1" style="padding: 10px 0px 0px 20px;">结束日期:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" style="height: 34px;" id="enddate" name="enddate" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startdate\')}',maxDate:'%y-%M-{%d}'});" value="">
					</div>
					<div class="col-xs-4" style="padding: 10px 20px 0px 0px;">
						<div class="pull-right">
							<button type="button" class="btn btn-primary btn-sm" onclick="query();"> <i class="fa fa-search"></i>查询 </button>
							<button type="button" class="btn btn-primary btn-sm" onclick="rest();"> <i class="fa fa-eraser"></i>重置 </button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title" style="color: red;">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-info btn-xs" onclick="exports();">导出</button>
				</div>
			</div>
			<div class="box-body" id="tabbody" style="min-height: 200px;">
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
	$("#tabbody").css("height",getheight()-285);
	//初始化jqGrid--景区
	init(getheight()-370);
});
function getSum(startdate,enddate,goodsname,paymentid,username,customerid){
	$.ajax({
		type:'post',
		url:'<%=ctx%>/report/findSaleGoodsSum',
		data:{
			'startdate':startdate,
			'enddate':enddate,
			'goodsname':goodsname,
			'paymentid':paymentid,
			'username':username,
			'customerid':customerid
		},
		dataType:'text',
		async:false,
		success:function(data){
			$(".box-title").html(data);
		}
	});
}
//初始化jqGrid
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({ 
    	//caption:'',
		datatype:'local',//将这里改为使用JSON数据 
		url:'<%=ctx%>/report/findSaleGoodsPageByParam',//这是Action的请求地址 
		postData:{'startdate':'','enddate':'','goodsname':'','customerid':'${user.customerid}','paymentid':'','username':''},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','商家名称','商铺名称','商品名称','数量','单价(元)','金额(元)','支付方式','创建时间'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'customername',index:'customername',width:80,hidden:true,sortable:true},
        	{name:'username',index:'username',width:80,sortable:false}, 
        	{name:'goodsname',index:'goodsname',width:80,sortable:false}, 
        	{name:'num',index:'num',width:60,sortable:false}, 
        	{name:'price',index:'price',width:80,sortable:false}, 
        	{name:'amount',index:'amount',width:80,sortable:false}, 
        	{name:'paymentid',index:'paymentid',width:80,sortable:false}, 
        	{name:'creattime',index:'creattime',width:80,sortable:false}
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
//保存-更新-删除|刷新页面数据
function query(){
	var startdate=$("#startdate").val();
	var enddate=$("#enddate").val();
	var goodsname=$("#goodsname").val();
	var paymentid=$("#paymentid").val();
	var username=$("#username").val();
	var postdata={'startdate':startdate,'enddate':enddate,'goodsname':goodsname,'customerid':'${user.customerid}','paymentid':paymentid,'username':username};  
    $("#table").jqGrid("setGridParam",{datatype:'json',postData:postdata}).trigger("reloadGrid");
    getSum(startdate,enddate,goodsname,paymentid,username,'${user.customerid}');
}
//重置
function rest(){
	$("#startdate").val('');
	$("#enddate").val('');
	$("#goodsname").val('');
	$("#paymentid").val('');
	$("#username").val('');
}
//导出
function exports(){
	var startdate=$("#startdate").val();
	var enddate=$("#enddate").val();
	var goodsname=$("#goodsname").val();
	var paymentid=$("#paymentid").val();
	var username=$("#username").val();
	window.location.href="<%=ctx%>/report/saleGoodsExport.action?startdate="
				+ startdate
				+ "&enddate="
				+ enddate
				+ "&goodsname="
				+ goodsname
				+ "&paymentid="
				+ paymentid
				+ "&customerid=${user.customerid}&username=" + username;
	}
</script>