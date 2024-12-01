<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.baidu.ueditor.ActionEnter"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

    request.setCharacterEncoding( "utf-8" );
	response.setHeader("Content-Type" , "text/html");
	
	String rootPath = application.getRealPath( "/" );
	 System.out.println("555555555555========="+rootPath);
	 rootPath = rootPath+"/static/js/UEditor/jsp/";
	 System.out.println("66666666666========="+rootPath);
	out.write( new ActionEnter( request, rootPath ).exec() );
	
%>