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
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">票名称:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" id="ticketname">
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 15px;">卡号:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
<!-- 						<input type="text" onclick="rest();" placeholder="请输入长度10位的卡号" onchange="query()" class="form-control" id="code" autofocus="autofocus"> -->
						<input type="text"   placeholder="请输入长度10位的卡号"class="form-control" id="code" autofocus="autofocus">
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 15px;">商品名称:</label>
					<div class="col-xs-3" style="padding: 5px 20px 0px 0px;">
						<input type="text" class="form-control" id="goodsname">
					</div>
				</div>
				<div class="row">
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">交易来源:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<select class="form-control" id="classify">
							<option value="">全部</option>
							<option value="1">票</option>
							<option value="2">卡</option>
							<option value="3">商品</option>
						</select>
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 15px;">支付方式:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<select class="form-control" id="paymentid" placeholder="支付方式">
							<option value="">全部</option>
							<c:forEach var="type" items="${listPayType }">
								<option value="${type.id }">${type.name }</option>
							</c:forEach>
						</select>
					</div>
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 15px;">收入支出:</label>
					<div class="col-xs-3" style="padding: 5px 20px 0px 0px;">
						<select class="form-control" id="pay_in" placeholder="收入支出">
							<option value="">全部</option>
							<option value="0">收入</option>
							<option value="1">支出</option>
						</select>
					</div>
				</div>
				<div class="row">
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">交易类型:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<select class="form-control" id="status">
							<option value="">全部</option>
							<option value="1">售票</option>
							<option value="2">售卡(收押金)</option>
							<option value="3">商品销售</option>
							<option value="-1">退票</option>
							<option value="-2">退卡(退押金)</option>
						</select>
					</div>
					<label class="col-xs-1" style="padding: 10px 0px 0px 15px;">起始日期:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" style="height: 34px;" id="startdate" name="startdate" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-{%d}'});" value="">
					</div>
					<label class="col-xs-1" style="padding: 10px 0px 0px 15px;">结束日期:</label>
					<div class="col-xs-3" style="padding: 5px 20px 0px 0px;">
						<input type="text" class="form-control" style="height: 34px;" id="enddate" name="enddate" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startdate\')}',maxDate:'%y-%M-{%d}'});" value="">
					</div>
				</div>
				<div class="row">
					<label class="col-xs-1 control-label" style="padding: 10px 0px 0px 20px;">用户名称:</label>
					<div class="col-xs-3" style="padding: 5px 0px 0px 0px;">
						<input type="text" class="form-control" id="username">
					</div>
					<div class="col-xs-8" style="padding: 10px 20px 0px 20px;">
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
// 	$("#tabbody").css("height",getheight()-385);
	//初始化jqGrid--景区
	init(getheight()-370);
// 	init(getheight()-470);
});
function getSum(startdate,enddate,goodsname,paymentid,pay_in,classify,ticketname,code,status,username,customerid){
	$.ajax({
		type:'post',
		url:'<%=ctx%>/report/findRecordSum',
		data:{ 'startdate':startdate, 'enddate':enddate, 'goodsname':goodsname, 'paymentid':paymentid, 'pay_in':pay_in, 'classify':classify, 'ticketname':ticketname, 'code':code, 'status':status, 'username':username, 'customerid':customerid },
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
		datatype:'local',//返回值类型使用local，页面加载时不会查询数据 
		url:'<%=ctx%>/report/findRecordPageByParam',//这是Action的请求地址 
		postData:{'startdate':'','enddate':'','goodsname':'','customerid':'${user.customerid}','paymentid':'','pay_in':'','classify':'','ticketname':'','code':'','username':'','status':''},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','商家名称','用户名称','交易类型','票名称','商品名称','卡号','交易金额','支付方式','收入/支出','交易时间'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'customername',index:'customername',width:50,hidden:true,sortable:true},
            {name:'username',index:'username',width:50,sortable:true},
            {name:'status',index:'status',width:30,sortable:false,formatter:"select",editoptions:{value:"-2:退卡(退押金);-1:退票;1:售票;2:售卡(收押金);3:商品销售"},cellattr:addCellAttr},
        	{name:'ticketname',index:'ticketname',width:60,sortable:false}, 
        	{name:'goodsname',index:'goodsname',width:60,sortable:false},
        	{name:'code',index:'code',width:60,sortable:false},
        	{name:'amount',index:'amount',width:30,sortable:false,cellattr:addCellAttr}, 
        	{name:'payment',index:'payment',width:30,sortable:false,cellattr:addCellAttr},
            {name:'pay_in',index:'pay_in',width:20,sortable:false,formatter:"select",editoptions:{value:"0:收入;1:支出"},cellattr:addCellAttr},
        	{name:'creattime',index:'creattime',width:50,sortable:false}
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
/*         loadComplete: function (){
        	//设置背景色
        	var ids = jQuery("#table").jqGrid("getDataIDs");//获取所有行的id
			var rowDatas = jQuery("#table").jqGrid("getRowData");//获取所有行的数据
			for(var i=0;i < rowDatas.length;i++){
			    //var rowData = $("#table").getRowData(ids[i]);
			    var rowData = rowDatas[i];
			  	//如果某一行中的“pay_in”为支出，那就把这一整行的背景颜色设为红色
		        if(rowData.pay_in == '1'){
		        	$("#" + rowData.id).find("td").css("background-color", "pink");
		        	//$("#" + rowData.id).find("td").css("background-color", "pink");
		            //$("#"+ids[i]+" td").css("color","red");
		        }
			}
        } */
    });
	//自适应调整
    setjqGridWidth('table');
}
//设置字体颜色
function addCellAttr(rowId, val, rawObject, cm, rdata) {
	if(rawObject.pay_in == '1'){
		return "style='color:red'";
	}
}

//保存-更新-删除|刷新页面数据
function query(){
	var startdate=$("#startdate").val();
	var enddate=$("#enddate").val();
	var goodsname=$("#goodsname").val();
	var paymentid=$("#paymentid").val();
	var pay_in=$("#pay_in").val();
	var classify=$("#classify").val();
	var ticketname=$("#ticketname").val();
	var code=$("#code").val();
	var status=$("#status").val();
	var username=$("#username").val();
	var postdata={'startdate':startdate,'enddate':enddate,'goodsname':goodsname,'customerid':'${user.customerid}','paymentid':paymentid,'pay_in':pay_in,'classify':classify,'ticketname':ticketname,'code':code,'username':username,'status':status};
    $("#table").jqGrid("setGridParam",{datatype:'json',postData:postdata}).trigger("reloadGrid");
    getSum(startdate,enddate,goodsname,paymentid,pay_in,classify,ticketname,code,status,username,'${user.customerid}');
//     $("#code").val("");
}
//重置
function rest(){
	$("#startdate").val('');
	$("#enddate").val('');
	$("#goodsname").val('');
	$("#paymentid").val('');
	$("#pay_in").val('');
	$("#classify").val('');
	$("#ticketname").val('');
	$("#code").val('');
	$("#status").val('');
	$("#username").val('');
}
//导出
function exports(){
	var startdate=$("#startdate").val();
	var enddate=$("#enddate").val();
	var goodsname=$("#goodsname").val();
	var paymentid=$("#paymentid").val();
	var pay_in=$("#pay_in").val();
	var classify=$("#classify").val();
	var ticketname=$("#ticketname").val();
	var code=$("#code").val();
	var status=$("#status").val();
	var username=$("#username").val();
	window.location.href="<%=ctx%>/report/recordExport.action?startdate="
				+ startdate + "&enddate=" + enddate + "&goodsname=" + goodsname
				+ "&paymentid=" + paymentid
				+ "&customerid=${user.customerid}&pay_in=" + pay_in
				+ "&classify=" + classify + "&ticketname=" + ticketname
				+ "&code=" + code + "&status=" + status + "&username="
				+ username;
	}
</script>