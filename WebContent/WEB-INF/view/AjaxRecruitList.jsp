<%@page import="com.bcle.DTO.Recruit"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<%

   String pageIndexList = (String)request.getAttribute("pageIndexList");
   
   ArrayList<Recruit> lists = (ArrayList)request.getAttribute("lists");

   String result = "";
   
   // [{"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
   //, {"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
   //, {"firewood":"5", "camperId":"", "createDate":"", "checkInDate":"", "content":"" }
   //, {pageIndexList:""}]
   
   
         
   for(Recruit r : lists)
   {
      StringBuffer sb = new StringBuffer();
      
      sb.append("{\"rnum\":\"" + r.getRnum() + "\"");
      sb.append(",\"title\":\"" + r.getTitle() + "\"");
      sb.append(",\"nickname\":\"" + r.getNickname() + "\"");
      sb.append(",\"bdate\":\"" + r.getBdate() + "\"");
      sb.append(",\"cnt\":\"" + r.getCnt() + "\"");
      sb.append(",\"b_id\":\"" + r.getB_id() + "\"},");
      
   
      result += sb.toString();
   }
   
   result += "{\"pageIndexList\":\"" + pageIndexList + "\"}" ;
   
   result = "[" + result + "]";
   
   out.println(result);
   
%>