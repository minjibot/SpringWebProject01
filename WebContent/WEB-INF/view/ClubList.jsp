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
		ajaxRequest(1);					
		
		$("#type").change(function()
		{
			ajaxRequest(1);	
		});
		
	});
	
	// 모임 
	function ajaxRequest(pageNum)
	{
		//alert($("#type").val());
		var params = "sort=" + $("#type").val() + "&pageNum=" + pageNum;
		
		$.ajax(
		{   
			//alert("test");
			type : "POST"
			, url : "ajaxclublist.action"
			, data : params
			, dataType : "json"
			, success : function(jsonObj)
			{
				var str = "";
				str += "<tr><th>순번</th><th>동아리명</th><th>개설일</th><th>가입자수</th><th>지역</th><th>카테고리</th><tr>";
				
				//alert(jsonObj.length);
				
				for(var idx=0; idx<(jsonObj.length)-1; idx++)		
				{
					var num = jsonObj[idx].num;
					var title = jsonObj[idx].title;
					var bdate = jsonObj[idx].bdate.substring(0, 10);
					var count = jsonObj[idx].count;
					var local = jsonObj[idx].local;
					var s_cat = jsonObj[idx].s_cat;
					
					
					str += "	<tr>";
					str += "		<td>" + num + "</td>";
					str += "		<td>" + title + "</td>";
					str += "		<td>" + bdate + "</td>";
					str += "		<td>" + count + "</td>";
					str += "		<td>" + local + "</td>";
					str += "		<td>" + s_cat + "</td>";
					str += "	</tr>";
					
				}
				$("#clubList").html(str);
				
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
	
	function getSelect()
	{
		
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
			<h1 class="display-6">[ 전체 동아리 ]</h1>
			<hr>

			<div>
				
				<form action="">
					<select id="type" name="type" class="form-select-sm" style="width: 7%; float: left; margin-right: 5px;">
					    <option value="BDATE" selected="selected">개설일</option>
					  	<option value="COUNT" >가입자수</option>
					    <option value="TITLE">동아리명</option>
					</select> &nbsp;
				</form>
			</div>
		
			<table id="clubList" class="table" >
	 		 	<!-- <tr>
	 		 		<th>번호</th>
	 		 		<th>ID</th>
	 		 		<th>이름</th>
	 		 		<th>이메일</th>
	 		 		<th>닉네임</th>
	 		 		<th>가입일</th>
	 		 		<th>마지막 로그인 날짜</th> 		
	 		 	</tr>
	 		 	
	 		 	<tr>
	 		 		<td>999</td>
	 		 		<td>idtest</td>
	 		 		<td>김기방</td>
	 		 		<td>kimbang@naver.com</td>
	 		 		<td>빨간토끼</td>
	 		 		<td>0</td>
	 		 		<td>0</td>	
	 		 	</tr>
	 		 	<tr>
	 		 		<td>998</td>
	 		 		<td>idididid</td>
	 		 		<td>박하유</td>
	 		 		<td>phy@naver.com</td>
	 		 		<td>파란기린</td>
	 		 		<td>0</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>997</td>
	 		 		<td>teisdi</td>
	 		 		<td>홍라온</td>
	 		 		<td>hongra@gmail.com</td>
	 		 		<td>파란이구아나</td>
	 		 		<td>0</td>
	 		 		<td>1</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>996</td>
	 		 		<td>yeloooo</td>
	 		 		<td>김하하</td>
	 		 		<td>haha@gmail.com</td>
	 		 		<td>분홍토끼</td>
	 		 		<td>1</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>995</td>
	 		 		<td>pinkkkk</td>
	 		 		<td>마동석</td>
	 		 		<td>mama@naver.com</td>
	 		 		<td>분홍솜사탕</td>
	 		 		<td>1</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>994</td>
	 		 		<td>test1122</td>
	 		 		<td>소방사</td>
	 		 		<td>sooooo@gmail.com</td>
	 		 		<td>소방관이요</td>
	 		 		<td>0</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>993</td>
	 		 		<td>pppap</td>
	 		 		<td>호현아</td>
	 		 		<td>tiger@naver.com</td>
	 		 		<td>호랑이다</td>
	 		 		<td>0</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>992</td>
	 		 		<td>testests1</td>
	 		 		<td>김낑깡</td>
	 		 		<td>kim123@naver.com</td>
	 		 		<td>노란낑깡</td>
	 		 		<td>2</td>
	 		 		<td>0</td>
	 		 	</tr>
	 		 	<tr>
	 		 		<td>991</td>
	 		 		<td>tethihih</td>
	 		 		<td>이하이</td>
	 		 		<td>hihi@gmail.com</td>
	 		 		<td>하이하이하</td>
	 		 		<td>0</td>
	 		 		<td>2</td>
	 		 	</tr> -->
	 		 	
	 		 	</table>

			<div class="col-md-12"  id="pageIndexList">
					<!-- 리뷰 페이징 영역 -->
			</div>
 		 	
 		</div>
		
		
		<!-- 풋터영역 -->
	     <%-- <div>
	      	<c:import url="footer2.jsp"></c:import>
	     </div> --%>
		


	</div>




</body>
</html>