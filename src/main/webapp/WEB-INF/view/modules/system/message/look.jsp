<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<div class="row">
	<div class="col-md-12">
		<form class="form-horizontal" id="form">
			<div class="box-body">
	            <div class="form-group">
					<label class="col-xs-2 control-label" style="padding:5px 0px 0px 0px;">标题:</label>
					<div class="col-xs-3" style="padding:5px 0px 0px 10px;">${valmap.title}</div>
	               	<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;">是否公开:</label>
					<div class="col-xs-3" style="padding:5px 0px 0px 10px;">
						<c:if test="${valmap.flag=='0'}">公开</c:if>
						<c:if test="${valmap.flag=='1'}">不公开</c:if>
	               	</div>
	               	<label class="col-xs-1 control-label" style="padding:5px 0px 0px 0px;">消息类型:</label>
					<div class="col-xs-2" style="padding:5px 0px 0px 10px;">
						<c:if test="${valmap.type=='0'}">系统消息</c:if>
						<c:if test="${valmap.type=='1'}">个人消息</c:if>
	               	</div>
	            </div>
<%-- 	            <c:if test="${valmap.type=='1' }"> --%>
<!-- 		            <div class="form-group has-feedback"> -->
<!-- 						<label class="col-xs-2 control-label" style="padding:5px 0px 0px 8px;">接收人:</label> -->
<!-- 						<div class="col-xs-10" style="padding:5px 0px 0px 10px;"> -->
<%-- 							<c:forEach items="${customerlist}" var="map"> --%>
<%-- 								${map.name}, --%>
<%-- 							</c:forEach> --%>
<!-- 		               	</div> -->
<!-- 		            </div> -->
<%-- 	            </c:if> --%>
				<div class="form-group">
					<label class="col-xs-2 control-label" style="padding:5px 0px 0px 0px;">通知内容:</label>
					<div class="col-xs-10" style="padding:5px 0px 0px 10px;">${valmap.content}</div>
	            </div>
	       	</div>
       	</form>
    </div>
</div>