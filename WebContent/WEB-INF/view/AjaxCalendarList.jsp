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
	
	ArrayList<Bee> lists = (ArrayList)request.getAttribute("lists");

	String result = "";
			
	for(Bee bee : lists)
	{
		StringBuffer sb = new StringBuffer();
		//System.out.println(bee.getBeeId());
		sb.append("{\"beeId\":\"" + bee.getBeeId() + "\"");
		sb.append(",\"typeName\":\"" + bee.getTypeName() + "\"");
		sb.append(",\"title\":\"" + bee.getTitle() + "\"");
		sb.append(",\"content\":\"" + bee.getContent() + "\"");
		sb.append(",\"beeTime\":\"" + bee.getBeeTime() + "\"");
		sb.append(",\"min\":\"" + bee.getMin() + "\"");
		sb.append(",\"max\":\"" + bee.getMax() + "\"");
		sb.append(",\"fee\":\"" + bee.getFee() + "\"");
		sb.append(",\"beeDate\":\"" + bee.getBeeDate() + "\"");
		sb.append(",\"clubmemId\":\"" + bee.getClubmemId() + "\"");
		sb.append(",\"writer\":\"" + bee.getWriter() + "\"");
		sb.append(",\"nickName\":\"" + bee.getNickName() + "\"");
		sb.append(",\"reqCnt\":\"" + bee.getReqCnt() + "\"},");
		
		
		result += sb.toString();
	}
	
	result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
	
	result = "[" + result + "]";
	
	out.println(result);
	
%>