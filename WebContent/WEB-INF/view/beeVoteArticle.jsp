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
<title>beeHelloCreated.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript">
   $(document).ready(function()
   {
      
      var diff;
      var percent;
      
      percent = parseInt($("#percent").val());
      diff = parseInt($("#ddate").val());
            
      $("#agree").hide();
      $("#disagree").hide();
      //$("#eliminated").hide();
      //$("#demotion").hide();
      //$("#closing").hide();
      
      if(diff>4)
      {

         $("#comp").html("투표 기간이 종료되었습니다. ");
         
         if(percent>=70){
         
         if($("#type").val()=="강퇴"){
            $("#eliminated").show();
         }
         else if($("#type").val()=="강등"){
            $("#demotion").show();
         }
         else
            $("#closing").show();
         }
         
      }
      else
      {
         $("#agree").show();
         $("#disagree").show();
      }
         
   
      
   });
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<style type="text/css">
body
{
   text-align: center;
}
#bbs
{
   padding-left: 28%;
   padding-top: 10%;
   text-align: center;
}
#bbsCreated
{
   padding-left: 30px;
}
</style>
</head>
<body>
<!--  
   beeVoteCreated.jsp
   - 동아리 내 게시판 > 투표 > 글쓰기
-->

<div id="bbs">

     <input type="hidden" value="${list.ddate }" id="ddate">

      <div id="bbsCreated" style="width: 60%; border: 5px solid gray; border-radius: 10px; padding: 30px 40px 30px 30px;">
         <div class="bbsCreated_bottomLine">
            <div class="mb-3 row">
             <label for="inputTitle" class="col-sm-2 col-form-label" >종류</label>
                <!--종류 넣기 -->
                  <div class="col-sm-10">
                     <input type="text" class="form-control" id="type" name="type" value="${list.type }" readonly="readonly"><br>
                </div>
         </div>
         
            <div class="mb-3 row">
             <!-- 제목 넣기 -->
             <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
             <div class="col-sm-10">
               <input type="text" class="form-control" id="title" name="title" value="${list.title }" readonly="readonly"><br>
               <span id="checkTitle" style="float:left;"></span>
             </div>
         </div>
         
         <div class="mb-3 row">
             <label for="inputPassword" class="col-sm-2 col-form-label">대상 회원</label>
             <div class="col-sm-10" id="ClubMemberList">
                <!-- 회원 넣기 -->
                <input type="text" class="form-control" id="suspect" name="suspect" value="${list.suspect }" readonly="readonly"><br>
             </div>
         </div>
         
         <div class="mb-3 row">
             <label for="inputContent" class="col-sm-2 col-form-label">안건</label>
             <div class="col-sm-10">
               <!-- <input type="password" class="form-control" id="inputPassword"> -->
              <textarea class="form-control" id="content" rows="3" name="content" readonly="readonly">${list.content }</textarea>
             </div>
             
         </div>
         
         <div class="mb-3 row">
             <label for="inputPassword" class="col-sm-2 col-form-label">찬성률</label>
             <div class="col-sm-10" id="ClubMemberList">
                <!-- 회원 넣기 -->
                <input type="text" class="form-control" id="percent" name="percent" value="${list.percent } % " readonly="readonly"
                style="background-color:#ffffff; border:none;">
                <a href="#" data-toggle="modal" data-target="#myModal" 
                style="float: left; text-decoration: none;">투표자 목록</a>
             </div>
         </div>
         
         </div>
         <div id="bbsCreated_footer">
         	<c:if test="${checkCap ne 0 and list.percent >= 70 and list.ddate >= 4 and list.ddate <= 11}">
         		<!-- 동아리 상태가 종료면 버튼 없애기 -->
         		<c:if test="${list.type == '동아리폐쇄' and checkClosedClub eq 0}">
		            <input type="button" value="폐쇄하기" id="closing" class="btn btn-danger"
		            onclick="confirm('동아리가 종료됩니다.'); location.href='closing.action?bid=${bid}'"/>
         		</c:if>
         		<!-- 대상자가 이 동아리에 없으면 버튼 없애기 -->
         		<c:if test="${list.type == '강퇴' and checkEliminated eq 0}">
		            <input type="button" value="강퇴하기" id="eliminated" class="btn btn-danger"
		            onclick="location.href='eliminated.action?bid=${bid}&suspect=${list.suspect }'"/>
	            </c:if>
	            <c:if test="${list.type == '강등' and checkPosition eq 0}">
		            <input type="button" value="강등하기" id="demotion" class="btn btn-danger"
		            onclick="location.href='demotion.action?bid=${bid}&suspect=${list.suspect }'"/>
	            </c:if>
         	</c:if>
         	<c:if test="${checkVote eq 0 }">
	            <input type="button" value="찬성하기" id="agree" class="btn btn-warning"
	            onclick="location.href='insertpac.action?bid=${bid}&pacId=P'"/>
	            
	            <input type="button" value="반대하기" id="disagree" class="btn btn-warning"
	            onclick="location.href='insertpac.action?bid=${bid}&pacId=C'"/>
         	</c:if>
			<c:if test="${checkVote ne 0 }">
    	        <input type="button" value="취소하기" id="agree" class="btn btn-warning"
	            onclick="location.href='deletepac.action?bid=${bid}'"/>
         	</c:if>
            
            <input type="button" value="동아리 메인" class="btn btn-warning"
            onclick="location.href='clubmain.action?cid=${cid2}'"/><br><br>
            
            <span id="comp" style="color:green;"></span>
         </div><!-- close .bbsCreated_footer -->
      </div><!-- close .bbsCreated -->
      
      <div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
       <div class="modal-dialog modal-xl modaal-dialog-centered">
         <div class="modal-content">
         
           <!-- Modal Header -->
           <div class="modal-header">
             <h4 class="modal-title">투표자 목록</h4>
             <button type="button" class="close" data-dismiss="modal">&times;</button>
           </div>
           
           <!-- Modal body -->
           <div class="modal-body" style="text-align:left;">
            <c:forEach var="list" items="${voterlist}">
               ${list.voter }<br>
            </c:forEach>
           </div>
           <!-- Modal footer -->
           <div class="modal-footer">
              <!-- radio로 선택한 회원이 있으면 선택 눌렀을 때  누른 사람이 대상회원란에 뜨게! -->
             <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           </div>
         </div>
       </div>
   </div>
</div><!-- close #bbs -->



</body>
</html>