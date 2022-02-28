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
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"> 
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">

   $(document).ready(function()
   {
      //alert("test"); 테스트 완료
      
      // 페이지는 무조건적으로 1페이지부터 시작
      // 그러므로 ajaxVoteRequest(1)함수 바로 호출
      ajaxVoteRequest(1);
      
      //$(document).ajaxStart(function()
      $(document).ajaxStart(function()
      {
         $("#test").hide();         
      }).ajaxComplete(function()
      {
         $("#test").show();   
      });
   });
      
      function ajaxVoteRequest(pageNum)
      {
         var param = "pageNum=" + pageNum + "&cid=${cid}";
         
         $.ajax(
         {   
            type : "POST"
            , url : "votelistpage.action"
            , data : param      // param 데이터를
            , dataType : "json" // json 타입으로 보내고
            , success : function(jsonObj) // param 데이터를 json타입으로 정상적으로 보냈다면 jsonObj객체를 받아서 수행
            {
               var str = "<tr><th>순번</th><th>글제목</th><th>발의자</th><th>대상자</th><th>작성일</th><th>마감일</th><th>투표유형</th></tr>";
                
                for(var idx=0; idx<(jsonObj.length)-1;idx++)
                {
                  //alert( jsonObj[0].bId);
                   var bId = jsonObj[idx].bId;
                   var title = jsonObj[idx].title;
                   var nickname = jsonObj[idx].nickname;
                   var suspect = jsonObj[idx].suspect;
                   var bDate = jsonObj[idx].bDate;
                   var cDate = jsonObj[idx].cDate;
                   var cnt = jsonObj[idx].cnt;
                   var type = jsonObj[idx].type;
                   //alert(bId);
                   str +=         "<tr><td>"+bId+"</td>";
                  str +=         "<td><a href='vote.action?bid="+bId+"'>"+title+"</a></td>";
                  str +=         "<td>"+nickname+"</td>";
                  str +=         "<td>"+suspect+"</td>";
                  str +=         "<td>"+bDate+"</td>";
                  str +=         "<td>"+cDate+"</td>";
                  str +=         "<td>"+type+"</td></tr>";
                }
               $("#test").html(str);
               //$("#test").html("test");
               //$("#test").empty();

               var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
               pageIndexList = "<nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
                           + pageIndexList + "</ul></nav>";
               $("#pageIndexList2").html(pageIndexList);
                
            }
            , error:function(e)
            {
               alert(e.responseText);
            }
         });
         
      }
      
</script>
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



</style>
</head>
<body>

<!-- 
 conferenceList.jsp
-  동아리 관리자 페이지 - 회원관리 - 회의 리스트

 -->

   <div class="wrap">
      <!-- 네브 영역 -->
    <%--   <div>
         <c:import url="nav.jsp"></c:import>
      </div>
       --%>
      <!-- 메뉴 영역 -->
      <%-- <div>
         <c:import url="beeAdminPageSideTab.jsp"></c:import>
      </div> --%>


     <!-- 콘텐츠 영역 -->
      <div id="content" style="margin-left: 30vh; margin-right: 30vh;">
		<br>
		<c:if test="${checkvotebutton ne 0}" >         
			<button type="button" class="btn btn-warning btn-sm"
	        onclick="location.href='beevotecreated.action?cid=${cid}'">투표등록</button>
        </c:if>
		<br>
     
		<br>         
         <!-- cid -->
         <input type="hidden" id="cid" name="cid" value="${cid}">
         
         <!-- 게시판 페이징 처리 -->
        <table class="table" id="test">
           
        
        </table> 
      
        <div id="pageIndexList2">
            <!-- 실질적인 페이징 처리 영역 -->
        </div>
      
      
         <!-- 동아리장에게만 보여질 버튼-->
         
         <!-- 투표 버튼 필요할 듯..? -->


         <!-- <div id="footer">
         <p>1 Prev 21 22 23 24 25 26 27 28 29 30 Next 54</p>
      
      
      </div>   -->  
    
       </div>
       <br><br>
       <!-- 풋터영역 -->
         <%-- <div>
            <c:import url="footer2.jsp"></c:import>
         </div>  --%>
   </div>





</body>
</html>