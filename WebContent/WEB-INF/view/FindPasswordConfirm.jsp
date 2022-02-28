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
<title>FindPasswordConfirm.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript">

$(document).ready(function()
{
   
   $("#pwd1").focusout(function()
   {
      $("#checkpwd1").html('');
      
      if($("#pwd1").val()=="")
        {
          $("#checkpwd1").html('');
        }
      else if(!isPassword($("#pwd1").val()))
      {
         $("#checkpwd1").html('특수문자, 영문자 포함 8~16개를 입력해주세요.');
           $("#checkpwd1").css('color', 'red');
           $("#pwd1").val("");
      }
   });
   
   $("#pwd2").focusout(function()
   {
      $("#checkpwd2").html('');
      
      if($("#pwd2").val()=="")
        {
          $("#checkpwd2").html('');
        }
      else if(!isPassword($("#pwd2").val()))
      {
         $("#checkpwd2").html('특수문자, 영문자 포함 8~16개를 입력해주세요.');
           $("#checkpwd2").css('color', 'red');
           $("#pwd2").val("");
      }
   });
   
   $("#submitBtn").click(function()
      {
      
         if ($("#pwd1").val().length == 0)
         {
            alert("비밀번호를 등록해주세요.");
            $("#pwd1").focus();
            return false;
         }
         if ($("#pwd2").val().length == 0)
         {
            alert("비밀번호 재입력을 입력해주세요.");
            $("#pwd2").focus();
            return false;
         }
         
         if($("#pwd1").val()!=$("#pwd2").val())
         {
            alert("입력한 비밀번호가 일치하지 않습니다.")
            $("#pwd1").val("");
            $("#pwd2").val("");
            $("#pwd1").focus();
            return false;
         }
         
         $("#resetpasswordform").submit();
      });
})
   

</script>
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
   <p class="title">비밀번호 재설정</p>
</div>

<!-- 컨텐츠영역 -->

<div class="outer">
   <div class="inner">
   <div class="row register-form" style="text-align:center;">
      <form action="resetconfirm.action" method="post" id="resetpasswordform">
         <input type="hidden" value="${userId }" name="userId">
            <div class="form-group col-md-12 col-sm-12">
               <span style="color:red;">${userId }</span> 님의 비밀번호를 재설정 해주세요.<br> 
            </div>
         <br>
         <div style="border: 1px solid #105B63; padding: 20px; border-radius: 5px; width:450px;">
            비밀번호 입력 &nbsp;&nbsp;  <input type="password" id="pwd1" name="pwd1" style="border:1px solid black; padding:5px; margin:3px; border-radius:10px;">
            <br><span id="checkpwd1"></span>
            <br> 
            비밀번호 재입력   <input type="password" id="pwd2" name="pwd2" style="border:1px solid black; padding:5px; margin:3px; border-radius:10px;">
            <br><span id="checkpwd2"></span>
            <br> 
            <input type="button" value="홈으로" class="btn" 
            onclick="javascript:location.href='<%=cp%>/mainpage.action'">      
            <input type="submit" value="확인" id="submitBtn" class="btn">
         </div>
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