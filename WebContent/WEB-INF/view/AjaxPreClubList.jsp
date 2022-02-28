<%@page import="com.bcle.DTO.Club"%>
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
   
   
   for(Club c : lists)
   {
      StringBuffer sb = new StringBuffer();
      
      sb.append("{\"cid\":\"" + c.getCid() + "\"");
      sb.append(",\"title\":\"" + c.getTitle() + "\"");
      sb.append(",\"url\":\"" + c.getUrl() + "\"");
      sb.append(",\"day\":\"" + c.getDay() + "\"},");
      
   
      result += sb.toString();
   }
   
   result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
   
   result = "[" + result + "]";
   
   out.println(result);
   
%>