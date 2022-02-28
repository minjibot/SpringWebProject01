<%@page import="com.bcle.DTO.MemberInfo"%>
<%@page import="com.bcle.DTO.Bee"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<%
	ArrayList<MemberInfo> lists = (ArrayList)request.getAttribute("clubJoinList");

	String result = "";
			
	for(MemberInfo memberInfo : lists)
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append("{\"id\":\"" + memberInfo.getId() + "\"");
		sb.append(",\"nickname\":\"" + memberInfo.getNickname() + "\"");
		sb.append(",\"joinId\":\"" + memberInfo.getJoinId() + "\"},");
		
		
		result += sb.toString();
	}
	
	if(result.length() == 0)
		result = "[" + result + "]";
	else
		result = "[" + result.substring(0,result.length()-1) + "]";
	
	out.println(result);
%>