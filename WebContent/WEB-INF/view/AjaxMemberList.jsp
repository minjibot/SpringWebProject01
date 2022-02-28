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

	String pageIndexList = (String)request.getAttribute("pageIndexList");
	
	ArrayList<MemberInfo> lists = (ArrayList)request.getAttribute("lists");

	String result = "";
			
	for(MemberInfo dto : lists)
	{
		StringBuffer sb = new StringBuffer();
		//System.out.println(bee.getBeeId());
		sb.append("{\"num\":\"" + dto.getNum() + "\"");
		sb.append(",\"userId\":\"" + dto.getUserId() + "\"");
		sb.append(",\"name\":\"" + dto.getName() + "\"");
		sb.append(",\"email\":\"" + dto.getEmail() + "\"");
		sb.append(",\"nickname\":\"" + dto.getNickname() + "\"");
		sb.append(",\"bdate\":\"" + dto.getBdate() + "\"");
		sb.append(",\"login_date\":\"" + dto.getLogin_date() + "\"},");
		
		result += sb.toString();
	}
	
	result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>