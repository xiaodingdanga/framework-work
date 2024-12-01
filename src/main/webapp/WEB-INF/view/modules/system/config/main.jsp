<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
		<div class="box box-default">
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
	$("#tabbody").css("height",getheight()-170);
	//初始化jqGrid--系统配置
	init(getheight()-260);
});
//初始化jqGrid--系统配置
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({ 
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/config/getDataList',//这是Action的请求地址 
		postData:{},  
	    mtype:'POST',   
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','配置名称','编码','值','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'code',index:'code',width:60,sortable:false},   
        	{name:'value',index:'value',width:150,sortable:false},   
         	{name:'Edit',index:'Edit',width:80}
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
                var editBtn="";
                <c:if test="${fn:contains(button,'e0389b13fa55422fa6af8b11ba3a9f3f')}">
                editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" data-toggle=\"modal\" href=\"#modal-update\" onclick=\"configedit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
            	</c:if>
                jQuery("#table").jqGrid('setRowData',ids[i],{Edit:editBtn});
            }
		} 
    });
	//自适应调整
    setjqGridWidth('table');
}
//编辑角色
function configedit(id){
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 300;
	dialog.Title="修改配置";
	dialog.URL="<%=ctx%>/config/toedit?id="+id;
	dialog.OKEvent=function(){
		dialog.innerFrame.contentWindow.save();
		dialog.close();
		//刷新列表
	    $("#table").jqGrid("setGridParam").trigger("reloadGrid");
	};
	dialog.CancelEvent=function(){
		dialog.close();
	};
	dialog.show();
	dialog.okButton.value="保存";
}
</script>