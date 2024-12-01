<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-2 control-label" style="padding:5px 0px 0px 30px;">选择商户:</label>
					<div class="col-xs-10">
	                   	<input type="hidden" id="customerids" value="${paramap.customerids}">
		                <textarea class="form-control" rows="2" id="customernames" name="customernames" readonly>${paramap.customernames}</textarea>
	               	</div>
	            </div>
	            <div class="form-group">
	            	<div class="col-xs-9" style="padding:5px 0px 0px 15px;">
                  		<input type="text" class="form-control" id="name" placeholder="姓名">
                	</div>
                	<div class="col-xs-3" style="padding:5px 0px 0px 10px;">
                		<button type="button" class="btn btn-primary btn-sm" onclick="query();"><i class="fa fa-search"></i>查询</button>
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
	init(260);
});
//初始化jqGrid--用户
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/message/DataLists',  //这是Action的请求地址 
		postData:{'name':''},  
	    mtype:'POST',   
	    height:height,
	    width:580,
   	    autowidth:false,
        shrinkToFit:true,
        colNames:['id','商户名称'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
        	{name:'customername',index:'customername',width:60,sortable:false},   
        ],
     	multiselect:true,//是否支持多选   
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
        onSelectRow:function(id,st){//id:选中行id,st:当前是否选中----单选赋值
        	var customerids=$("#customerids").val();
        	var customernames=$("#customernames").val();
        	
        	var rowData=$("#table").getRowData(id);
        	var name=rowData.customername;
            if(st){//选中
            	customerids+=id+",";
            	customernames+=name+",";
            }else{//取消
            	customerids=customerids.replace(id+",","");//用户删除id
            	customernames=customernames.replace(name+",","");
            }
            $("#customerids").val(customerids);
            $("#customernames").val(customernames);
      	},
      	onSelectAll:function(ids,st){//全选数据过滤
      		if(ids.length>0){
	      		var customerids=$("#customerids").val();
	      		var customernames=$("#customernames").val();
				for(var i=0;i<ids.length;i++){
					var rowData=$("#table").getRowData(ids[i]);
                	var name=rowData.customername;
		            if(st){//选中
		            	if(customerids.indexOf(ids[i])<0){//不包含
		            		customerids+=ids[i]+",";
		            		customernames+=name+",";
			            }
		            }else{//取消
			            if(customerids.indexOf(ids[i])>=0){//包含
			            	customerids=customerids.replace(ids[i]+",","");//用户删除id
			            	customernames=customernames.replace(name+",","");
			            }
		            }
      		 	}
	            $("#customerids").val(customerids);
	            $("#customernames").val(customernames);
	      	}
      	},
        gridComplete:function(){//初始化表格数据选中
        	var customerids=$("#customerids").val();//选择用户
      		if(customerids!=""){
      			customerids=customerids.substring(0,customerids.length-1);
	      		var customerid=customerids.split(",");
	      		for(var i=0;i<customerid.length;i++){
	      			$("#table").setSelection(customerid[i],false);
	      		}
      		}
		} 
    });
	//自适应调整
    setjqGridWidth('table');
}
//刷新页面数据--用户
function query(){
	var name=$("#name").val();
	var postdata={'name':name};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//获取customerid
function getcustomerid(){
	return $("#customerids").val();
}
//获取customername
function getcustomername(){
	return $("#customernames").val();
}
</script>