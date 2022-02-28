<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ResetConfirm.jsp</title>
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

<div class="outer">
   <div class="inner">
      <div class="row register-form" style="text-align:center;">
         <span style="color:red;">${userId } </span>님의 비밀번호가 변경되었습니다.
         <br><br>                  
         <input type="button" value="로그인" style="border:0;outline:0;" class="btn"
         onclick="javascript:location.href='<%=cp%>/loginpage.action'"></input>
         <input type="button" value="홈으로" style="border:0;outline:0;" class="btn"
         onclick="javascript:location.href='<%=cp%>/mainpage.action'"></input>
      </div>   
   </div>
</div>

    
</body>
</html>