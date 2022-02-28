<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainSideTab.jsp</title>
<style type="text/css">


.sidebardiv 
{
	list-style-type: none;
	padding: 0px;
	margin: 0px;
	width: 30vh;
	/* background: #FFFAD5; */
	/* border-right: 2px solid gray;
	box-shadow: 0px 0px 20px #000; */
	height: 100%;
	overflow: auto;
	position: relative;
	text-align: center;
}
ul.subSidebar
{
	font-size: small;
}
ul.sidebar, ul.subSidebar
{
	list-style: none;
	padding: 0px;
}
.sidebar li a 
{
	text-decoration: none;
	padding: 10px;
	display: block;
	color: #000;
	font-weight: bold;
}

.sidebar li a:hover 
{
	background: #ffd34e;
	color: #fff;
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
}
.info
{
	background: #ffd34e;
	color: #fff;
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
}
/* 나중에 여기에 내용 적을 때 적용 css */
.cd1 
{
	margin-left: 30vh;
}
</style>

</head>
<body>

<div class="sidebardiv">
	<ul class="sidebar">
		<br>
		<li><h1 style="font-weight: bold; font-size: larger;">마이페이지</h1></li>
		<br>
		<li><a href="myinfo.action">내 정보</a></li>
		<li><a href="#" class="info" style="color: #fff;">내 동아리 활동</a></li>
	</ul>
</div>


</body>
</html>