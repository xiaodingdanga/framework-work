<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<div class="nav-tabs-custom">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#menu" data-toggle="tab">菜单权限</a></li>
				<li><a href="#user" data-toggle="tab">用户权限</a></li>
<!-- 				<li><a href="#data" data-toggle="tab">数据权限</a></li> -->
            </ul>
            <div class="tab-content">
              	<div class="tab-pane active" id="menu">
              		<div class="pull-right">
              			<button type="button" class="btn btn-success btn-xs" onclick="savesetpermission();">保存菜单权限</button>
              		</div>
					<br><br>
           			<div class="box-body">
           				<table class="table table-striped" style="border:1px solid #B9B4B4;">
             				<thead>
             					<tr>
             						<th align="center" width="30%" style="text-align:center;border-bottom:1px solid #B9B4B4;border-right:1px solid #B9B4B4;">
             							<input type="checkbox" id="menuid" name="menucheckall" onclick="checkallmenu();" title="菜单全选">菜单
             						</th>
             						<th align="center" width="5%" style="text-align:center;border-bottom:1px solid #B9B4B4;border-right:1px solid #B9B4B4;">
             							<input type="checkbox" id="buttonid" name="buttoncheckall" onclick="checkallbutton();" title="按钮全选">
             						</th>
             						<th align="center" width="70%" style="text-align:center;border-bottom:1px solid #B9B4B4;">
             							按钮
             						</th>
             						
             					</tr>
             				</thead>
             				<tbody>
             					<c:forEach items="${menulist}" var="firstlist">
	             					<tr style="background-color:#FFFFFF;">
	             						<td style="padding-left:20px;border-right:1px solid #B9B4B4;">
	             							<input type="checkbox" id="${firstlist.menu.id}" name="menucheck" value="${firstlist.menu.id}" onclick="checkmenu('${firstlist.menu.id}','${firstlist.menu.id}');">:${firstlist.menu.name}
	             						</td>
	             						<td align="center" style="border-right:1px solid #B9B4B4;">
	             							<input type="checkbox" id="${firstlist.menu.id}button" name="buttoncheck" title="菜单按钮全选" onclick="checkbutton('${firstlist.menu.id}');">
	             						</td>
	             						<td>
	             							<c:forEach items="${firstlist.btn}" var="firstbtn">
	             								<input type="checkbox" id="${firstbtn.id}" name="${firstlist.menu.id}">:${firstbtn.name}<span style="padding-left:10px"></span>
	             							</c:forEach>
	             						</td>
	             					</tr>
	             					<c:forEach items="${firstlist.menulist}" var="secondlist">
		             					<tr style="background-color:#FFFFFF;">
		             						<td style="padding-left:40px;border-right:1px solid #B9B4B4;">
		             							<input type="checkbox" id="${secondlist.menu.id}" name="menucheck" value="${firstlist.menu.id}-${secondlist.menu.id}" onclick="checkmenu('${secondlist.menu.id}','${firstlist.menu.id}-${secondlist.menu.id}');">:${secondlist.menu.name}
		             						</td>
		             						<td align="center" style="border-right:1px solid #B9B4B4;">
		             							<input type="checkbox" id="${secondlist.menu.id}button" name="buttoncheck" onclick="checkbutton('${secondlist.menu.id}');" title="菜单按钮全选">
		             						</td>
		             						<td>
		             							<c:forEach items="${secondlist.btn}" var="secondbtn">
		             								<input type="checkbox" id="${secondbtn.id}" name="${secondlist.menu.id}">:${secondbtn.name}<span style="padding-left:10px"></span>
		             							</c:forEach>
		             						</td>
		             					</tr>
		             					<c:forEach items="${secondlist.menulist}" var="threelist">
			             					<tr style="background-color:#FFFFFF;">
			             						<td style="padding-left:60px;border-right:1px solid #B9B4B4;">
			             							<input type="checkbox" id="${threelist.menu.id}" name="menucheck" value="${firstlist.menu.id}-${secondlist.menu.id}-${threelist.menu.id}" onclick="checkmenu('${threelist.menu.id}','${firstlist.menu.id}-${secondlist.menu.id}-${threelist.menu.id}');">:${threelist.menu.name}
			             						</td>
			             						<td align="center" style="border-right:1px solid #B9B4B4;">
			             							<input type="checkbox" id="${threelist.menu.id}button" name="buttoncheck" onclick="checkbutton('${threelist.menu.id}');" title="菜单按钮全选">
			             						</td>
			             						<td>
			             							<c:forEach items="${threelist.btn}" var="threebtn">
			             								<input type="checkbox" id="${threebtn.id}" name="${threelist.menu.id}">:${threebtn.name}
			             							</c:forEach>
			             						</td>
			             					</tr>
			             				</c:forEach>
	             					</c:forEach>
	             				</c:forEach>
             				</tbody>
           				</table>
           			</div>
				</div>
              	<div class="tab-pane" id="user">
              		<div class="pull-right">
              			<button type="button" class="btn btn-success btn-xs" onclick="savesetuser();">保存用户权限</button>
              		</div>
              		<br>
              		<div class="box-body">
              			<div class="row">
              				<label class="col-xs-1 control-label" style="padding:30px 0px 0px 0px;">授权用户:</label>
		                	<div class="col-xs-11" style="padding:5px 0px 0px 0px;">
		                		<input type="hidden" id="userids" style="width:500px;" value="${userid}">
		                		<textarea class="form-control" rows="3" id="usernames" name="usernames" readonly>${username}</textarea>
		                	</div>
              			</div>
              		
              			<div class="row">
		                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">账号:</label>
		                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
		                  		<input type="text" class="form-control" id="account">
		                	</div>
		                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 20px;">姓名:</label>
		                	<div class="col-xs-3" style="padding:5px 0px 0px 0px;">
		                  		<input type="text" class="form-control" id="name">
		                	</div>
<!-- 		                	<label class="col-xs-1 control-label" style="padding:10px 0px 0px 0px;">所属部门:</label> -->
<!-- 							<div class="col-xs-3" style="padding:5px 0px 0px 0px;" onclick="getdeptree();"> -->
<!-- 								<input type="hidden" id="depid" name="depid" value=""> -->
<!-- 								<input type="text" class="form-control" id="depname" name="depname" readonly style="cursor:pointer;" placeholder="所属部门" value=""> -->
<!-- 								<span class="glyphicon glyphicon-search form-control-feedback" style="padding:5px 0px 0px 0px;"></span> -->
<!-- 			               	</div> -->
		              	</div>
           			</div>
           			<div class="box-footer">
		          		<div class="pull-right">
		          			<button type="button" class="btn btn-primary btn-sm" onclick="query();"><i class="fa fa-search"></i>查询</button>
		      				<button type="button" class="btn btn-primary btn-sm" onclick="rest();"><i class="fa fa-eraser"></i>重置</button>
		          		</div>
		            </div>
		            <div class="box-body" id="tabbody">
		        		<!-- 数据start -->
		                <div class="jqGrid_wrapper">
		                 	<table id="table"></table>
		                 	<div id="pager"></div>
		                </div>
		                <!-- 数据end -->
		        	</div>
              	</div>
<!--               	<div class="tab-pane" id="data"> -->
<!--               		<div class="pull-right"> -->
<!--               			<button type="button" class="btn btn-success btn-xs" onclick="savesetdata();">保存数据权限</button> -->
<!--               		</div> -->
<!--               		<br><br> -->
<!--               		<div class="box-body"> -->
<!-- 						<input type="radio" id="datatype0" name="datatype" value="0">：所有数据&nbsp;&nbsp; -->
<!-- 						<input type="radio" id="datatype1" name="datatype" value="1">：部门数据&nbsp;&nbsp; -->
<!-- 						<input type="radio" id="datatype2" name="datatype" value="2" checked>：个人数据&nbsp;&nbsp; -->
<!--            			</div> -->
<!--               	</div> -->
            </div>
		</div>
	</div>
</div>
<script>
//页面初始化
$(window).load(function(){
	//菜单权限初始化
	<c:forEach items="${permlist}" var="list">
		//菜单初始化选中
		var menuid="${list.menuid}";
		$("#"+menuid).prop("checked",true);
		//按钮初始化选中
		var buttonstr="${list.button}";
		if(buttonstr!=""){
			var buttons=buttonstr.split(",");
			for(var i=0;i<buttons.length;i++){
				var buttonid=buttons[i];
				$("#"+buttonid).prop("checked",true);
			}
		}
	</c:forEach>
	//初始化jqGrid--用户
	init(260);
	//数据权限初始化
	$("#datatype${rolemap.data}").attr("checked",true);
});
//初始化jqGrid--用户
function init(height){
	//AJAX请求列表数据
    jQuery("#table").jqGrid({
    	//caption:'',
		datatype:'json',//将这里改为使用JSON数据 
		url:'<%=ctx%>/user/getDataLists',//这是Action的请求地址 
		postData:{'account':'','name':'','tel':'','email':'','depid':'','customerid':'${user.customerid}','type':'${user.type}'},  
	    mtype:'POST',   
	    height:height,
	    width:960,
   	    autowidth:false,
        shrinkToFit:true,
        colNames:['id','账号','姓名','电话','EMAIL','所属部门'],//列名
        colModel:[//列对应的字段
            {name:'id',index:'id',width:30,hidden:true,sortable:false},
            {name:'account',index:'account',width:60,sortable:false},  
        	{name:'name',index:'name',width:60,sortable:false},   
        	{name:'tel',index:'tel',width:60,sortable:false},   
        	{name:'email',index:'email',width:60,sortable:false},  
        	{name:'deps',index:'deps',width:60,sortable:false}
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
        	var usernames=$("#usernames").val();
        	
        	var rowData=$("#table").getRowData(id);
        	var name=rowData.name;
            if(st){//选中
            	userids+=id+",";
            	usernames+=name+",";
            }else{//取消
            	userids=userids.replace(id+",","");//用户删除id
            	usernames=usernames.replace(name+",","");
            }
            $("#userids").val(userids);
            $("#usernames").val(usernames);
      	},
      	onSelectAll:function(ids,st){//全选数据过滤
      		if(ids.length>0){
	      		var userids=$("#userids").val();
	      		var usernames=$("#usernames").val();
				for(var i=0;i<ids.length;i++){
					var rowData=$("#table").getRowData(ids[i]);
                	var name=rowData.name;
		            if(st){//选中
		            	if(userids.indexOf(ids[i])<0){//不包含
			            	userids+=ids[i]+",";
			            	usernames+=name+",";
			            }
		            }else{//取消
			            if(userids.indexOf(ids[i])>=0){//包含
			            	userids=userids.replace(ids[i]+",","");//用户删除id
			            	usernames=usernames.replace(name+",","");
			            }
		            }
      		 	}
	            $("#userids").val(userids);
	            $("#usernames").val(usernames);
	      	}
      	},
        gridComplete:function(){//初始化表格数据选中
        	var userids=$("#userids").val();//选择用户
      		if(userids!=""){
      			userids=userids.substring(0,userids.length-1);
	      		var userid=userids.split(",");
	      		for(var i=0;i<userid.length;i++){
	      			$("#table").setSelection(userid[i],false);
	      		}
      		}
		} 
    });
	//自适应调整
    setjqGridWidth('table');
}
//刷新页面数据--用户
function query(){
	var account=$("#account").val();
	var name=$("#name").val();
	var depid=$("#depid").val();
	var postdata={'account':account,'name':name,'tel':'','email':'','depid':depid,'customerid':'${user.customerid}','type':'${user.type}'};
    $("#table").jqGrid("setGridParam",{postData:postdata}).trigger("reloadGrid");
}
//菜单全选
function checkallmenu(){
	var check=$("#menuid").is(":checked");
	$('input[type=checkbox][name=menucheck]').prop("checked",check);   
}
//按钮全选
function checkallbutton(){
	var check=$("#buttonid").is(":checked");
	$('input[type=checkbox][name=buttoncheck]').prop("checked",check);
	$("input[type=checkbox][name=buttoncheck]").each(function(){
		var id=this.id;
		id=id.replace("button","");
		checkbutton(id);
	});
}
//单行菜单--按钮全选
function checkbutton(menuid){
	var check=$("#"+menuid+"button").is(":checked");
	$('input[type=checkbox][name='+menuid+']').prop("checked",check);
}
//点击菜单--父子级选取
function checkmenu(id,menuids){
	var check=$("#"+id).is(":checked");
// 	if(check){
// 		var menuid=menuids.split("-");
// 		for(var i=0;i<menuid.length;i++){
// 			$('#'+menuid[i]).prop("checked",true);
// 		}
		$("input[type=checkbox][name=menucheck]").each(function(){
			var value=$(this).val();
			if(value.indexOf(menuids)>=0){
				$(this).prop("checked",check);
			}
		});
// 	}
}
//菜单按钮权限保存
function savesetpermission(){
	var value="";
	$("input[type=checkbox][name=menucheck]:checked").each(function(){
		var menuid=this.id;
		var menuidbuttonid=menuid+":";
			var buttonids="";
			$("input[type=checkbox][name="+menuid+"]:checked").each(function(){
				buttonids+=this.id+",";
			});
			menuidbuttonid+=buttonids;
			value+=menuidbuttonid+";";
	});
	var roleid="${valmap.id}";
	$.ajax({
		type:'post',
		url:'<%=ctx %>/permission/savesetpermission',
		data:{'roleid':roleid,'str':value},
		dataType:'text',
		async:false,
		success:function(data){
			Dialog.alert("保存成功！");
		}
	});
}
//数据权限保存
function savesetdata(){
	var data=$("input[type=radio][name=datatype]:checked").val();
	var roleid="${valmap.id}";
	$.ajax({
		type:'post',
		url:'<%=ctx %>/permission/datasave',
		data:{'roleid':roleid,'data':data},
		dataType:'text',
		async:false,
		success:function(data){
			Dialog.alert("保存成功！");
		}
	});
}
//获取部门树
function getdeptree(){
	var dialog=new Dialog();
	dialog.Width = 400;
	dialog.Height = 300;
	dialog.Title="部门树";
	dialog.URL="<%=ctx%>/tree/deptree";
	dialog.CancelEvent=function(pid,pname){
		$("#depid").val(pid);
		$("#depname").val(pname);
		dialog.close();
	};
	dialog.show();
}
//重置
function rest(){
	$("#account").val('');
	$("#name").val('');
	$("#depid").val('');
	$("#depname").val('')
}
//保存用户权限
function savesetuser(){
	var userids=$("#userids").val();
	var roleid="${valmap.id}";
	$.ajax({
		type:'post',
		url:'<%=ctx %>/permission/usersave',
		data:{'roleid':roleid,'userids':userids},
		dataType:'text',
		async:false,
		success:function(data){
			Dialog.alert("保存成功！");
		}
	});
}
</script>