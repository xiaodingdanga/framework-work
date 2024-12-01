/**
 * 去掉空格，回车
 */
function Trim(str){ 
    str=str.replace(/(^\s*)|(\s*$)/g, "");//去掉空格 
    str=str.replace(/[\n]/ig,'');//去掉回车
    return str;
}
/**
 * 获取屏幕高度
 * @returns {Number}
 */
function getheight(){
	var height=$(window).height();
	return height;
}
/**
 * 获取屏幕宽度
 * @returns {Number}
 */
function getwidth(){
	var width=$(window).width();
	return width;
}
/**
 * jqGrid自适应调整
 */
function setjqGridWidth(table){
	//表格自适应调整
    $(window).bind('resize', function () {
        var width = $('.jqGrid_wrapper').width();
        $('#'+table).setGridWidth(width);
    });
    //横滚动条
    jQuery("#table").closest(".ui-jqgrid-bdiv").css({ 'overflow-x' : 'auto' });
}
/**
 * 厂商自动补充
 */
function companyauto(){
	//查询厂商---自动完成初始化
	$("#companyname").autocomplete({
		source:function(request,response){
			var orgid=$("#orgid").val();
			$.ajax({
            	url:"../company/getCompany",
				dataType: "json",
				data:{'orgid':orgid,'name':request.term},
                success:function(data){
                	response($.map(data,function(item){
                    	return {id:item.id,label:item.label,value:item.value};
                    }));
				}
         	});
		},
		focus:function(e,ui){//选择时，焦点选中将把结果赋值给文本框---结果获取焦点事件
			$("#companyname").val(ui.item.label);
			$("#companyid").val(ui.item.id);
		},
		select:function(event,ui){//选中时,将把结果赋值给相应的文本框---选中事件
			$("#companyid").val(ui.item.id);
		},
		search:function(e,ui){//文本框输入--条件改变----查询事件
			$("#companyid").val('');
		},
		minLength:1, 
		autoFocus:false, 
		delay:100 
	});
}
/**
 * 供应商自动补充
 */
function supplierauto(){
	//查询供应商---自动完成初始化
	$("#suppliername").autocomplete({
		source:function(request,response){
			var orgid=$("#orgid").val();
			$.ajax({
            	url:"../company/getCompany",
				dataType: "json",
				data:{'orgid':orgid,'name':request.term},
                success:function(data){
                	response($.map(data,function(item){
                    	return {id:item.id,label:item.label,value:item.value};
                    }));
				}
         	});
		},
		focus:function(e,ui){//选择时，焦点选中将把结果赋值给文本框---结果获取焦点事件
			$("#suppliername").val(ui.item.label);
			$("#supplierid").val(ui.item.id);
		},
		select:function(event,ui){//选中时,将把结果赋值给相应的文本框---选中事件
			$("#supplierid").val(ui.item.id);
		},
		search:function(e,ui){//文本框输入--条件改变----查询事件
			$("#supplierid").val('');
		},
		minLength:1, 
		autoFocus:false, 
		delay:100 
	});
}
/**
 * 型号自动补充
 */
function modelauto(){
	//查询型号---自动完成初始化
	$("#modelname").autocomplete({
		source:function(request,response){
			var orgid=$("#orgid").val();
			var companyid=$("#companyid").val();
			$.ajax({
            	url:"../model/getModel",
				dataType: "json",
				data:{'orgid':orgid,'companyid':companyid,'name':request.term},
                success:function(data){
                	response($.map(data,function(item){
                    	return {id:item.id,label:item.label,value:item.value};
                    }));
				}
         	});
		},
		focus:function(e,ui){//选择时，焦点选中将把结果赋值给文本框---结果获取焦点事件
			$("#modelname").val(ui.item.label);
			$("#modelid").val(ui.item.id);
		},
		select:function(event,ui){//选中时,将把结果赋值给相应的文本框---选中事件
			$("#modelid").val(ui.item.id);
		},
		search:function(e,ui){//文本框输入--条件改变----查询事件
			$("#modelid").val('');
		},
		minLength:1, 
		autoFocus:false, 
		delay:100 
	});
}
//设置空值
function setnull(name){
	var id=$("#"+name+"id").val();
	if(id==""){
		$("#"+name+"id").val('');
		$("#"+name+"name").val('');
	}
}
/**
 * 用户信息自动补充
 */
function usepersonauto(){
	//查询用户信息---自动完成初始化
	$("#usepersonname").autocomplete({
		source:function(request,response){
			var orgid=$("#orgid").val();
			$.ajax({
            	url:"../user/getUser",
				dataType: "json",
				data:{'orgid':orgid,'name':request.term},
                success:function(data){
                	response($.map(data,function(item){
                    	return {id:item.id,label:item.label,value:item.value};
                    }));
				}
         	});
		},
		focus:function(e,ui){//选择时，焦点选中将把结果赋值给文本框---结果获取焦点事件
			$("#usepersonname").val(ui.item.label);
			$("#usepersonid").val(ui.item.id);
		},
		select:function(event,ui){//选中时,将把结果赋值给相应的文本框---选中事件
			$("#usepersonid").val(ui.item.id);
		},
		search:function(e,ui){//文本框输入--条件改变----查询事件
			$("#usepersonid").val('');
		},
		minLength:1, 
		autoFocus:false, 
		delay:100 
	});
}
/**
 * 用户信息自动补充
 */
function userauto(name){
	//查询用户信息---自动完成初始化
	$("#"+name+"name").autocomplete({
		source:function(request,response){
			var orgid=$("#orgid").val();
			$.ajax({
            	url:"../user/getUser",
				dataType: "json",
				data:{'orgid':orgid,'name':request.term},
                success:function(data){
                	response($.map(data,function(item){
                    	return {id:item.id,label:item.label,value:item.value};
                    }));
				}
         	});
		},
		focus:function(e,ui){//选择时，焦点选中将把结果赋值给文本框---结果获取焦点事件
			$("#"+name+"name").val(ui.item.label);
			$("#"+name+"id").val(ui.item.id);
		},
		select:function(event,ui){//选中时,将把结果赋值给相应的文本框---选中事件
			$("#"+name+"id").val(ui.item.id);
		},
		search:function(e,ui){//文本框输入--条件改变----查询事件
			$("#"+name+"id").val('');
		},
		minLength:1, 
		autoFocus:false, 
		delay:100 
	});
}
/**
 * 自动补全判断名称是否为空----为空ID清空
 */
function isnull(elename){
	var name=$("#"+elename+"name").val().trim();
	if(name==""){
		$("#"+elename+"id").val('');
	}
}
/**
 * 多选初始化
 */
function initmultiselect(){
	$("select[multiple=multiple]").multiselect({
        noneSelectedText: "",
        checkAllText:"全选",
        uncheckAllText:'全不选',
        selectedText:'#项被选中',
        selectedList:5
    });
}
/**
 * 区域初始化
 */
function initarea(){
	var orgid=$("#orgid").val();
	$.ajax({
		type:'post',
		url:'../area/getAreaList',
		data:{'orgid':orgid},
		dataType:'json',
		async:false,
		success:function(data){
			var html="<option value=\'\'></option>";
			for(var i=0;i<data.length;i++){
				var obj=data[i];
				html+="<option value='"+obj.id+"'>"+obj.name+"</option>";
			}
			$("#area").html(html);
		}
	});
}
/**
 * 楼宇初始化
 */
function initbuild(){
	var area=$("#area").val();
	var orgid=$("#orgid").val();
	$.ajax({
		type:'post',
		url:'../area/getBuildList',
		data:{'areaid':area,'orgid':orgid},
		dataType:'json',
		async:false,
		success:function(data){
			var html="<option value=\'\'></option>";
			if(area!=""){
				for(var i=0;i<data.length;i++){
					var obj=data[i];
					html+="<option value='"+obj.id+"'>"+obj.name+"</option>";
				}
			}
			$("#build").html(html);
		}
	});
}
/**
 * 房间初始化
 */
function initroom(){
	var area=$("#area").val();
	var build=$("#build").val();
	var orgid=$("#orgid").val();
	$.ajax({
		type:'post',
		url:'../area/getRoomList',
		data:{'areaid':area,'buildid':build,'orgid':orgid},
		dataType:'json',
		async:false,
		success:function(data){
			var html="<option value=\'\'></option>";
			if(area!=""&&build!=""){
				for(var i=0;i<data.length;i++){
					var obj=data[i];
					html+="<option value='"+obj.id+"'>"+obj.name+"</option>";
				}
			}
			$("#room").html(html);
		}
	});
}
/**
 * 资产添加--表单验证
 */
function validate(name,type,code,isnull){
	var error="";
	switch(type){
		case "1"://文本
			var val=$("#"+code).val().trim();
			if(code=="code"){//资产编号
				if(isnull=="1"){
					if(val==""){
						error+="必填！";
					}
				}
				if(val!=""){
					var id=$("#id").val().trim();
					$.ajax({
						type:'post',
						url:'../assets/checkcode',
						data:{"id":id,"code":val},
						dataType:'text',
						async:false,
						success:function(data){
							if(data=="false"){
								error+="重复！";
							}
						}
					});
				}
				if(error!=""){
					error=name+":"+error+"<br>";
				}
			}else{//文本框
				if(isnull=="1"){
					if(val==""){
						error=name+":必填！<br>";
					}
				}
			}
			break;
		case "2"://数字
			var val=$("#"+code).val().trim();
			if(isnull=="1"){//必填
				if(val==""){
					error+="必填！";
				}
			}
			var regular=/^\d+$/;//正整数
			if(val!=""&&!regular.exec(val)){
				error+="请填写正整数！";
			}
			if(error!=""){
				error=name+":"+error+"<br>";
			}
			break;
		case "3"://货币
			var val=$("#"+code).val().trim();
			if(isnull=="1"){//必填
				if(val==""){
					error+="必填！";
				}
			}
			var regular=/^\d+(?:\.\d{0,2})?$/;//数字，保留两位小数
			if(val!=""&&!regular.exec(val)){
				error+="请填写数字，并保留两位小数！";
			}
			if(error!=""){
				error=name+":"+error+"<br>";
			}
			break;
		case "4"://日期
			var val=$("#"+code).val().trim();
			if(isnull=="1"){//必填
				if(val==""){
					error=name+":必填！<br>";
				}
			}			
			break;
		case "5"://单选
			var val=$("#"+code).val().trim();
			if(isnull=="1"){//必填
				if(val==""){
					error=name+":必选！<br>";
				}
			}
			break;
		case "6"://多选
			var val=$("#"+code).val();
			if(isnull=="1"){//必填
				if(val==""){
					error=name+":必选！<br>";
				}
			}
			break;
		case "7"://资产类别
			var val=$("#"+code+"id").val();
			if(isnull=="1"){//必填
				if(val==""||val=="0"){
					error=name+":必选！<br>";
				}
			}
			break;
		case "8"://资产状态
			var val=$("#"+code).val();
			if(isnull=="1"){//必填
				if(val==""){
					error=name+":必选！<br>";
				}
			}
			break;
		case "9"://厂商
			break;
		case "10"://型号
			break;
		case "11"://用户信息
			break;
		case "12"://部门
			break;
		case "13"://组织机构
			var val=$("#"+code).val();
			if(isnull=="1"){//必填
				if(val==""){
					error=name+":必选！<br>";
				}
			}
			break;
		case "14"://区域
			break;
		case "15"://楼宇
			break;
		case "16"://房间
			break;
	}
	return error;
}
/**
 * 数据获取
 */
function getval(type,code){
	var value="";
	switch(type){
		case "1"://文本
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "2"://数字
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "3"://货币
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "4"://日期
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "5"://单选
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "6"://多选
			var val=$("#"+code).val();
			if(val==null){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
		case "7"://资产类别
			var val=$("#"+code+"id").val().trim();
			if(val=="0"){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
		case "8"://资产状态
			var val=$("#"+code).val().trim();
			value="'"+code+"':'"+val+"',";
			break;
		case "9"://厂商
			var val=$("#"+code+"id").val().trim();
			var name=$("#"+code+"name").val().trim();
			value="'"+code+"':'"+val+"','"+code+"name':'"+name+"',";
			break;
		case "10"://型号
			var val=$("#"+code+"id").val().trim();
			var name=$("#"+code+"name").val().trim();
			value="'"+code+"':'"+val+"','"+code+"name':'"+name+"',";
			break;
		case "11"://用户信息
			var val=$("#"+code+"id").val().trim();
			var name=$("#"+code+"name").val().trim();
			value="'"+code+"':'"+val+"','"+code+"name':'"+name+"',";
			break;
		case "12"://部门
			var val=$("#"+code+"id").val().trim();
			if(val=="0"){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
		case "13"://组织机构
			var val=$("#"+code).val();
			value="'"+code+"':'"+val+"',";
			break;
		case "14"://区域
			var val=$("#"+code).val();
			if(val==null){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
		case "15"://楼宇
			var val=$("#"+code).val();
			if(val==null){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
		case "16"://房间
			var val=$("#"+code).val();
			if(val==null){
				val="";
			}
			value="'"+code+"':'"+val+"',";
			break;
	}
	return value;
}