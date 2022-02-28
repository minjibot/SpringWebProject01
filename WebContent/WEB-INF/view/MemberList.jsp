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
<title>MemberList.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script> 
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
 
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
	$(document).ready(function() 
	{
		ajaxRequest(1);						// 페이지가 로드될 때 ajax 함수 호출
		
	});
	
	// 모임 
	function ajaxRequest(pageNum)
	{
		var params = "select=" + $("#type").val() + "&pageNum=" + pageNum + "&inputValue=" + $("#inputValue").val();
		
		$.ajax(
		{   
			type : "POST"
			, url : "ajaxmemberlist.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var str = "";
				str += "<tr><th>번호</th><th>ID</th><th>이름</th><th>이메일</th><th>닉네임</th><th>가입일</th><th>마지막 로그인 날짜</th></tr>";
				
				for(var idx=0; idx<(jsonObj.length)-1; idx++)		
				{
					var num = jsonObj[idx].num;
					var userId = jsonObj[idx].userId;
					var name = jsonObj[idx].name;
					var email = jsonObj[idx].email;
					var nickname = jsonObj[idx].nickname;
					var bdate = jsonObj[idx].bdate;
					var login_date = jsonObj[idx].login_date;
					
					
					str += "	<tr>";
					str += "		<td>" + num + "</td>";
					str += "		<td>" + userId + "</td>";
					str += "		<td>" + name + "</td>";
					str += "		<td>" + email + "</td>";
					str += "		<td>" + nickname + "</td>";
					str += "		<td>" + bdate + "</td>";
					str += "		<td>" + login_date + "</td>";
					str += "	</tr>";
					
				}
				$("#memberList").html(str);
				
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
<style type="text/css">
/* 	.left
	{
		float: left;
	}
	.right
	{
		float: right;
	}
 */
</style>
</head>
<body>

<!-- 
 MemberList.jsp
-  관리자페이지>회원관리>전체회원

 -->

	<div>
		<!-- 네브 영역 -->
		<div>
			<c:import url="navAdmin.jsp"></c:import>
		</div>
	
		<!-- 콘텐츠 영역 -->
		<div id="content" style="margin: 5vh 20vh 5vh 20vh;">
			<h1 class="display-6">[ 전체 회원 ]</h1>
			<hr>

			<div>
				
				<form action="">
					<select id="type" name="type" class="form-select-sm" style="width: 7%; float: left; margin-right: 5px;">
					    <option value="0" selected="selected">선택</option>
					  	<option value="userId" >ID</option>
					    <option value="name">이름</option>
					    <option value="nickname" >닉네임</option>
					</select> &nbsp;
					<input type="text" id="inputValue" placeholder="검색어 입력" class="form-control-sm" style="width: 15%; float: left; margin-right: 5px;" />
					<input type="button" value="검색" onclick="ajaxRequest(1)" class="btn btn-outline-secondary btn-sm" style="float: left;">
					
				</form>
			</div>
		
			<table id="memberList" class="table" >
	 		 	<!-- 회원 리스트 출력 -->
	 		</table>

			<div class="col-md-12"  id="pageIndexList">
					<!-- 페이징 영역 -->
			</div>
 		 	
 		</div>
		
		
		<!-- 풋터영역 -->
	     <%-- <div>
	      	<c:import url="footer2.jsp"></c:import>
	     </div> --%>
		


	</div>




</body>
</html>