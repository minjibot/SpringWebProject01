<%@page import="com.bcle.DTO.Bee"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
${getCal}
<%-- <%

	ArrayList<Bee> lists = (ArrayList)request.getAttribute("getCal");
	
	String result = "";
			
	for(Bee bee : lists)
	{
		StringBuffer sb = new StringBuffer();
		//System.out.println(bee.getBeeId());
		sb.append("{\"beeId\":\"" + bee.getBeeId() + "\"");
		sb.append(",\"title\":\"" + bee.getTitle() + "\"");
		sb.append(",\"beeTime\":\"" + bee.getBeeTime() + "\"");
		sb.append(",\"cid\":\"" + bee.getCid() + "\"}");
		
		
		result += sb.toString();
	}
	result = "[" + result + "]";
	
	out.println(result);
%> --%>