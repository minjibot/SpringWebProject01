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
      Voter();
      
      $("#type").change(function()
      {
         
         if($("#type").val()=="3")
         {
            $("#member").hide();
            $("#sspmember").hide();
            return;
           }
         else
         {
            Voter();
            $("#member").show();
            $("#sspmember").show();
         }   
      });
      
      
      
      $("input[name='suspect']").change(function()
      {
         //alert("test");
         $("input[name='suspect']").each(function()
         {
            var value = $(this).val();
            var checked = $(this).prop('checked');
            var $label = $(this).next();

         });
        });
      
      
      $("#replace").click(function()
      {
        //alert("test"); 
         $("#ClubMemberList").empty();
         $("#ClubMemberList").append("<input class='form-control' readonly='readonly' type='text' value='"+Replace()+"'/>");
         $("#ClubMemberList").append("<input type='hidden' name='realsuspect' value='"+Replace()+"'/>");
         $("#ClubMemberList").append("<a href='#' data-toggle='modal' data-target='#myModal' name='realsuspect' style='float: left; text-decoration: none;'>다시 선택</a>");
      });

      $("#submitBtn").click(function()
      {   
         /* alert("test"); */
          if($("#inputTitle").val().length == 0)
         {
            $("#checkTitle").html('제목은 필수입력사항입니다.');
            $("#checkTitle").css('color','red');
            $("#inputTitle").focus();
            return false;
         }
         if($("input[name='suspect']:checked").val()==null && ($("#type").val()=="1" || $("#type").val()=="2"))
      //alert($("input[name='suspect']:checked").val());
            {
               alert("동아리 회원을 선택해야 합니다.");
               return;
            }
            
          $("#myForm").submit();
      });
      
      
      
   });
   
function Replace()
{

   var value = "";
    $("input[name='suspect']").each(function()
      {
         var checked = $(this).prop('checked');
         var $label = $(this).next();

         if(checked)
         {
            value = $(this).val();
             
         }

      });
   return value;
   
}

function Voter()
{
   var param = "type=" + $("#type").val() + "&cid=${cid}";
   
      $.ajax({
         url: "typecheck.action"
         ,type : "POST"
         ,data : param
          ,dataType : "json"
          ,success:function(result)
          {
             var str = "";
             
             
             for(var idx=0; idx<=(result.length)-1; idx++)
            {
                str += "<input type='radio' id='suspect' name='suspect' value='" + result[idx].nickname + "'>"+result[idx].nickname+"<br>";
            }
             
             $("#list").html(str);
             
          }
          , error:function(e)
          {
             alert(e.responseText);
          }
      })
}
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
   
   <form action="insertconferenceList.action" method="post" id="myForm">
         <input type="hidden" name="cid" value="${cid}">
         <div id="bbsCreated" style="width: 60%; border: 5px solid gray; border-radius: 10px; padding: 30px 40px 30px 30px;">
            <div class="bbsCreated_bottomLine">
               <div class="mb-3 row">
                <label for="inputTitle" class="col-sm-2 col-form-label">종류</label>
                <div class="col-sm-10">
                     <select class="form-select form-select-sm" style="float: left" id="type" name="type">
                        <option value="1" id="down">강등</option>
                        <option value="2" id="out" selected="selected">강퇴</option>
                        <option value="3" id="close">동아리 폐쇄</option>
                     </select>
                </div>
            </div>
         
            <div class="mb-3 row">
             <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
             <div class="col-sm-10">
               <input type="text" class="form-control" id="inputTitle" name="title"><br>
               <span id="checkTitle" style="float:left;"></span>
             </div>
         </div>
         
         
         <div class="mb-3 row">
             <label for="inputPassword" class="col-sm-2 col-form-label" id="sspmember">대상 회원</label>
             <div class="col-sm-10" id="ClubMemberList">
               <a href="#" data-toggle="modal" data-target="#myModal" id="member"
                     style="float: left; text-decoration: none;">동아리 회원 목록</a>
             </div>
         </div>
         
         <div class="mb-3 row">
             <label for="inputContent" class="col-sm-2 col-form-label">안건</label>
             <div class="col-sm-10">
               <!-- <input type="password" class="form-control" id="inputPassword"> -->
              <textarea class="form-control" id="inputContent" rows="3" name="content"></textarea>
             </div>

         </div>
         </div>
         <div id="bbsCreated_footer">
            <input type="button" value="등록하기" class="btn btn-warning" id="submitBtn"/>
            <input type="reset" value="다시입력" class="btn btn-warning"
            onclick="document.myForm.subject.focus();"/>
            <input type="button" value="작성취소" class="btn btn-warning" 
            onclick="location.href='conferenceList.action'"/>
         </div><!-- close .bbsCreated_footer -->
      </div><!-- close .bbsCreated -->
      
      
      <!-- 모달(동아리 회원 목록) -->
      <div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
       <div class="modal-dialog modal-xl modal-dialog-centered">
         <div class="modal-content">
         
           <!-- Modal Header -->
           <div class="modal-header">
             <h4 class="modal-title">회원 목록</h4>
             <button type="button" class="close" data-dismiss="modal">&times;</button>
           </div>
           
           <!-- Modal body -->
           <div class="modal-body" style="text-align:left;" id="list">
               <!-- <img class="card-img-top rounded img-fluid" src="images/research/research-1.jpg"> -->
            <%-- <c:forEach var="list" items="${suspectlist}">
                <input type="radio" id="suspect" name="suspect"
                value="${list.nickname }">${list.nickname }<br>
            </c:forEach> --%>
           </div>
           <!-- Modal footer -->
           <div class="modal-footer">
              <!-- radio로 선택한 회원이 있으면 선택 눌렀을 때  누른 사람이 대상회원란에 뜨게! -->
             <button type="button" class="btn btn-secondary" data-dismiss="modal"
              id="replace" >선택</button>
             <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           </div>
         </div>
       </div>
   </div>
      
      
   </form>
   
</div><!-- close #bbs -->



</body>
</html>