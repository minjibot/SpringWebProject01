<%@page import="com.bcle.DTO.Bee"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<%
	int insert = (Integer)request.getAttribute("insert");
	
	String result = "";
			
	StringBuffer sb = new StringBuffer();

	sb.append("{\"insert\":\"" + insert + "\"}");
	
	result += sb.toString();
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>