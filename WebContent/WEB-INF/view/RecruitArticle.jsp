<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%
   // 세션 id
   String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RecruitArticle.jsp</title>
<link rel="stylesheet" href="css/mainpage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>

<!-- 부트스트랩 -->

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style type="text/css">
@import
   url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
   ;
   
.list-title{margin-top : 5vh;}
.profile {
   width: 100%;
   height: 100%;
   object-fit: cover;
}

.container {
   display: flex;
}

#staffModal {
   z-index: 9999;
}

#managerModal {
   z-index: 9999;
}

#contents {
   margin : 5vh 30vh 5vh 30vh;
   padding : 3%;
   border : 1px solid lightgray;
   border-radius : 20px;
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
   text-align: center;  
}

#contents input:not(.form-check-input) {  /* border : 1px solid lightgray;  */ border : none;   height : 5vh; margin-right : 0vh; height : 5vh; background-color: #f2f2f2;}
#contents p {margin-bottom : 3vh;}
/* .button_set {display : flex;  margin-left : 40%;  } */
.button_set button {margin-right : 3vh;} 

textarea { border : 1px solid lightgray;}

#day {color: red;}

#selectRadio { margin-left: 10px;}

#applyList {text-align: center;}
#winner {font-size: 18px; text-align: center;}


/*프로필 모달 css*/
.Profilecontents_top {
   margin-top: 2vh;
   margin-bottom: 3vh;
   display: flex;
   font-size: 16px;
   font-weight: bold;
}

.score>p, .IMade>p {
   font-size: 16px;
   font-weight: bold;
}

.detail_info {
   display: flex;
   margin-bottom : 3vh;
}

.score {
   width: 45%;
   margin-right: 5%;
   padding: 5%;
   border: 1px solid lightgray;
   border-radius: 10%;
}

.IMade {
   padding: 5%;
   width: 45%;
   border: 1px solid lightgray;
   border-radius: 10%;
} 

.memberInfo {margin-left: 3vh;}

td {
/* padding-left: 15px;  */
padding-right: 30px; }

</style>

<script>

$(document).ready(function()
{
   //alert('${admin}');
   //alert(('${admin}' == ""));
   
   //지원하기 눌렀을 때  
   $("#applyBtn").click(function()
   {
      var b_id = '${showRecruit.b_id}';
      var cid = '${showRecruit.cid}';
      
      alert("지원 완료!"); 
      $(location).attr("href", "recruitapply.action?b_id="+b_id+"&cid="+cid);
      
    });  

   //취소하기 눌렀을 때  
   $("#cancleBtn").click(function()
   {
      var b_id = '${showRecruit.b_id}';
      var cid = '${showRecruit.cid}';
      
      if(confirm("지원을 취소하겠습니까?"))
      {
         $(location).attr("href", "recruitapplycancle.action?b_id="+b_id+"&cid="+cid);
      }
    });  

   
   $(function()
   {
      $("#updateBtn").click(function()
      {
        //alert($(this).val());
         $(location).attr("href", "recruitupdateform.action?b_id=" + $(this).val());
      
      });
      
      $("#deleteBtn").click(function()
      {
         var cid = '${showRecruit.cid}';
         
         if(confirm("모집글을 정말 삭제하시겠습니까?"))
         {
            $(location).attr("href", "recruitdelete.action?b_id=" + $(this).val()+"&cid=" + cid);
         }
      });
      
   });
   
   
 //체크박스 선택하면 투표하기 버튼 활성화
   //style="display: none;"
  $("#voteBtn").hide();
  $('.form-check-input').on('click', function() {
     $("#voteBtn").show();
     //$("#voteBtn").css("display", "block");
   }); 
   
  //운영진 - 투표하기 버튼 눌렀을 때 
  $("#voteBtn").click(function()
  {
      var volunteer_id = $('input[name=selectRadio]:checked').val();
      var cid = '${showRecruit.cid}';
      var b_id = '${showRecruit.b_id}';
      //alert($(this).val());
      //alert(volunteer_id);
    
     if(confirm("투표 하시겠습니까?"))
     {
        $(location).attr("href", "recruitvote.action?motion_id="+$(this).val()+"&volunteer_id="+volunteer_id
              +"&cid="+cid+"&b_id="+b_id);
     }  
   }); 
  
  $("#voteCancleBtn").click(function()
  {
      var cid = '${showRecruit.cid}';
      var b_id = '${showRecruit.b_id}';
      //alert($(this).val());
      //alert(volunteer_id);
    
     if(confirm("투표를 취소 하시겠습니까?"))
     {
        $(location).attr("href", "recruitvotecancle.action?motion_id="+$(this).val()+"&cid="+cid+"&b_id="+b_id);
     }  
   }); 
  

});

$(function()
{
   $("#winner").hide();
 
   //var voteDday = '${showRecruit.votedday}';
   var day = '${showRecruit.day}';
   var volunteerCount = '${showRecruit.volunteer_count}';
   var voteCount = '${showRecruit.vote_count}';
   
   if(volunteerCount == 0)
      $("#applyList").html("<p style='font-size: 16px;'>[신청자 리스트]</p><p style='font-size: 16px;'>지원자가 존재하지 않습니다.</p>");
   
   if(day <= -3)
   {
      $("#applyList").hide();
     // $("#winner").html("<p style='color: red;'>실험실험</p>"); //이전 내용을 지우고 새로운 요소 삽입한다.
      $("#winner").show();
     
     if(voteCount == 0)
     {
        $("#winner").html("<p>[모집 결과]</p><p>지원자가 존재하지 않습니다.</p>");
      }
   }
   
   $("#positionBtn").click(function()
   {
      var cid = '${showRecruit.cid}';
       var position_id = '${showRecruit.position_id}';
     
      if(confirm("회원의 직위를 '${showRecruit.positionname}'으로 변경합니다."))
      {
         $(location).attr("href", "positionupdate.action?clubmem_id="+$(this).val()+"&position_id="+position_id +"&cid="+cid);
      }  
    }); 
   
});


function showProfile(str){

   //show 호출시 넘겨준 값을 이용하여 ajax 등을 통해 modal 을 띄울때 동적으로 바뀌어야 하는 값을 얻어온다.  
   var id = str;
   
   //회원 정보 프로필 ajax 프로필 사진 닉네임 나이 지역 
   $.ajax(
      {   
         type : "POST"
         , url : "ajaxprofileinfo.action"
         , data : {id: id}
         , dataType : "json"
         , success : function(jsonObj)
         {
            var str = "";
            
            var nickname = jsonObj.nickname;
            var url = jsonObj.url;
            var age = jsonObj.age;
            var regionName = jsonObj.regionName;
            var regionName2 = "";
            var regionName3 = "";
            if(jsonObj.regionName2 != null)
               var regionName2 = jsonObj.regionName2;
            if(jsonObj.regionName3 != null)
               var regionName3 = jsonObj.regionName3;
            
            //alert(nickname);
            str += "<div >";
            str += "   <img src='"+url+"' class='rounded-circle' alt='Cinque Terre' width='150' height='150'>";
            str += "</div>";
            str += "";
            str += "         <div class='memberInfo'>";
            str += "            <ul>";
            str += "               <li>닉네임 : " + nickname + "</li>";
            str += "               <li>나이 : "+ age + "</li>";
            str += "               <li>지역 : " + regionName;
             str += "               <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            str += "               &nbsp;&nbsp; " + regionName2;
            str += "               <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            str += "               &nbsp;&nbsp; "+regionName3 + " </li>"; 
            str += "            </ul>";
            str += "         </div>";
            
            $("#profileInfo").html(str);
                  
         }
         , error : function(e)
         {
            alert(e.responseText);
         }
      });
   //받은 개인 평가 ajax
   $.ajax(
      {   
         //alert("test");
         type : "POST"
         , url : "ajaxprofileeval.action"
         , data : {id: id}
         , dataType : "json"
         , success : function(jsonObj)
         {
            
            var str = "";
            str += "<p>받은 개인 평가</p>";
            str += "<br>";
            
            if(jsonObj.length > 0)
            {
               /* str += "<table class='table'>"; */
               str += "<table>";
               str += "   <tr>";
               str += "      <th>평가 내용</th>";
               str += "      <th>갯수</th>";
               str += "   </tr>";
            }
            else
            {
               str += "<q style='font-size: 14px; color: gray;'>받은 평가가 <br>존재하지 않습니다.</q>"
            }
            for(var idx=0; idx<jsonObj.length; idx++)
            {
               var content = jsonObj[idx].content;
               var count = jsonObj[idx].count;
               
               str += "   <tr>";
               str += "      <td>"+content+"</td>";
               str += "      <td>"+count+"</td>";
               str += "   </tr>";
            } 
            
            str += "</table>";
            
            $("#profileEval").html(str);
            
         }
         , error : function(e)
         {
            alert(e.responseText);
         }
      });
   
   //개설한 동아리 ajax
   $.ajax(
      {   
         //alert("test");
         type : "POST"
         , url : "ajaxprofileclub.action"
         , data : {id: id}
         , dataType : "json"
         , success : function(jsonObj)
         {
            var str = "";
            str += "<p>개설한 동아리</p>";
            str += "<br>";
            str += "<ul>";
            
            if(jsonObj.length == 0)
               str += "<q style='font-size: 14px; color: gray;'>개설한 동아리가 <br>존재하지 않습니다.</q>";
            
            //alert(jsonObj[0].title);
             
            for(var idx=0; idx<jsonObj.length; idx++)
            {
               var clubTitle = jsonObj[idx].title;
               
               str += "<li>" + clubTitle +"</li>";
            } 
            str += "</ul>";
            
            $("#profileClub").html(str);
            
         }
         , error : function(e)
         {
            alert(e.responseText);
         }
      });
   
   
   
   //얻어온 값을 이용하여, modal 에서 동적으로 바뀌어야 하는 값을 바꾸어 준다..  
   
    //modal을 띄워준다.  
   $("#profileModal").modal('show');

};

</script>
</head>
<body>

   <!-- 
ClubBeforeOpenedContents.jsp
- 메인화면(로그인 전) 페이지 2 -⑤ 회원 모집 동아리 상세페이지(내용)
- 개절예정 동아리(스탭프 지원(동의)받는중)
 -->
   <div class="wrap">
      <!-- 네브 영역 -->
      <div>
         <c:import url="/nav.action"></c:import> 
      </div>
      
      
       <section class="list-title">
         <div class="title">
            <h2>Recruit<span>.</span></h2>
            <p>동아리의 새로운 운영진이 되어보세요</p>
         </div>
      </section>

      <!-- 콘텐츠 영역 -->
      <div id="contents">
         <div>
            <h3> ${showRecruit.title} </h3>
            <hr style="height: 0.1px;">
            <br>
         </div>
         <div>
            <p>모집 마감
            <c:choose>
               <c:when test="${showRecruit.day lt 1 and showRecruit.day gt -3}">
                  <input type="text" id="day" name="day" value="투표중" disabled="disabled">
               </c:when>
               <c:when test="${showRecruit.day le -3}">
                  <input type="text" id="day" name="day" value="마감" disabled="disabled">
               </c:when>
               <c:otherwise>
                  <input type="text" id="day" name="day" value="D - ${showRecruit.day }" disabled="disabled">
               </c:otherwise>
            </c:choose> 
            </p>
         </div>

         <div>
            <form action="">
               <div>
                  <p>
                     작성자
                     <input type="text" id="nickname" name="nickname" value=" ${showRecruit.nickname}" disabled="disabled">
                     등록일
                     <input type="text" id="preopendate" name="preopendate" value=" ${showRecruit.bdate}" disabled="disabled">
                  </p>
                  <p>
                     조회수
                     <input type="text" value=" ${showRecruit.cnt}" disabled="disabled">
                  </p>
                  <p>
                     모집 직위
                     <input type="text" value=" ${showRecruit.positionname}" disabled="disabled">
                  </p>
                  <p>
                     내용<br><textarea rows="10" cols="70">${showRecruit.content}</textarea>
                  </p>
               <br>
                  <div>
                  </div>
                  
                  <div id="applyList">
                    <p style="font-size: 16px;">[신청자 리스트]<p>
                    <c:if test="${positionCheck ne 1 and showRecruit.day lt 1 and showRecruit.day gt -3}"> <!-- 동아리 원이 아니면(운영진이면) 프로필 이동 가능 (a태그) -->
                    <p style="color: red; font-size: 16px;">새로운 ${showRecruit.positionname}을 선택해주세요!
                    <br>투표는 ${showRecruit.votedday }일 후에 종료 됩니다.</p>
                    </c:if>
                     <div class="container2">
                            <div class="row">
                           	<c:forEach var="list" items="${volunteerList }" varStatus="status">
                              	<c:if test="${status.index%3==0 }">
                                 	</div><div class="row">
                               	</c:if>
                             	<div class="col-lg-4">
                                 	<c:choose>
                                       <c:when test="${positionCheck ne 1}"> <!-- 동아리 원이 아니면(운영진이면) 프로필 이동 가능 (a태그) -->
                                          <a href="#" id="profile" data-bs-toggle="modal" data-bs-target="#profileModal"
                                          onclick="showProfile('${list.id}')" >
                                          <img src="${list.url }" class="rounded-circle" alt="Cinque Terre" width="100" height="100">
                                          <br> ${list.nickname } <br>
                                          <input type="hidden" id="nickname2" value="${list.nickname }">
                                          </a>
                                          <br><br> 
                                          <c:if test="${showRecruit.day lt 1 and showRecruit.day gt -3 and exeVoteCheck eq 0}">
                                             <input type="radio" class="form-check-input" id="selectRadio" name="selectRadio" value="${list.volunteer_id }">
                                         <label class="form-check-label" for="selectRadio"></label> 
                                          </c:if>
                                       </c:when>
                                       <c:otherwise> <!-- 운영진 아니면 프로필 이동 불가, 사진과 닉네임만 보여짐 -->
                                          <img src="${list.url }" class="rounded-circle" alt="Cinque Terre" width="100" height="100">
                                          <br> ${list.nickname } 
                                       </c:otherwise>
                                    </c:choose>                  
                           		</div>
                           
                           
                       		</c:forEach>
                     </div>
                     <br><br>
                       <c:if test="${exeVoteCheck eq 1}">
                             <p style="color: red; font-size: 18px; text-align: center;">${pickNickname}님에게 투표하셨습니다!</p>
                       </c:if>
                    </div>
                  </div> <!-- applyList end -->
                  
                  <div id="winner">
                        <p>[모집 결과]</p>
                        <p>축하합니다.</p>
                        <img src="${winner.url }" class="rounded-circle" alt="Cinque Terre" width="100" height="100">
                        <p> ${winner.nickname}님이 ${showRecruit.positionname}로 선정되었습니다~!! </p>
                        
                        <c:if test="${showRecruit.id eq id }">
                           <button type="button" class="btn btn-danger btn-sm" id="positionBtn"
                            value="${winner.clubmem_id }">직위변경</button>
                        </c:if>
                  </div>
           
                <br><br>
                     
              <div>
              <button type="button" class="btn btn-success" id="voteBtn"
                         value="${showRecruit.motion_id }">투표하기</button>
                        <c:if test="${exeVoteCheck eq 1 and showRecruit.day lt 1 and showRecruit.day gt -3}">
                           <button type="button" class="btn btn-danger" id="voteCancleBtn"
                            value="${showRecruit.motion_id }">투표취소</button>
                        </c:if>
              </div> <br>
                  <div class ="button_set">
                        <c:if test="${positionCheck eq 1 and showRecruit.day ge 1 }"> 
                           <c:choose>
                              <c:when test="${applyCheck eq 0 }">
                                 <button type="button" class="btn btn-success" id="applyBtn">지원하기</button>
                              </c:when>
                              <c:otherwise>
                                 <button type="button" class="btn btn-danger" id="cancleBtn">지원취소</button>
                              </c:otherwise>
                           </c:choose>
                        </c:if>
                        
                        <button type="button" class="btn btn-secondary" id="closeBtn" onclick="location.href='recruitlist.action?cid=${showRecruit.cid}'">목록</button>
                        
                        <c:if test="${showRecruit.id eq id }"> <!-- 추후에 마감 지나면 수정,삭제 못하게끔 처리해야함 -->
                            <c:if test="${showRecruit.day ge 1}">
                               <button type="button" class="btn btn-warning" id="updateBtn" value="${showRecruit.b_id }" >수정</button>
                            </c:if>
                           <button type="button" class="btn btn-warning" id="deleteBtn" value="${showRecruit.b_id }">삭제</button>
                        </c:if>
                  </div>


               </div>
            </form>
         </div>
      </div>
       </div>
      
      <!-- 풋터영역 -->
      <div>
         <c:import url="footer.jsp"></c:import>
      </div>

<!-- ○ 프로필 모달 -->   
<!-- The Modal -->
<div class="modal fade" id="profileModal">  <!-- fade 천천히 나타나게 해주는 -->
  <div class="modal-dialog modal-lg"> <!-- 뒤에 백그라운드 어두어지게 하는거 -->
    <!-- Modal content -->
    <div class="modal-content"> <!-- 모달의 전체적인 구성 -->
    
    <div class="modal-header">
        <h5 class="modal-title">프로필</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
         <div class="Profilecontents">
         
      <div class="Profilecontents_top" id="profileInfo">
         
      </div>

      <div class="detail_info">
         <div id="profileEval" class="score"> 
         
         </div>
         
         <div class="IMade" id="profileClub">
            
         </div>
         
      </div>
   </div> <!-- profilecontents end -->
         
         
         
      </div>

     <!--  Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-bs-dismiss="modal">닫기</button>
      </div>

    </div> <!-- end modal-content  -->
  </div>
</div> <!-- profileModal end -->
  

</body>
</html>