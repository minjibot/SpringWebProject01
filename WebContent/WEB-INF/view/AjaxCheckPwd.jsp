<%@page import="com.bcle.DTO.Bee"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%

	int check = (Integer)request.getAttribute("check");
	
	String result = "";
			
	StringBuffer sb = new StringBuffer();
	//System.out.println("test"+check);
	sb.append("{\"check\":\"" + check + "\"}");
	
	
	result += sb.toString();
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>