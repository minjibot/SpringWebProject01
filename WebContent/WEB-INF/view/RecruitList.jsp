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
<title>ConferenceList.jsp</title>
<link rel="stylesheet" href="css/mainpage.css">
<!-- 부트스트랩 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"> 
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style type="text/css">

/*reset*/
* {margin: 0;padding: 0;}
body {margin: 0;}
h1, h2, h3, h4, h5, h6, p, ul, ol, li, dl, dt, dd {margin: 0; padding: 0;}
h1, h2, h3, h4, h5, h6 {font-weight: 700; }
a {color: inherit; text-decoration: inherit;}
img {vertical-align: middle;}
a img {border: none;}
li {list-style: none;}
address, em, i, ul {font-style: normal;}

/*layout*/
.mo {display: none;}
.en {font-family: 'Exo 2', sans-serif;}
body {font-family: 'Noto Sans KR', sans-serif; font-size: 14px;}
.wrap {margin: 0 auto; }


#contents {
   margin : 5vh 30vh 5vh 30vh;
   padding : 3%;
   border : 1px solid lightgray;
   border-radius : 20px;
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
}

.list-title{margin-top : 5vh;}


</style>
<script type="text/javascript">

$(document).ready(function() 
   {
      //alert("test");
      ajaxRecruitRequest(1);                  
      
      $("#selectOrder").change(function()
      {
         //alert($("#selectOrder option:selected").attr("value"));
          //alert($("#selectOrder option:selected").val());
         ajaxRecruitRequest(1);               
      });
      
      /* 
      $(document).ajaxStart(function()      
      {
         // AJAX 시작 시...
         $("#recruitList").hide();
         
      }).ajaxComplete(function()
      {
         // AJAX 종료 시...
         $("#recruitList").show();
         
      }); */
       
      
      
   });
   
   // 모집 리스트, 페이징 처리
   function ajaxRecruitRequest(pageNum)
   {

       var sortOrder = "";
 
        if($("#selectOrder option:selected").val() != "")
           sortOrder = $("#selectOrder option:selected").val();
        
      var params = "cid=${cid}" +"&sortOrder=" + sortOrder  +"&pageNum=" + pageNum;

      
      $.ajax(
      {   
         //alert("test");
         type : "POST"
         , url : "ajaxrecruitlist.action"
         , data : params
         , dataType : "json"
         , success : function(jsonObj)
         {
            var str = "";
            
            
            if(jsonObj.length-1 == 0)
            {
               str = "<p style='font-size : 24px; text-align: center; margin-top: 15vh; margin-bottom: 15vh;'>등록된 게시물이 없습니다.</p>";
            }
            else
            {
            //alert(pageNum);
            str += "<table class='table' >";
            str += "              <tr>";
            str += "                 <th>순번</th>";
            str += "                 <th>글제목</th>";
            str += "                 <th>작성자</th>";
            str += "                 <th>작성일</th>";
            str += "                 <th>조회수</th>              ";
            str += "              </tr>";
            }
            
            for(var idx=0; idx<(jsonObj.length)-1; idx++)      // 배열방 만큼 반복문 순환
            {
               var rnum = jsonObj[idx].rnum;
               var title = jsonObj[idx].title;
               var nickname = jsonObj[idx].nickname;
               var bdate = jsonObj[idx].bdate;
               var cnt = jsonObj[idx].cnt;
               var b_id = jsonObj[idx].b_id;
               
               str += "          <tr>";
               str += "              <td>" + rnum +"</td>";
               str += "              <td> <!-- 포지션 체크 위해서 cid 필요 -->";
               str += "                 <a href='recruitarticle.action?b_id=" + b_id  +"&cid=${cid}' style='text-decoration: none;'>";
/*                str += "                 <a href='recruitarticle.action?pageNum="+pageNum+"&b_id=" + b_id  +"&cid=${cid}' style='text-decoration: none;'>"; */
               str +=                   title;
               str += "            </a>";
               str += "              </td>";
               str += "              <td>" +nickname+ "</td>";
               str += "              <td>" +bdate+ "</td>";
               str += "              <td>" +cnt+ "</td>";
               str += "           </tr>";
            
            }
            str += "</table>";
            
            $("#recruitList").html(str);
            
             var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
            pageIndexList = "<nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
                        + pageIndexList + "</ul></nav>";
            $("#pageIndexList3").html(pageIndexList); 
            
         }
         , error : function(e)
         {
            alert(e.responseText);
            //alert("에러");
         }
      });
   }



</script>
</head>
<body>

<!-- 
 conferenceList.jsp
-  동아리 관리자 페이지 - 회원관리 - 회의 리스트

 -->

   <div class="wrap">
      <!-- 네브 영역 -->
      <%-- <div>
         <c:import url="/nav.action"></c:import> 
      </div> --%>
      
      <!-- 메뉴 영역 -->
      <%-- <div>
         <c:import url="beeAdminPageSideTab.jsp"></c:import>
      </div> --%>


     <!-- 콘텐츠 영역 -->
      <div id="contents" style="margin-left: 30vh;">
         <section class="list-title">
         <div class="title">
            <h2>Recruit<span>.</span></h2>
            <p>동아리의 새로운 운영진이 되어보세요</p>
         </div>
      </section>
         <hr >

         <div>
            <form action="">

               <div>
                  <select name="" class="form-select form-select-sm"
                     style="width: 100px;" id="selectOrder">
                     <option value="" selected="selected" >전체</option>
                     <option value="1">마감 제외</option>
                     <option value="2">투표중</option>
                  </select>
               <!--    </select> <input type="checkbox" class="form-check-input" id="check1"
                     name="option1" value="something"> <label
                     class="form-check-label" for="check1">마감 제외</label> -->
               </div>

            </form>
         </div>
         
         <!-- cid -->
         <input type="hidden" id="cid" name="cid" value="${cid}">
         <input type="hidden" id="pageNum" name="pageNum" value="">
        <%--  <input type="hidden" id="" name="cid" value="${cid}"> --%>
         
         <div id="recruitList">
          <%-- 
          <table class="table" >
              <tr>
                 <th>순번</th>
                 <th>글제목</th>
                 <th>작성자</th>
                 <th>작성일</th>
                 <th>조회수</th>              
              </tr>
           
          <c:forEach var="recruit" items="${list }">
          <tr>
              <td>${recruit.rnum}</td>
              <td> <!-- 포지션 체크 위해서 cid 필요 -->
                 <a href="recruitarticle.action?b_id=${recruit.b_id}&cid=${cid}" style="text-decoration: none;">
                              ${recruit.title }
            </a>
              </td>
              <td>${recruit.nickname}</td>
              <td>${recruit.bdate}</td>
              <td>${recruit.cnt}</td>
           </tr>
          </c:forEach>
           </table> --%>
           </div> <!-- end showList -->
           
           
           <!-- 동아리원에게는 보이지 않는 버튼 -->
           <!-- 운영진에게만 보이게끔 처리 -->
         <div>
         <br>
         <%-- <button type="button" class="btn btn-primary"
            onclick="location.href='clubmain.action?cid=${cid}'"
            style="float: left;">홈으로</button>  --%>
            
            <c:choose>
               <c:when test="${positionCheck eq 4}">
                  <button type="button" class="btn btn-warning"
                     onclick="location.href='recruitinsertform.action?cid=${cid}'"
                     style="float: right;">모집등록</button>
               </c:when>
            </c:choose>
         </div>
         <br>


      <div class="col-md-12"  id="pageIndexList3" style="margin-top: 5vh;">
         <!-- 리뷰 페이징 영역 -->
      </div>    
    
       </div>
       <br>
       <!-- 풋터영역 -->
      <div>
         <c:import url="footer.jsp"></c:import>
      </div>

   </div>





</body>
</html>