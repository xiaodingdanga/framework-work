<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:write property="title"/></title>
    <jsp:include page="/WEB-INF/view/include/blankhead.jsp"/>
</head>
<body>
	<sitemesh:write property="body"/>
</body>
</html>
