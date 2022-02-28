<%@page import="com.bcle.DTO.Club"%>
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
	
	ArrayList<Club> lists = (ArrayList)request.getAttribute("lists");

	String result = "";
			
	for(Club dto : lists)
	{
		StringBuffer sb = new StringBuffer();
		//System.out.println(bee.getBeeId());
		sb.append("{\"num\":\"" + dto.getNum() + "\"");
		sb.append(",\"title\":\"" + dto.getTitle() + "\"");
		sb.append(",\"s_cat\":\"" + dto.getS_cat() + "\"");
		sb.append(",\"local\":\"" + dto.getLocal() + "\"");
		sb.append(",\"count\":\"" + dto.getCount() + "\"");
		sb.append(",\"bdate\":\"" + dto.getBdate() + "\"},");
		
		result += sb.toString();
	}
	
	result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>