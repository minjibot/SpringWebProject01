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
<title>MyInfo.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript">
$(document).ready(function()   // 페이지가 로드됐을 때 제이쿼리 실행?
{
	//alert("Test");
	$("#formBtn").click(function()
   {
		checkPassword();
   });
   
   
});
	// 비밀번호 확인하는 ajax
	function checkPassword()
	{
		$.ajax(
		{
			type : "POST"
            ,url : "mypagecheckpwd.action"
            ,data : {pwd : $("#pwd").val()}
            ,dataType : "json" //{key : value}
            ,success : function(result)
            {
            	if(result[0].check == 0) // 일치하지 않으면
            	{
	            	$("#err").empty();
               		$("#err").html("비밀번호가 일치하지 않습니다.");
               		$("#err").css("display","inline");
               		return false;
            	}
            	else
           		{
            		/* $("#err").empty();
               		$("#err").html("비밀번호가 일치합니다.");
               		$("#err").css("display","inline");*/
               		document.forms["pwdForm"].submit(); 
            		return true;
           		}
            	
            }
            ,error : function(e)
            {
               alert(e.responseText);
            }
        });
		return;
	}
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<style>
#err
{
	display: none;
}
#content
{
	padding-left: 30px;
}
.container {
	display: flex;
}
.pic {
    width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.eval
{
	border: 3px solid gray; 
	width: 80%; 
	padding: 10px; 
	border-radius: 10px;
	margin-top: 3px;
}
span
{
	margin: 2px;
	
}
.items
{
	font-size: 16px;
	line-height: 24pt;
}

.badge
{
	margin: 7px;
}
</style>
</head>
<body>
	<!-- 
- MyInfo.jsp
- 마이페이지 - 회원정보
 -->

	<div>
		<!-- 네브 영역 -->
		<div>
			<c:import url="nav.jsp"></c:import>
		</div>


		<!-- 메뉴 영역 -->
		<div style="float: left;">
			<c:import url="MyPageSideTab.jsp"></c:import>
		</div>


		<!-- 콘텐츠 영역 -->
		<div id="content" style="float: left; width: 70%;">
			<br>
			<h1 class="display-6">내 정보</h1>
			<hr>

			<div class="container">
				<div class="pic">
					<img class="profile" src="${info.url }">
				</div>
				<div style="padding: 20px;">
				<br><br>
					<p><span style="font-size: larger; font-weight: bold;">${info.nickname }</span>님, 반가워요!</p>
						<a href="#" data-toggle="modal" data-target="#myModal"
							id="evalmodal"  class="btn btn-warning">회원정보 수정</a>
				</div>
			</div>
			
			
			
			<!-- 수정페이지 모달 -->
			<form action="myinfoupdateform.action" method="post" name="pwdForm">
				<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
				    <div class="modal-dialog modal-m modal-dialog-centered">
				      <div class="modal-content">
				      
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">비밀번호를 입력하세요</h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        
				        <!-- Modal body -->
				        <div class="modal-body">
				        	<input type="password" id="pwd" name="pwd" class="form-control" placeholder="비밀번호 입력">
				        	<span id="err">test</span>
				        </div>
				        
				        <!-- Modal footer -->
				        <div class="modal-footer">
				          <button type="button" class="btn btn-secondary"  id="formBtn">확인</button>
				        </div>
				        
				      </div>
				    </div>
				</div>
			</form>
			
			<br><br>
			
			<div>
				<p style="font-size: larger; font-weight: bold;">내 지역</p>
				<input class="form-control" style="width: 10%; display: inline;" type="text" value="${info.regionName}" readonly="readonly"> 
				<input class="form-control" style="width: 10%; display: inline;" type="text" value="${info.regionName2}" readonly="readonly"> 
				<input class="form-control" style="width: 10%; display: inline;" type="text" value="${info.regionName3}" readonly="readonly"> 
			</div>
			
			<br><br>
			
			<div>
				<p style="font-size: larger; font-weight: bold;">관심카테고리</p>
				<input class="form-control" style="width: 12%; display: inline;" type="text" value="${info.categoryName}" readonly="readonly"> 
				<input class="form-control" style="width: 12%; display: inline;" type="text" value="${info.categoryName2}" readonly="readonly"> 
				<input class="form-control" style="width: 12%; display: inline;" type="text" value="${info.categoryName3}" readonly="readonly"> 
				<input class="form-control" style="width: 12%; display: inline;" type="text" value="${info.categoryName4}" readonly="readonly"> 
				<input class="form-control" style="width: 12%; display: inline;" type="text" value="${info.categoryName5}" readonly="readonly"> 
			</div>
			
			<br><br>
			
			<p style="font-size: larger; font-weight: bold;">내가 받은 평가</p>
			<div class="eval">
				<div class="row">
					<div class="col-5">
						<span class="items">⏳시간 약속을 잘 지켜요</span> <br>
						<span class="items">🌞친절하고 매너가 좋아요</span><br>
						<span class="items">👂다른 회원의 말에 귀 기울여줘요</span><br>
						<span class="items">🎈적극적으로 참여해요</span><br>
						<span class="items">🤡회원들을 재밌게 해줘요</span><br>
						<span class="items">📝사전 준비를 잘해요</span><br>
						<span class="items">🍀동아리 분위기를 잘 띄워줘요</span><br>
					</div>
					<div class="col-1">
						<span class="badge bg-secondary">${p1 }</span><br>
						<span class="badge bg-secondary">${p2 }</span><br>
						<span class="badge bg-secondary">${p3 }</span><br>
						<span class="badge bg-secondary">${p4 }</span><br>
						<span class="badge bg-secondary">${p5 }</span><br>
						<span class="badge bg-secondary">${p6 }</span><br>
						<span class="badge bg-secondary">${p7 }</span><br>
					</div>
					<div class="col-5">
						<span class="items">⌛동아리 활동을 지연시켜요</span> <br>
						<span class="items">😡불친절하고 매너가 좋지 못해요</span> <br>
						<span class="items">😨소극적으로 참여해요</span> <br>
						<span class="items">😠다른 회원을 무시해요</span> <br>
						<span class="items">💰금전적인 문제를 일으켜요</span> <br>
						<span class="items">👀타인에게 지나친 관심을 표현해요</span> <br>
					</div>
					<div class="col-1">
						<span class="badge bg-secondary" id="badge">${n1 }</span><br>
						<span class="badge bg-secondary" id="badge">${n2 }</span><br>
						<span class="badge bg-secondary">${n3 }</span><br>
						<span class="badge bg-secondary">${n4 }</span><br>
						<span class="badge bg-secondary">${n5 }</span><br>
						<span class="badge bg-secondary">${n6 }</span><br>
					</div>
				</div>
				<%-- <input class="form-control" style="width: 30%;" type="text" value="👍매너가 좋아요 ">
				👍매너가 좋아요 <span class="badge bg-secondary">4</span> 
				<input type="text" value="${info.categoryName}"> 
				<input type="text" value="${info.categoryName2}"> 
				<input type="text" value="${info.categoryName3}">
				<input type="text" value="${info.categoryName4}"> 
				<input type="text" value="${info.categoryName5}"> --%>
			</div>
			<br><br><br>
		</div>
		<!-- 풋터영역 -->
		<%-- <div>
			<c:import url="footer.jsp"></c:import>
		</div> --%>
	</div>




</body>
</html>