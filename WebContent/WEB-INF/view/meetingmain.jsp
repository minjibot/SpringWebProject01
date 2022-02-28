<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>B:CLE</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<!-- <link rel="stylesheet" href="css/main.css"> -->
<script type="text/javascript">
	/* $(document).ready(function() // 페이지가 로드됐을 때 제이쿼리 실행?
	{

		//$('#calendar').load('/beecalendarlist.action');
		if($("#b").val() == 'b')
		{
			$("#tab03").attr('checked', 'checked');
		}

	});
	 */
	
	$(document).ready(function() 
	{
		if($("#b").val() == 'b')
		{
			$("#tab03").attr('checked', 'checked');
		}
		
		// 모달에 가입 신청자 리스트 출력하는 ajax
		$("#listmodal").click(function(){
			 
			showJoinMemList();
             
  		});
	});
	 
	function showJoinMemList()
	{
		var params = "cid=${cid}";
		
		$.ajax(
		{   
			//alert("test");
			type : "POST"
			, url : "ajaxclubjoinlist.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var str = "";
				//alert(jsonObj.length);
				
				for(var idx=0; idx<=(jsonObj.length)-1; idx++)		// 배열방 만큼 반복문 순환
				{
					var id = jsonObj[idx].id;
					var nickname = jsonObj[idx].nickname;
					var joinId = jsonObj[idx].joinId;
					//alert(id + ":" + nickname);
					str += "<tr>"; 
					str += "	<td style='padding: 10px;'>" + nickname + "</td>"; 
					str += "	<td><button type='button' class='btn btn-outline-success btn-sm' value='"+ joinId +"'"; 
					str += "		id='button' onclick='ClubMemInsert(this);'>승인</button></td>"; 
					str += "	<td><button type='button' class='btn btn-outline-danger btn-sm' value='"+ joinId +"'"; 
					str += "		onclick='ReturnInsert(this);'>반려</button></td>"; 
					str += "</tr>"; 
					
				}
				//alert(str);
				$("#tbl").html(str);
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
	}
	
	function ClubMemInsert(val)
	{
		var params = "joinId=" + val.value + "&cid=${cid}";
		
		$.ajax(
		{   
			//alert("test");
			type : "POST"
			, url : "ajaxclubmeminsert.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				if(jsonObj == -1)
					alert("최대 인원수를 초과하여 승인할 수 없습니다.");
				showJoinMemList();
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		}); 
	}
	
	function ReturnInsert(val)
	{
		alert(val.value);
		var params = "joinId=" + val.value;
		
		$.ajax(
		{   
			//alert("test");
			type : "POST"
			, url : "ajaxjoinclubreturninsert.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				showJoinMemList();
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		}); 
	}
	
</script>
<link rel="stylesheet" href="css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>


<style>
@import
	url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
	;

body {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
}
.info {
	height: 80%;
	width: 70%;
	padding: 5vh;
}

.ProfileInfo {
	padding: 5vh;
	width: 30%;
	/* background-color: #D9D9D9; */
}

.upper {
	margin: 10vh 30vh 10vh 30vh;
	position: fix;
	height: 60%;
	display: flex;
}

.nav-link {
	display: block;
	padding: 0.5rem 3rem;
	color: #0d6efd;
	text-decoration: none;
	transition: color .15s ease-in-out, background-color .15s ease-in-out,
		border-color .15s ease-in-out;
}

.nav-tabs .nav-link .tab_content {
	margin-bottom: -1px;
	background: 0 0;
	border: 1px solid transparent;
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;
	color: #105b63;
}

ul {
	list-style: none;
}

.info ul li {
	margin: 0vh 0vh 2vh 0vh;
	border-bottom: 1px dotted #D9D9D9;
}

.col-lg-4 {
	margin: 5vh 10vh 0vh 10vh;
}

.col-lg-4 p {
	margin-left: 4vh;
}
#blink
{text-decoration: none; color: inherit;}

input[type="radio"] {
	display: none;
}

input[type="radio"]+label {
	display: inline-block;
	padding: 10px;
	background: white;
	color: #323232;
	font-size: 14pt;
	cursor: pointer;
	/* border: 1px solid #0B5FA5; 
	border-bottom: 1px solid #0B5FA5;*/
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;margin: -2px;
}

input[type="radio"]+label+a {
	display: inline-block;
	padding: 10px;
	background: white;
	color: #323232;
	font-size: 14pt;
	cursor: pointer;
	/* border: 1px solid #0B5FA5; */
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;margin: -2px;
}

input[type="radio"]:checked+label+a
{
	color: #4dd2ff;
}

input[type="radio"]:checked+label {
	color: #4dd2ff;
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;
	margin: -1px;
}

.conbox {
	width: 100%;
	height: 100%;
	margin: 0 auto;
	display: none;
}

input[id="tab01"]:checked ~ .con1 {
	display: block;
}

input[id="tab02"]:checked ~ .con2 {
	display: block;
}

input[id="tab03"]:checked ~ .con3 {
	display: block;
}

input[id="tab04"]:checked ~ .con4 {
	display: block;
}

input[id="tab05"]:checked ~ .con5 {
	display: block;
}

}
label {
	border: 1px solid transparent;
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;
}
</style>
</head>

<body>

	<div class="upper">
		<div class=info>
			<ul>
				<li>카테고리: ${clubInfo.l_cat } > ${clubInfo.s_cat }</li>
				<li>타이틀: ${clubInfo.title }</li>
				<li>개설일: ${fn:substring(clubInfo.bdate, 0, 10)}</li>
				<li>인원수: ${cntMem }</li>
				<li>지역: ${clubInfo.city } - ${clubInfo.local }</li>


			</ul>
		</div>
		<div class="ProfileInfo">
					<img alt="동아리 대표사진" src="${clubInfo.url }" style="width: 100%;">
		</div>
	</div>
	<hr>

	
	<div class="tab_content">

		<input type="radio" name="tabmenu" id="tab01" checked> 
		<label for="tab01" style="margin-left: 30vh; width: 14vh; text-align: left;">기본정보</label> 
			
		<input type="radio" name="tabmenu" id="tab02"> 
		<label for="tab02" style="width: 14vh; text-align: center;">모임</label>
		
		<input type="radio" name="tabmenu" id="tab03"> 
		<label for="tab03" style="width: 14vh; text-align: center;"><a id="blink" href="beenoticelist.action?cid=${cid }&b=b">공지사항</a></label> 
		
		<input type="hidden" id="b" name="b" value="${b }">
			
		<input type="radio" name="tabmenu" id="tab04">
		<label for="tab04"  style="width: 14vh; text-align: center;">투표</label> 
		
		<input type="radio" name="tabmenu" id="tab05"> 
		<label for="tab05"  style="width: 14vh; text-align: center;">모집</label> 
		
		
		<!-- 사이트 회원이 아닌 경우 -->
		<c:if test="${empty id }">
			<input type="button" class="btn btn-outline-danger" value="비클 가입하기"
			onclick="location.href='joinform.action'" style="float: right; margin-right: 30vh;">
		</c:if>
		
		<!-- 사이트 회원이고 동아리 회원이 아닌 경우 -->
		<!-- 지역 제한, 나이 제한.... 통과하면 버튼 노출-->
		<c:if test="${!empty id and checkClubMem eq 0 and checkClubJoin eq 0}">
			<input type="button" class="btn btn-outline-success" value="동아리 가입하기"
			onclick="location.href='clubjoininsert.action?cid=${cid}'" style="float: right; margin-right: 30vh;">
		</c:if>

		<!-- 사이트 회원이고 동아리 회원이 아니고 가입신청은 한 경우 -->
		<c:if test="${!empty id and checkClubMem eq 0 and checkClubJoin ne 0}">
			<input type="button" class="btn btn-outline-warning" value="동아리 가입신청 취소"
			onclick="location.href='clubjoindelete.action?cid=${cid}'" style="float: right; margin-right: 30vh;">
		</c:if>

		<!-- 사이트 회원이고 동아리 회원이고 동아리장인 경우-->
		<c:if test="${!empty id and checkClubMem ne 0 and checkClubCap ne 0}">
			<a href="#" data-toggle="modal" data-target="#myModal"
								id="listmodal"  class="btn btn-outline-warning" style="float: right; margin-right: 30vh;">동아리 가입 신청 목록</a>
		</c:if>
<hr>

		<div class="conbox con1">
			<c:import url="/clubbasicinfo.action?cid=${clubInfo.cid }"></c:import>
		</div>
		
		<div class="conbox con2">
			<%-- <jsp:include page="/beecalendarlist.action?cid=${clubInfo.cid }"></jsp:include> --%>
			
			<c:import url="/beecalendarlist.action?cid=${clubInfo.cid }"></c:import>
		</div>
		
		<div class="conbox con3">
			<%-- <c:import url=""></c:import> --%>
		</div>
		
		<div class="conbox con4">
			<!-- 동아리 회원이 아닌 경우 -->
			<c:if test="${checkClubMem ne 0}">
				<c:import url="/conferenceList.action?cid=${clubInfo.cid }"></c:import>
			</c:if>
			<c:if test="${checkClubMem eq 0}">
				 <p style="margin-left: 30vh; color: gray;" class="display-6">동아리에 가입한 회원에게만 노출됩니다.</p>
			</c:if>
		</div>

		
		<div class="conbox con5">
			<!-- 동아리 회원이 아닌 경우 -->
			<c:if test="${checkClubMem ne 0}">
				<c:import url="/recruitlist.action?cid=${cid }"></c:import>
			</c:if>
			<c:if test="${checkClubMem eq 0}">
				 <p style="margin-left: 30vh; color: gray;" class="display-6">동아리에 가입한 회원에게만 노출됩니다.</p>
			</c:if>
		</div>
	</div>

	<!-- 가입 신청 리스트페이지 모달 -->
	<form action="" method="post" name="pwdForm">
		<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
		    <div class="modal-dialog modal-m modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">가입 신청자 리스트</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		        	<table id="tbl">
		        		<tr>
		        			<th>닉네임</th>
		        			<th>승인</th>
		        			<th>반려</th>
		        		</tr>
		        		<%-- <c:forEach var="list" items="${clubJoinList}">
		        			<tr>
		        				<td>${list.nickname }</td>
		        				<td><button type="button" class="btn btn-outline-success btn-sm" value="${list.joinId }"
										id="button">승인</button></td>
		        				<td><input type="button" class="btn btn-outline-danger btn-sm" value="반려"
										onclick="location.href='joinclubreturninsert.action?cid=${cid}&listId=${list.joinId }'"></td>
		        			</tr>
		        		</c:forEach> --%>
		        	</table>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        </div>
		        
		      </div>
		    </div>
		</div>
	</form>


</body>

<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>


</html>