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
<title>FindId.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<style type="text/css">
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
<script type="text/javascript">
$(document).ready(function()   // 페이지가 로드됐을 때 제이쿼리 실행
{   

   $("#email").focusout(function()
   {
      $("#checkEmail").html('');
      
      if($("#email").val()=="")
        {
          $("#checkEmail").html('');
        }
      else if(!isValidEmail($("#email").val()))
      {
         //alert("test");
         $("#checkEmail").html('사용할 수 없는 이메일 형식입니다.');
           $("#checkEmail").css('color', 'red');
           $("#email").val("");
      }
      
   });
   
   $("#name").focusout(function()
   {
      $("#checkName").html('');
      if($("#name").val()=="")
        {
          $("#checkName").html('');
        }
      else if(!isValidKorean($("#name").val()))
      {
         $("#checkName").html('이름 형식에 맞지 않습니다.');
           $("#checkName").css('color', 'red');
           $("#name").val("");
      }
      
   });
   
   $("#submitBtn").click(function()
   {
      if ($("#name").val().length == 0)
      {
         alert("이름을 등록해주세요.");
         $("#name").focus();
         return false;
      }
      if ($("#email").val().length == 0)
      {
         alert("이메일을 입력해주세요.");
         $("#email").focus();
         return false;
      }
      
      $("#findIdForm").submit();
   });
   
});
</script>
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
      <c:if test="${!empty fail }">
         <span style="color:red; width:20px;">일치하는 아이디가 없습니다. 재입력해주세요.</span>
      </c:if>
      <form action="findidconfirm.action" method="post" id="findIdForm">
         <br>
         <div class="form-group col-md-12 col-sm-12">
         이름 <input style="width: 300px;" type="text" id="name" name="name" placeholder="이름 입력" required="required" class="form-control"/>
         <!-- <span id="err">이름을 입력해주세요.</span> -->
         <span id="checkName"></span>
         <br>
         </div>
         <div class="form-group col-md-12 col-sm-12">
         이메일 <input style="width: 300px;" type="email" id="email" name="email" placeholder="이메일 입력" required="required" class="form-control"/>
         <span id="checkEmail"></span>
         <br>
         </div>
         <!-- 
         이메일 <input type="text"  placeholder="이메일 입력">
         <span id="err">이메일을 입력해주세요.</span>
         <input type="button" value="발송"><br>
         이메일 인증 코드 <input type="text">
         <span id="err">인증코드가 일치하지 않습니다.</span>
         <input type="button" value="확인"><br><br>
         -->
         <input type="submit" value="아이디찾기" id="submitBtn" class="btn">
         <input type="button" value="취소" class="btn" 
         onclick="javascript:location.href='<%=cp%>/loginpage.action'">
      </form>
   </div>
</div>
<%-- 
<div>
   <c:import url="footer.jsp"></c:import>
</div>
 --%>
</body>
</html>