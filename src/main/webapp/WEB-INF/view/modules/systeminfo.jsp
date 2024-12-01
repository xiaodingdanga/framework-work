<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
    <div class="col-md-12">
   		<div class="box box-default">
        	<div class="box-body" id="tabbody" style="min-height:400px;">
                <table id="table" border="0" width="100%">
                	<tr>
                		<td colspan="2" align="center" style="font-size:50px;font-weight:bold;">系统信息</td>
                	</tr>
                	<tr>
                		<td colspan="2" align="center" ><hr></td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">授权单位:</td>
                		<td width="50%" style="padding-left:20px;">${info.name }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">系统名称:</td>
                		<td width="50%" style="padding-left:20px;">${info.product_name }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">系统版本:</td>
                		<td width="50%" style="padding-left:20px;">${info.version }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">注册文件类型:</td>
                		<td width="50%" style="padding-left:20px;">${info.type }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">注册计算机名称:</td>
                		<td width="50%" style="padding-left:20px;">${info.getLocalName }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">注册IP:</td>
                		<td width="50%" style="padding-left:20px;">${info.getLocalIp }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">注册MAC:</td>
                		<td width="50%" style="padding-left:20px;">${info.getLocalMac }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">注册时间:</td>
                		<td width="50%" style="padding-left:20px;">${info.starttime }</td>
                	</tr>
                	<tr style="height:30px;font-weight:bold;">
                		<td align="right" width="50%" style="padding-right:20px;">截止时间:</td>
                		<td width="50%" style="padding-left:20px;">${info.endtime }</td>
                	</tr>
                </table>
        	</div>
      	</div>
    </div>
</div>
<script>
$(window).load(function(){
	$("#tabbody").css("height",getheight()-170);
});
</script>
