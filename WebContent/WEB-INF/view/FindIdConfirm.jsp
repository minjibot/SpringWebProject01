<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FindIdConfirm.jsp</title>
<style>
.outer {
  display: flex;
  align-items: center; 
  flex-direction: row; 
  justify-content: center; 
}

.inner {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
}

</style>
</head>
<body>

<!-- nav 영역 -->
<div>
   <c:import url="subHeader.jsp"></c:import>
</div>
<div class="subheader">
      <p>B:CLE</p>
      <p class="title">아이디찾기</p>
   </div>

<!-- 컨텐츠영역 -->

<div class="outer">
   <div class="inner">
   <div class="row register-form">
      <form action="">
            <div style="height:auto; width:100%; border:1px solid black; padding:10px; border-radius:10px;" class="form-group col-md-12 col-sm-12">
               <c:forEach var="check" items="${checkId }" >
               고객님의 아이디 : <span style="color:red;">${check.userId}</span><br> 가입 날짜 : ${fn:substring(check.bdate, 0, 10)}
               </c:forEach>
            </div>
         <br>
         
         <input type="button" value="비밀번호찾기" class="btn"
         onclick="javascript:location.href='<%=cp%>/findingpassword.action'">      
         <input type="button" value="로그인" class="btn"
         onclick="javascript:location.href='<%=cp%>/loginpage.action'">
      </form>
   </div>   
   </div>
</div>
<%-- 
<div>
   <c:import url="footer.jsp"></c:import>
</div>
 --%>
</body>
</html>