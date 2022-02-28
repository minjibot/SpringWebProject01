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
      sb.append(",\"city\":\"" + c.getCity() + "\"");
      sb.append(",\"local\":\"" + c.getLocal() + "\"");
      sb.append(",\"count\":\"" + c.getCount() + "\"");
      sb.append(",\"max\":\"" + c.getMax() + "\"");
      sb.append(",\"agelimit_id\":\"" + c.getAgelimit_id() + "\"");
      sb.append(",\"limit_id\":\"" + c.getLimit_id() + "\"");
      sb.append(",\"min_age\":\"" + c.getMin_age() + "\"");
      sb.append(",\"max_age\":\"" + c.getMax_age() + "\"");
      sb.append(",\"bdate\":\"" + c.getBdate() + "\"},");
      
   
      result += sb.toString();
   }
   
   result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
   
   result = "[" + result + "]";
   
   out.println(result);
   
%>