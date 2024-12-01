<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<form class="form-horizontal" id="form">
		<div class="box-body">
   			<div class="col-md-12" >
   		  		<div class="form-group">
					<div class="col-xs-12"  style="text-align:center"><h3>${valmap.title}</h3></div>
	            </div>
	            <div class="form-group">
					<div class="col-xs-12" >${valmap.content}</div>
	            </div>
            </div>
       	</div>
   	</form>
</div>