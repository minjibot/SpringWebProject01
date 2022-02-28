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
<!-- <link rel="stylesheet" href="css/main.css"> -->
<!-- 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<style>
@import
	url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
	;

body {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	font-weight: bold;
	margin: 0px;
	font-weight: bold;
}

.upper {
	display: flex;
	margin: 5vh 25vh 0vh 25vh;
	padding-left: 5%;
	padding-right: 5%;
	padding-top: 5%;
	background-color: white;
}

.upper>* {
	margin-right: 5vh;
}

.intro {
	width: 40vh;
}

.bottom {
	display: flex;
	padding: 5%;
	margin: 0vh 25vh 0vh 25vh;
	background-color: white;
}

.photo {
	margin: 0vh 30vh 5vh 20vh;
}

.upper>select, .upper>input {
	margin-left: 1vh;
	border: 3px solid #D9D9D9;
	border-radius: 30px;
}

.left {
	padding-left: 6%;
	padding-right: 5%;
}

section.main {
	width: 100%;
	height: 100%;
	background: url(images/island.jpg) no-repeat center/cover;
	position: relative;
	/* background-attachment: fixed; */
	overflow: hidden;
	/*    z-index: 1; */
}

/* section.main::after {
   width: 100%;
   height: 100%;
   content: "";
   background: url(images/island.jpg) no-repeat center/cover;
   position: absolute;
   top: 0;
   left: 0;
   z-index: -1;
   /* opacity: 0.5; */
top




















































:


























 


























0;
left





:





0;
}
* /

.main>h2 {
	margin-left: 25vh;
	padding-top: 3%;
}

#min, #max {
	width: 8vh;
}

.bottom2 {
	margin: 0vh 25vh 10vh 25vh;
	display: flex;
	padding-bottom: 5%;
	background-color: white;
}

.right {
	background-color: white;
	width: 92vh;
	padding-left: 5%;
	padding-right: 5%;
}

/* 사진업로드 관련 */
#att_zone {
	width: 60vh;
	min-height: 150px;
	padding: 10px;
	border: 1px dotted #00f;
	margin-top: 3vh;
	margin-bottom: 3vh;
}

#att_zone:empty:before {
	content: attr(data-placeholder);
	color: #999;
	font-size: .9em;
}

/* 날씨&지도 */
.weather {
	display: flex;
	height: 50%;
	width: 80%;
	border: 1px solid gray;
}

.map {
	margin: 0vh;
	height: 50%;
	width: 80%;
	background-color: gray;
}

.weather__box1 {
	margin: 0 auto;
	width: 50%;
	height: 100%;
	border: 1px solid gray;
}

.weather__box2 {
	width: 50%;
	height: 100%;
	border: 1px solid gray;
}

.participate {
	margin: 2vh 30vh 0vh 30vh;
	display: flex;
}

.participate>h3 {
	margin-right: 5vh;
}

.enroll {
	margin-top: 2vh;
	margin-left: 45%;
	margin-right: auto;
}

/* 프로필 사진 관련 */
.profile_box {
	width: 10vh;
	height: 10vh;
	border-radius: 70%;
	overflow: hidden;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.bottom3 {
	margin: 2vh 30vh 0vh 30vh;
	display: flex;
}

.bottom3>.attendence_profile {
	margin-right: 3vh;
}

#star {
	color: rgba(255, 192, 0);
}

#pic{
  postiion : relative;
  width: 700px;
  height: 350px;
}
button.btn1 {
  position: absolute;
  top: 170px;
  left : 35px; 
}

/* .weather__location{
}
.weather__description{
} */
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		var today = new Date();

		// 선택한 날짜를 date형으로 변환
		const str = $("#beeTime").val();

		const strArr = str.split('-');

		const date = new Date(strArr[0], strArr[1] - 1, strArr[2]);

		//alert(today);
		//alert( date );

		// 모임일이 지났으면
		if (date.getTime() < today.getTime())
		{
			//alert("test");
			$(".updateBtn").css("display", "none");
			$(".deleteBtn").css("display", "none");
			$("#submitButton").css("display", "none");
			$("#cancelButton").css("display", "none");
		}

		// 모임일이 안 지났으면
		if (date.getTime() > today.getTime())
		{
			$("#eval").css("display", "none");
			$("#beePhotoUpload").css("display", "none");
			$("#beePhoto").css("display", "none");
			$("#evalmodal").css("display", "none");
		}

		// 수정 버튼 클릭
		$(".updateBtn").click(
		function()
		{
			// 테스트
			//alert("수정 버튼 클릭");

			$(location).attr("href", "beeupdateform.action?beeId=" + $(this).val())

		});

		// 삭제 버튼 클릭
		$(".deleteBtn").click(
		function()
		{
			// 테스트
			//alert("삭제 버튼 클릭");

			if (confirm("모임을 삭제하시겠습니까? 참여자도 같이 삭제됩니다!"))
			{
				$(location).attr("href",
						"beedelete.action?beeId=" + $(this).val());
			}
		});

		$("#submitButton").click(
		function()
		{
			// 테스트
			//alert("수정 버튼 클릭");

			$(location).attr("href",
					"beerequest.action?clubmemId=" + $(this).val());

		});

		$("#cancelButton").click(
		function()
		{
			// 테스트
			//alert("불참 버튼 클릭");

			$(location).attr("href",
					"beeabsent.action?reqId=" + $(this).val());

		});
	});

	//textarea 바이트 수 체크하는 함수
	function fn_checkByte(obj)
	{
		const maxByte = 1980; //최대 1998바이트
		const text_val = obj.value; //입력한 문자
		const text_len = text_val.length; //입력한 문자수

		let totalByte = 0;
		for (let i = 0; i < text_len; i++)
		{
			const each_char = text_val.charAt(i);
			const utf8_char = escape(each_char) //UTF-8 형식으로 변환
			if (utf8_char.length > 4)
			{
				// 한글 : 3Byte
				totalByte += 3;
			} else
			{
				// 영문,숫자,특수문자 : 1Byte
				totalByte += 1;
			}
		}

		if (totalByte > maxByte)
		{
			alert('최대 1998Byte까지만 입력가능합니다.');
			/* document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "red";
			}else{
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "green";
			} */
		}
	}
	
	// 개인평가 체크박스 체크여부 확인
	function check() {
		if ($("input:checkbox[name='evalList']").is(":checked")==false) {
			alert("적어도 하나는 선택하여 주십시오.");
			return false;
		}
	}
	
</script>
<body>

<!--  
모임 상세 정보 페이지
1. 참석자가 있는 경우 참석자 목록 출력(○)
2. 모임 개최자는 디폴트로 참석자 목록에 넣어야 할까? 그래야 할 것 같다...! → 프로시저 작성 (○)
3. 지난 날짜인 것 참가신청/수정/삭제 버튼 노출시키지 않기(○)
4. 삭제 트리거 이용해서 참가자, 불참 다 지우기(○)
5. 참가신청 중복해서 신청할 수 없게 - 신청자랑 로그인한 사람 비교(○)
6. 로그인한 사람이랑 신청자 비교해서 신청자면 참여 취소할 수 있게(○)
7. 모임 제한인원 못 넘기게 참가신청 제한! - 버튼 숨김(확인 필요) 몇명인지 알아오기
8. 지난 날짜면 신청, 취소버튼 안 보이게 처리(○)
회원 탈퇴, 강퇴 당했을 시에 모임 참여 버튼 눌러놨으면 프로시저로 모임 데이터를 지우거나
그냥 목록에서 안 보이게만 하거나 

9. 작성자일 경우 사진 등록할 수 있게 하기(○)
10. 정모일 경우에만 사진 등록 가능함....(○)
사진 5개까지(○)
삭제

10. 정모후기 - 정모일 이후, 신청자면 후기 등록 부분 노출, 아니면 후기 보기만 가능 (○)
11. 로그인한 사람 닉네임 가져오기... "ㅇㅇㅇ"님 후기를 남겨주세요!(○)
12. 정모후기 입력 기한 지정해야 할까?
13. 정모후기 textarea 글자수 제한(○)

정모후기 신고

[개인평가]
참여자들끼리만 버튼 보이게 하기
평가한 사람은 평가완료 버튼 노출하고, 어떤 항목 골랐는지 보이게?? 아님 그냥 완료했다고만?
-->
	<section class="main">
		<h2></h2>
		<div class="upper">
			<p>모임유형 : ${bee.typeName }</p>
			<p>모임명 : ${bee.title }</p>
			주최자 : ${bee.nickName }
		</div>
		<div class="bottom">
			<div class="intro">
				<h3>모임소개</h3>
				<div class="box">${bee.content }</div>
			</div>

			<div class="photo"></div>

		</div>

		<div class="bottom2">
			<div class="left">
				<h3>자세히 알려드립니다.</h3>
				<p>※회원님들은 상세 내용을 꼭 확인하신 후 참가신청해주세요</p>
				<br></br> 참가비 : ${bee.fee }원 <br> 모임일 :
				${fn:substring(bee.beeTime, 0, 10)} <br> 모임시간 :
				${fn:substring(bee.beeTime, 11, 16)}<br> 모임장소 : ${bee.location }<br>
				인원(최소인원 - 최대인원) : ${bee.min } - ${bee.max }<br>

			</div>


			<!-- <div class="right">
				<section class="weather">
					날씨 아이콘
					<div class="weather__box1"></div>
					기온
					<div class="weather__box2"></div>

				</section>
				<section class="map">지도연동</section>
			</div> -->

		</div>

		<input type="hidden" id="beeTime" name="beeTime"
			value="${fn:substring(bee.beeTime, 0, 10)}">
		<!-- 모임 작성자랑 로그인한 사람이 같으면 -->
		<c:choose>
			<c:when test="${(bee).clubmemId eq s_clubmemId }">
				<div style="text-align: center;">
					<button type="button" value="${(bee).beeId }&cid=${cid}"
						class="btn updateBtn" style="background-color: white;">수정</button>
					<button type="button" value="${(bee).beeId }&cid=${cid}"
						class="btn deleteBtn" style="background-color: white;">삭제</button>
					<br> <br>
				</div>
			</c:when>
		</c:choose>
	</section>

	<div class="right"></div>



	<form method="post">


		<!-- 참여자 리스트 + 신청/취소 -->
		<div class="participate">
			<h3>참여자를 확인해보세요!</h3>
			<!-- 신청자랑 로그인한 사람 -->
			<c:forEach var="rb" items="${reqBee }">
				<c:choose>
					<c:when test="${s_clubmemId eq rb.clubmemId }">
						<c:set var="num" value="1" />
						<c:set var="reqMem" value="${rb.clubmemId }" />
						<c:set var="reqId" value="${rb.reqId }" />
					</c:when>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${num ne 1}">
					<button type="button" class="btn btn-warning" id="submitButton"
						value="${s_clubmemId}&beeId=${(bee).beeId }&cid=${cid}">참여하기</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-danger cancelButton"
						id="cancelButton"
						value="${reqId}&beeId=${(bee).beeId }&cid=${cid}">참여 취소하기</button>
				</c:otherwise>
			</c:choose>
		</div>
		<%-- test 작성자 ${(bee).clubmemId} 로그인한 사람 ${s_clubmemId } 신청자 ${reqMem }
		모임신청코드 ${reqId } --%> <input type="hidden" id="cnt" value="${count }">
		<input type="hidden" id="max" value="${bee.max }">

	</form>

		<c:set var="modalId" value="1" />
		<div class="bottom3">
			<c:forEach var="rb" items="${reqBee }">
				<c:set var="checkeval" value="0" />
				<!-- 평가 목록에 이미 있는 사람인지 검사 -->
				<c:forEach var="ril" items="${reqIdList }">
					<c:if test="${ril eq rb.reqId }">
						<c:set var="checkeval" value="1" />
					</c:if>
				</c:forEach>
				
				<div class="attendence_profile">
					<div class="profile_box" style="background: #BDBDBD;">
						<img class="profile" src="images/profile.png">
					</div>
					<p style="text-align: center;">${rb.nickname }
						<%-- 신청코드 ${rb.reqId } --%>
						<!-- 평가대상 모임신청코드${rb.reqId }랑 개인평가테이블에 있는 모임신청코드랑 비교 -->
						<!-- 같으면 스킵 -->
						<c:choose>
							<c:when test="${checkeval eq 1 }">
							
							</c:when>
							<c:otherwise>
								<c:if test="${rb.reqId ne reqId}">
									<a href="#" data-toggle="modal" data-target="#myModal${modalId }"
									id="evalmodal" style="text-decoration: none; border-radius: 3px; padding: 3px;
									font-size: smaller; background-color: #ff4d94; color: white;">평가하기</a>
								</c:if>
							</c:otherwise>
						</c:choose>
						
						
					</p>
 
 
						        <form action="memberevalinsert.action" method="post">
						<div class="modal fade" id="myModal${modalId }" data-backdrop="static" data-keyboard="false">
						    <div class="modal-dialog modal-xl modal-dialog-centered">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div class="modal-header">
						          <h4 class="modal-title">${rb.nickname } 님은 어떤 사람인가요?</h4>
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						        </div>
						        
						        <!-- Modal body -->
						        
						        	<!-- 평가대상 -->
						        	<input type="hidden" name="target" value="${rb.reqId }"/>
						        	<!-- 평가자 -->
						        	<input type="hidden" name="evaluator" value="${reqId }"/>
						        	<input type="hidden" name="beeId" value="${(bee).beeId }"/>
						        	<input type="hidden" name="cid" value="${cid }"/>
						        	
							        <div class="modal-body">
							        	<div class="container">
							        		<div class="row">
							        			<div class="col">
							        				<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P1" id="P1" name="evalList">
													  <label class="form-check-label" for="P1">
													    시간 약속을 잘 지켜요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P2" id="P2" name="evalList">
													  <label class="form-check-label" for="P2">
													    친절하고 매너가 좋아요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P3" id="P3" name="evalList">
													  <label class="form-check-label" for="P3">
													    적극적으로 참여해요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P4" id="P4" name="evalList">
													  <label class="form-check-label" for="P4">
													    다른 회원의 말에 귀 기울여줘요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P5" id="P5" name="evalList">
													  <label class="form-check-label" for="P5">
													    회원들을 재밌게 해줘요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P6" id="P6" name="evalList">
													  <label class="form-check-label" for="P6">
													    사전 준비를 잘해요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="P7" id="P7" name="evalList">
													  <label class="form-check-label" for="P7">
													    동아리 분위기를 잘 띄워줘요
													  </label>
													</div>
							        			</div>
							        			<div class="col">
							        				<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N1" id="N1" name="evalList">
													  <label class="form-check-label" for="N1">
													    동아리 활동을 지연시켜요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N2" id="N2" name="evalList">
													  <label class="form-check-label" for="N2">
													    불친절하고 매너가 좋지 못해요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N3" id="N3" name="evalList">
													  <label class="form-check-label" for="N3">
													    소극적으로 참여해요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N4" id="N4" name="evalList">
													  <label class="form-check-label" for="N4">
													    다른 회원을 무시해요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N5" id="N5" name="evalList">
													  <label class="form-check-label" for="N5">
													    금전적인 문제를 일으켜요
													  </label>
													</div>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox" value="N6" id="N6" name="evalList">
													  <label class="form-check-label" for="N6">
													    타인에게 지나친 관심을 표현해요
													  </label>
													</div>
							        			</div>
							        		</div>
							        	</div>
							        	
							        	
							        </div>
							        
							        <!-- Modal footer -->
							        <div class="modal-footer">
							          <button type="submit" class="btn btn-secondary" >Save</button>
							          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							        </div>
						        
						        
						      </div>
						    </div>
						</div>
						        </form>
											
					<c:set var="modalId" value="${modalId + 1}" />
						
					
					<!-- 여기까지 -->
				</div>
				
				
			</c:forEach>
		</div>
	
<!-- 원래 폼 닫는 태그 여기 있었음 -->
	<br>
	<br>
	<br>

	<!-- 정모 사진 등록 -->
	<!-- 작성자랑 로그인한 사람이랑 같으면 -->
	<!-- 정모면 -->
	<c:choose>
		<c:when test="${(bee).clubmemId eq s_clubmemId }">
			<c:if test="${bee.typeName eq '정모' }">
				<div class="container" id="beePhotoUpload">
					<h3>정모 사진 등록</h3>
					<form
						action="beephotoinsert.action?beeId=${(bee).beeId }&cid=${cid}"
						method="post" enctype="multipart/form-data">
						파일을 선택하세요. (5개까지 가능)<br>
						<c:forEach var="i" begin="1" end="${5 - countPhoto }">
							<input type="file" name="url${i }" />
						</c:forEach>

						<input type="hidden" id="beeId" name="beeId"
							value="${(bee).beeId }"> <input type="hidden" id="cid"
							name="cid" value="${cid}"> <br>
						<br>
						<button type="submit">사진등록</button>
						<br> <br>
					</form>
				</div>
			</c:if>
		</c:when>
	</c:choose>
	
	
	<!-- 정모 사진 출력 -->
	<c:choose>
		<c:when test="${bee.typeName eq '정모' }">
			<div class="container" id="beePhoto">
				<h3>정모 사진</h3><br><br>
				<div class="container-fluid">
					<div class="row">
						<c:forEach var="url" items="${urlList}">
							<div class="col-lg-2">
								<img alt="정모사진" src="${url }" style="width: 100%; height: ">
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>


	<!-- 정모 후기 등록 -->
	
	<!-- 신청자랑 로그인한 사람이랑 같고 
		 로그인한 사람이랑 후기 쓴 사람이랑 같으면 후기를 쓰지 않았으면 입력 폼 노출	
	-->

	<c:forEach var="beeEval" items="${beeEvalList }">
		<c:choose>
			<c:when test="${s_clubmemId eq beeEval.clubmemId }">
				<c:set var="evalcomp" value="1" />
			</c:when>
		</c:choose>
	</c:forEach>
	<br><br>
	<div class="container" id="eval">
		<h3>정모 후기</h3>
		<c:choose>
			<c:when test="${reqMem eq s_clubmemId}">
				<c:if test="${evalcomp ne 1 }">
					<form action="beeevalinsert.action" method="post">
						<input type="hidden" id="reqId" name="reqId" value="${reqId }">
						<input type="hidden" id="beeId" name="beeId"
							value="${(bee).beeId }"> <input type="hidden" id="cid"
							name="cid" value="${cid}"> <br>${nickname }님 정모 후기를
						남겨주세요! <br> 별점 선택* &nbsp;&nbsp;&nbsp;&nbsp;
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="score"
								id="inlineRadio1" value="1" required> <label
								class="form-check-label" for="inlineRadio1">⭐</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="score"
								id="inlineRadio2" value="2"> <label
								class="form-check-label" for="inlineRadio2">⭐⭐</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="score"
								id="inlineRadio3" value="3"> <label
								class="form-check-label" for="inlineRadio3">⭐⭐⭐</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="score"
								id="inlineRadio4" value="4"> <label
								class="form-check-label" for="inlineRadio4">⭐⭐⭐⭐</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="score"
								id="inlineRadio5" value="5"> <label
								class="form-check-label" for="inlineRadio5">⭐⭐⭐⭐⭐</label>
						</div>
						<div class="input-group">

							<textarea class="form-control" id="evalcontent"
								name="evalcontent" aria-label="With textarea" wrap="hard"
								onkeyup="fn_checkByte(this)"
								placeholder="정모 후기 내용을 입력해주세요! (※후기는 수정·삭제가 불가합니다.)"></textarea>

							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="submit">등록</button>
							</div>
						</div>
					</form>
				</c:if>
				<%-- <button type="button" class="btn btn-warning" id="submitButton"
					value="${s_clubmemId}&beeId=${(bee).beeId }&cid=${cid}">참여하기</button> --%>
				<br>
				<br>
			</c:when>

			<c:otherwise>

			</c:otherwise>
		</c:choose>
		<!-- <textarea class="form-control col-sm-5" rows="5"></textarea> -->

	</div>

	<!-- 정모 후기 출력 -->
	<div class="container" id="eval">
		<c:forEach var="beeEval" items="${beeEvalList }">
			<div>
				<div>${beeEval.nickname }&nbsp;&nbsp;&nbsp;&nbsp;
					<span style="color: #919191; font-weight: lighter;">${beeEval.bdate }</span>
				</div>
				<c:choose>
					<c:when test="${beeEval.score eq 1 }">
						<span id="star">⭐</span>
						<br>
					</c:when>
					<c:when test="${beeEval.score eq 2 }">
						<span id="star">⭐⭐</span>
						<br>
					</c:when>
					<c:when test="${beeEval.score eq 3 }">
						<span id="star">⭐⭐⭐</span>
						<br>
					</c:when>
					<c:when test="${beeEval.score eq 4 }">
						<span id="star">⭐⭐⭐⭐</span>
						<br>
					</c:when>
					<c:otherwise>
						<span id="star">⭐⭐⭐⭐⭐</span>
						<br>
					</c:otherwise>
				</c:choose>
				<pre>${beeEval.content }</pre>


			</div>
			<br>
		</c:forEach>
	</div>

	<br>
	<br>
	

	<div class="enroll">
		<button type="button" class="btn btn-secondary"
			onclick="location.href='clubmain.action?cid=${cid}'">동아리 홈으로</button>
	</div>

	<br>
	<br>

	<!-- =============================== -->
	<script src="https://unpkg.com/ionicons@5.0.0/dist/ionicons.js"></script>
	<script type="text/javascript">
		
	</script>
</body>

</html>