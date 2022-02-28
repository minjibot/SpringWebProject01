<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	String num = (String)session.getAttribute("num");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script> 
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>


<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
 
<!-- <script type="text/javascript" src="http://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
	$(document).ready(function() 
	{
		//alert("test");
		ajaxRequest(1);						// 페이지가 로드될 때 리뷰 ajax 함수 호출
		
		$(document).ajaxStart(function()		
		{
			// AJAX 시작 시...
			$("#showList").hide();
			
		}).ajaxComplete(function()
		{
			// AJAX 종료 시...
			$("#showList").show();
			
		});
	});
	
	// 모임 
	function ajaxRequest(pageNum)
	{
		var params = "cid=${cid}" + "&pageNum=" + pageNum;
		
		$.ajax(
		{   
			//alert("test");
			type : "POST"
			, url : "ajaxbeelist.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var str = "";

				for(var idx=0; idx<(jsonObj.length)-1; idx++)		// 배열방 만큼 반복문 순환
				{
					var beeId = jsonObj[idx].beeId;
					var typeName = jsonObj[idx].typeName;
					var title = jsonObj[idx].title;
					var beeTime = jsonObj[idx].beeTime;
					var nickName = jsonObj[idx].nickName;
					var beeDate = jsonObj[idx].beeDate;
					var content = jsonObj[idx].content;
					var reqCnt = jsonObj[idx].reqCnt;
					var max = jsonObj[idx].max;
					
					str += "			<a href='beedetailpage.action?beeId=" + beeId + "&cid=${cid}' style='text-decoration: none; color: black;'>";
					str += "				<div class='card mb-3' style='max-width: 1000px;'>";
					str += "				<div class='row g-0'>";
					str += "					<div class='col-md-4'>";
					str += "						<img src='http://artinsight.co.kr/data/tmp/1806/8a7aa7b2cc1c8658726cc7a2df93418f_Kthlez4CFNiI72tb12Chqdw.jpg' class='img-fluid rounded-start' alt='...'>";
					str += "					</div>";
					str += "					<div class='col-md-8'>";
					str += "						<div class='card-body'>";
					str += "							<h5 class='card-title'>" + title + "</h5>";
					
					str += "								<p class='card-text'>모임 시간 : " + beeTime + " </p>";
					str += "								<p class='card-text'>게시자 " + nickName + "</p>";
					str += "								<p class='card-text'><small class='text-muted'>작성일 " + beeDate + "</small></p>";
					str += "								<p class='card-text'>인원수 : (" + reqCnt + " / " + max + ")</p>";
					str += "						</div>";
					str += "					</div>";
					str += "				</div>";
					str += "				</div>";
					str += "			</a><br>";
				}
				$("#showList").html(str);
				var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
				pageIndexList = "<nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
								+ pageIndexList + "</ul></nav>";
				$("#pageIndexList").html(pageIndexList);
				
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
	}	
</script>

<style>
@import
	url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
	;

.contents{
margin : 5vh 34vh 5vh 30vh;
}
.card{
margin-left : 5vh;
}
.row g-0{
margin-bottom : 2vh;
border: 1px;
}
.box{
margin : 5vh 30vh 3vh 77%;
}
#search{
margin : 0vh 30vh 0vh 60%;
}

/* #accountSelect{
margin : 10vh 0vh 10vh 40vh;
} */
</style>
</head>
<body>
<!--  
clubCalendarList.jsp
- 동아리 페이지 - 캘린더 리스트
1. id, 동아리코드 받아와서 사람마다 리스트 다르게 출력하기
-->
	 <%-- <c:import url="/nav.action"></c:import>
	 <c:import url="meetingmain.jsp"></c:import> --%>
	
<div>
	<c:if test="${checkClubMem ne 0 }">
		<div style="float: left; margin : 5vh 30vh 3vh 18%;">
				<button type="button" class="btn btn-warning btn-sm" 
				onclick="location.href='beeinsertform.action?cid=${cid}'">모임개설</button>
				
		</div>
	</c:if>
</div>
	<div class="box">
		<div id="accountSelect">
		      <!-- <div>
		         <form action="" name="accountForm" method="post">
		            <select name="accountKey" class="selectField"  
		            onchange="if(this.value) location.href=(this.value);">
		               value값 변경해야함..
		               <option value="beecalendar.action" >캘린더</option>
		               <option value="beecalendarlist.action" selected="selected">리스트</option>
		            </select>
		            <div></div>
		         </form>
		      </div>
		      
		      <div>
		         <form action="" name="accountForm" method="post">
		            <select name="accountKey" class="selectField">
		               <option value="">전체보기</option>
		               <option value="">예정모임</option>
		               <option value="">지난모임</option>
		            </select>
		            <div></div>
		         </form>
		      </div>
			 -->
		 </div>
	</div>
	<br>
	<div class="contents" >
		<div class=""	id="showList">
			
		</div>
	</div>

	<div class="col-md-12"  id="pageIndexList">
			<!-- 리뷰 페이징 영역 -->
	</div>

	
	<div class="contents">

		<div class="card mb-3">
		<%-- 
		<c:forEach  var="bee" items="${beeList }">
			<a href="beedetailpage.action?beeId=${bee.beeId}&cid=${cid}" style="text-decoration: none;">
			<div class="row g-0">
				<div class="col-md-4">
					<img src="http://artinsight.co.kr/data/tmp/1806/8a7aa7b2cc1c8658726cc7a2df93418f_Kthlez4CFNiI72tb12Chqdw.jpg" class="img-fluid rounded-start" alt="...">
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<h5 class="card-title">${bee.title }</h5>
						
						<p class="card-text">모임 시간 : ${bee.beeTime } </p>
						<p class="card-text">게시자 ${bee.nickName }</p>
						<p class="card-text">
							<small class="text-muted">작성일 ${bee.beeDate }</small>
						</p>
						<p class="card-text">인원수 : (${bee.reqCnt } / ${bee.max })</p>
						 
					</div>
				</div>
			</div>
			</a>
			<br></br>
			<br></br>
		</c:forEach>
		 --%>
	
			<!-- <div class="row g-0">
				<div class="col-md-4">
					<img src="http://artinsight.co.kr/data/tmp/1806/8a7aa7b2cc1c8658726cc7a2df93418f_Kthlez4CFNiI72tb12Chqdw.jpg" class="img-fluid rounded-start" alt="...">
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<h5 class="card-title">✨ 마포구 달리기</h5>
						<p class="card-text">정모일 작성자</p>
						<p class="card-text">
							<small class="text-muted">Last updated 3 mins ago</small>
						</p>
						<p class="card-text">인원수 : (7 / 35)</p>
					</div>
				</div>
			</div>
			<br></br>
			<br></br>  -->

		</div>


	</div>
	

</body>
</html>