<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<input type="hidden" id="userids" name="userids" value="">
<div class="row">
    <div class="col-md-12">
		<div class="box box-default">
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
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">电话:</label>
                	<div class="col-xs-3" style="padding:5px 20px 0px 0px;">
                  		<input type="text" class="form-control" id="tel">
                	</div>
              	</div>
              	<div class="row">
                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">EMAIL:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="email">
                	</div>
<!--                 	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 2px;">商户名称:</label>
                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
                  		<input type="text" class="form-control" id="customername">
                	</div> -->
                	<div class="col-xs-8" style="padding:10px 20px 0px 20px;">
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
          			<c:if test="${fn:contains(button,'35511f43289d4a2280155ca3f574dd60')}">
          				<button type="button" class="btn btn-success btn-xs" onclick="useradd();"><i class="fa fa-plus"></i>添加</button>
          			</c:if>
          			<c:if test="${fn:contains(button,'47c0b839431d4b96805c67e7e4e56c8d')}">
          				<button type="button" class="btn btn-danger btn-xs" onclick="batchuserdel();"><i class="fa fa-times"></i>批量删除</button>
          			</c:if>
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
		url:'<%=ctx%>/user/getDataList',//这是Action的请求地址 
		postData:{'account':'','name':'','tel':'','email':'','customername':'','customerid':'${user.customerid}'},  
	    mtype:'POST',
	    height:height,
   	    autowidth:true,
        shrinkToFit:true,
        colNames:['id','customerid','账号','姓名','电话','EMAIL','商户','操作'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'customerid',index:'customerid',width:30,hidden:true,sortable:false},
            {name:'account',index:'account',width:60,sortable:false},  
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'tel',index:'tel',width:60,sortable:false},   
        	{name:'email',index:'email',width:60,sortable:false},  
        	{name:'customername',index:'customername',width:60,hidden:true,sortable:false},  
         	{name:'Edit',index:'Edit',width:150}
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
        	var userids=$("#userids").val();
            if(st){//选中
            	if(userids.indexOf(id)=="-1"){
            		userids+=id+",";
            	}
            }else{//取消
            	userids=userids.replace(id+",","");//用户删除id
            }
            $("#userids").val(userids);
      	},
        onSelectAll:function(ids,st){//全选数据过滤
      		if(ids.length>0){
	      		var userids=$("#userids").val();
				for(var i=0;i<ids.length;i++){
		            if(st){//选中
		            	if(userids.indexOf(ids[i])<0){//不包含
		            		userids+=ids[i]+",";
			            }
		            }else{//取消
			            if(userids.indexOf(ids[i])>=0){//包含
			            	userids=userids.replace(ids[i]+",","");//用户删除id
			            }
		            }
      		 	}
	            $("#userids").val(userids);
	      	}
      	},
        gridComplete:function(){
            var ids=jQuery("#table").jqGrid('getDataIDs');
            for(var i=0;i<ids.length;i++){
                var id = ids[i];
                var rowData=$("#table").getRowData(id);
                var editBtn="";//此处会将点击行id传给_edit(id) js函数
                var customerid=rowData.customerid;
                var des=rowData.des;
                var traderprice=rowData.traderprice;
                var oldcustomerid='${user.customerid}'
                var type='${user.type}';
                if(customerid==oldcustomerid||type==''){
	                <c:if test="${fn:contains(button,'ae87c55416a5467289ee68c2914981f5')}">
	                	editBtn+="<button type=\"button\" class=\"btn btn-warning btn-xs\" onclick=\"useredit(\'"+id+"\');\"><i class=\"fa fa-paste\"></i>修改</button>";
	                </c:if>
	                <c:if test="${fn:contains(button,'47c0b839431d4b96805c67e7e4e56c8d')}">
		                editBtn+="&nbsp;&nbsp;";
		                editBtn+="<button type=\"button\" class=\"btn btn-danger btn-xs\" onclick=\"userdel(\'"+id+"\');\"><i class=\"fa fa-times\"></i>删除</button>";
	               	</c:if>
	               	<c:if test="${fn:contains(button,'339ce4fb960f44feaecc443f33c30817')}">
		                editBtn+="&nbsp;&nbsp;";
		                editBtn+="<button type=\"button\" class=\"btn btn-success btn-xs\" onclick=\"resp(\'"+id+"\');\"><i class=\"fa fa-undo\"></i>密码重置</button>";
	                </c:if>
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
	var account=$("#account").val();
	var name=$("#name").val();
	var tel=$("#tel").val();
	var email=$("#email").val();
	var depid=$("#depid").val();
	//var customername=$("#customername").val();
	var customername='';
	var postdata={'account':account,'name':name,'tel':tel,'email':email,'depid':depid,'customername':customername,'customerid':'${user.customerid}','type':'${user.type}'};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//重置
function rest(){
	$("#account").val('');
	$("#name").val('');
	$("#tel").val('');
	$("#email").val('');
	//$("#customername").val('');
}
//重置密码
function resp(id){
	Dialog.confirm('确定要重置吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/user/respassword',
				data:{'id':id},
				dataType:'text',
				async:false,
				success:function(data){
					Dialog.alert("重置完毕！新密码为："+data);
				}
			});
		}
	);
}
//添加用户
function useradd(){
	var depid=$("#depid").val();
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 400;
	dialog.Title="添加用户";
	dialog.URL="<%=ctx%>/user/toadd?customerid=${user.customerid}&depid="+depid;
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
//修改用户
function useredit(id){
	var dialog=new Dialog();
	dialog.Width = 600;
	dialog.Height = 400;
	dialog.Title="修改用户";
	dialog.URL="<%=ctx%>/user/toedit?customerid=${user.customerid}&id="+id;
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
//批量删除
function batchuserdel(){
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
					url:'<%=ctx %>/user/batchdelete',
					data:{'ids':ids},
					dataType:'text',
					async:false,
					success:function(data){
						//刷新
						query();
					}
				});
			}
		);
	}else{
		Dialog.alert('请选择要删除的数据！');
	}
}
//单个删除
function userdel(id){
	Dialog.confirm('确定要删除吗？',
		function(){
			$.ajax({
				type:'post',
				url:'<%=ctx %>/user/delete',
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
</script>