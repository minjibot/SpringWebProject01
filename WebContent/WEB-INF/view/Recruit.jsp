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
<title>Recuit.jsp</title>
<link rel="stylesheet" href="css/mainpage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- 부트스트랩 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">

.list-title{margin-top : 5vh;}

#contents {
   margin : 5vh 30vh 5vh 30vh;
   padding : 3%;
   border : 1px solid lightgray;
   border-radius : 20px;
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
   text-align: center;  
}

select {
   color:white;
   background : gray;
   border-radius: 5px;
   padding : 5px;
}

#contents input { border : 1px solid lightgray; margin-right : 0vh; height : 4vh; background-color: #f2f2f2;}
#contents p {margin-bottom : 3vh;}
.button_set {display : flex; margin-left : 45%;}
.button_set button {margin-right : 3vh;} 

textarea { border : 1px solid lightgray;}

</style>
</head>
<body>

<!-- 동아리 - 회의 - 모집 등록창 -->

<!-- nav 영역 -->
<div>
   <c:import url="nav.jsp"></c:import>
</div>

<section class="list-title">
         <div class="title">
            <h2>Recruit<span>.</span></h2>
            <p>동아리의 새로운 운영진이 되어보세요</p>
         </div>
      </section>

<div>
   <!-- 콘텐츠 영역 -->
   <div id="contents" style="margin-left: 30vh;">
      <h1 style="font-size: 20px;">모집 등록</h1>
      <br>
      <form action="recruitinsert.action" method="post">
   
         <!-- cid => 컨트롤러에서 cid와 세션id를 이용해서 clubmem_id 얻어내서 insert해야하기 때문에-->
            <input type="hidden" id="cid" name="cid" value="${cid}">
         <div>
         제목&nbsp;<input type="text" id="title" name="title" required="required" style="width: 300px;">
         </div><br>
         <div>
         모집 직위
         <select id="position_id" name="position_id" required="required">
            <option value="" >--선택--</option>
            <option value="3">스태프</option>
            <option value="2">총무</option>
            <option value="4">동아리장</option>
         </select><br><br>
         </div>
         <div>
         모집 내용
         <br> 
         <textarea rows="10" cols="60" id="content" name="content"></textarea>
         </div><br><br>
      
         <div class ="button_set">
            <button type="submit" class="btn btn-warning">등록</button>
            <button type="button" class="btn btn-secondary"
            onclick="location.href='recruitlist.action?cid=${cid}'">취소</button>
         </div>
      </form>
   </div>
   <%-- <!-- 풋터영역 -->
    <div>
         <c:import url="footer2.jsp"></c:import>
    </div> --%>
   
</div>

</body>
</html>