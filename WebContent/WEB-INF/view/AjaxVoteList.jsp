<%@page import="com.bcle.DTO.Vote"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<%

   String pageIndexList = (String)request.getAttribute("pageIndexList");
   
   ArrayList<Vote> lists = (ArrayList)request.getAttribute("lists");

   String result = "";
   
   for(Vote vote : lists)
   {
      StringBuffer sb = new StringBuffer();
      //System.out.println(bee.getBeeId());
      sb.append("{\"num\":\"" + vote.getNum() + "\"");
      sb.append(",\"bId\":\"" + vote.getBid() + "\"");
      sb.append(",\"title\":\"" + vote.getTitle() + "\"");
      sb.append(",\"nickname\":\"" + vote.getNickname() + "\"");
      sb.append(",\"suspect\":\"" + vote.getSuspect() + "\"");
      sb.append(",\"bDate\":\"" + vote.getBdate() + "\"");
      sb.append(",\"cDate\":\"" + vote.getCdate() + "\"");
      sb.append(",\"cnt\":\"" + vote.getCnt() + "\"");
      sb.append(",\"type\":\"" + vote.getType() + "\"},");

      result += sb.toString();
   }
   
   result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
   
   result = "[" + result + "]";
   
   out.println(result);
   
   
%>