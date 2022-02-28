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
<title>Join.jsp</title>

<link rel="stylesheet" href="css/bootstrap.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>



<style type="text/css">
/* .outer {
  display: flex;
  align-items: center; 
  flex-direction: row; 
  justify-content: center; 
}
.inner {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
} */

.outer
{
   border: 1px solid #ccc;
   border-radius: 5px;
   width: 100vh;
   padding: 50px;
   margin: 5vh 50vh;
}


</style>
<script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function()   
{
   
   $("#emailText").focusout(function()
   {
      if(!isValidEmail($("#emailText").val()))
         {
            $("#emailText").val("");
            $("#e_msg").html('이메일 형식에 맞지 않습니다.');
            $("#e_msg").css("display","inline");
            return;
         }
         else
         {
            $("#e_msg").html('');
         
         }
   });
   
   
   // 지역 같은값 중복 방지
   $("#region_S_Id2").change(function()
   {
      if( $("#region_S_Id2").val() == $("#region_S_Id1").val())
      {
         alert("이미 선택하신 지역 입니다.");
         $('#region_S_Id2').val('');
         return false;
      }
   });
   
   $("#region_S_Id3").change(function()
   {
      if( $("#region_S_Id3").val() == $("#region_S_Id1").val() || $("#region_S_Id3").val() == $("#region_S_Id2").val())
      {
         alert("이미 선택하신 지역 입니다.");
         $('#region_S_Id3').val('');
         return false;
      }
   });
   
   // 카테고리 같은값 중복 방지
   $("#category_S_Id2").change(function()
   {
      //alert("이미 선택하신 카테고리 입니다.");
      if( $("#category_S_Id2").val() == $("#category_S_Id1").val())
      {
         alert("이미 선택하신 카테고리 입니다.");
         $('#category_L_Id2').val('');
         return false;
      }
   });
   
   $("#category_S_Id3").change(function()
   {
      if( $("#category_S_Id3").val() == $("#category_S_Id2").val() || $("#category_S_Id3").val() == $("#category_S_Id1").val())
      {
         alert("이미 선택하신 카테고리 입니다.");
         $('#category_S_Id3').val('');
         return false;
      }
   });
   
   $("#category_S_Id4").change(function()
   {
      if( $("#category_S_Id4").val() == $("#category_S_Id3").val() || $("#category_S_Id4").val() == $("#category_S_Id2").val()
            || $("#category_S_Id4").val() == $("#category_S_Id1").val())
      {
         alert("이미 선택하신 카테고리 입니다.");
         $('#category_S_Id4').val('');
         return false;
      }
   });
   
   $("#category_S_Id5").change(function()
   {
      if( $("#category_S_Id5").val() == $("#category_S_Id4").val() || $("#category_S_Id5").val() == $("#category_S_Id3").val()
            || $("#category_S_Id5").val() == $("#category_S_Id2").val() || $("#category_S_Id5").val() == $("#category_S_Id1").val())
      {
         alert("이미 선택하신 카테고리 입니다.");
         $('#category_S_Id5').val('');
         return false;
      }
   });
   
    
    //var result = "";
    //alert("test");
    $("#pwd").focusout(function()
    {
       $("#p_msg1").html('');
       if($("#pwd").val()=="")
       {
          $("#p_msg1").html('');
       }
       else if(!isPassword($("#pwd").val()) )
       {   
          $("#p_msg1").html('특수문자을 포함한 숫자, 영어 포함 8~16자를 입력해야 합니다.');
          $("#p_msg1").css("display", "inline");
          $("#pwd").val("");
       }
       
       
    });
    
    // 비밀번호 확인
    $("#pwd2").focusout(function()
    {
       
       if((event.keyCode < 48) || (event.keyCode > 57)) 
       {
          if(navigator.appName=="Netscape")
             event.preventDefault();
          else
             event.returnValue = false;
       }
       
       //alert("test");
       //alert($("#pwd").val() + ":" + $("#pwd2").val());
       $("#p_msg1").html('');
       if($("#pwd2").val()=="")
       {
          $("#p_msg2").html('');
       }
       else if($("#pwd").val()==$("#pwd2").val()&&$("#pwd"))
       {
             
          $("#p_msg2").html('비밀번호가 일치합니다.');
          $("#p_msg2").css("display", "inline");
       }
       
       else
       {
          
          $("#p_msg2").html('비밀번호가 일치하지 않습니다.');
          $("#p_msg2").css("display", "inline");
          $("#pwd2").val("");
          //$("#pwd2").val()="";
       }
    });
    
    // 비밀번호 1과 2 입력후 1을 바꿨을때도 비밀번호 유효성검사 적용되게 하기 위해서 쓴 부분
    $("#pwd").focusout(function()
    {
       
       if((event.keyCode < 48) || (event.keyCode > 57)) 
       {
          if(navigator.appName=="Netscape")
             event.preventDefault();
          else
             event.returnValue = false;
       }
       
       if($("#pwd2").val()=="")
       {
          $("#p_msg2").html('');
       }
       else if($("#pwd").val()==$("#pwd2").val()&&$("#pwd"))
       {
             
          $("#p_msg2").html('비밀번호가 일치합니다.');
          $("#p_msg2").css("display", "inline");
       }
       
       else
       {
          
          $("#p_msg2").html('비밀번호가 일치하지 않습니다.');
          $("#p_msg2").css("display", "inline");
          //$("#pwd2").val("");
          //$("#pwd2").val()="";
       }
    });
    
    $("#tel1").focusout(function()
    {
       
       $("#t_msg").html('');
       if($("#tel1").val()=="")
       {
          $("#t_msg2").html('');
       }
       else if(!isValidPhone($("#tel1").val()) )
       {
          $("#t_msg").html("잘못된 연락처 형식입니다. '-' 포함해서 입력해주세요.");
          $("#t_msg").css("display", "inline");
          $("#tel1").val("");
       }
    });
    
   
   
   
   //각 상황별 alert 창 → required로 했는데 클리어하지가 않아서, 각 상황에 맞게 알림창을 띄우기로했다.
   $("#submitBtn").click(function()
   {
      //alert($("#file").val().length);
      
      /* if ($("#file").val().length == 0)
      {
         alert("사진을 등록해주세요.");
         $("#file").focus();
         return false;
      } */
      if ($("#pwd").val().length == 0)
      {
         alert("비밀번호를 입력해주세요.");
         $("#pwd").focus();
         return false;
      }
      if ($("#pwd2").val().length == 0)
      {
         alert("비밀번호를 다시 입력해주세요.");
         $("#pwd2").focus();
         return false;
      }
      if ($("#tel1").val().length == 0)
      {
         alert("연락처를 입력하세요.");
         $("#tel1").focus();
         return false;
      }
      if ($("#nickName").val().length == 0)
      {
         alert("닉네임을 입력하세요.");
         $("#nickName").focus();
         return false;
      }
      
      if ($("#region_S_Id1").val().length == 0)
      {
         alert("지역은 1개까지 필수 입력사항입니다.");
         $("#region_S_Id1").focus();
         return false;
      }
      
      if ($("#category_L_Id1").val().length == 0)
      {
         alert("카테고리는 1개까지 필수 입력사항입니다.");
         $("#category_L_Id1").focus();
         return false;
      }
      
      
      $("#updateForm").submit();
   });
   
   
   // 닉네임 중복 검사
   $('.input_nickname').keyup(function()
   {
      let nickname = $('.input_nickname').val();   
      var oldnickname = "<c:out value='${info.nickname }'/>";
      
      $.ajax({
         url : "checknickname.action"
         , type : "POST"
         , data : {nickname : nickname}
         , dataType : "json"      
         , success : function(result)
         {
        	 
	        if(result.checkNickName == 0 )
	       	{
	        	 if(nickname == oldnickname)
	       		 {
	        		 $("#checkNickName").html('사용할 수 있는 닉네임입니다.');
	                 $("#checkNickName").css('color', 'green');
	       		 }
	        	 else
        		 {
	               $("#checkNickName").html('사용할 수 없는 닉네임입니다.');
	               $("#checkNickName").css('color', 'red');
	               $('.input_nickname').val('');
        		 }
            }
            else
            {
               $("#checkNickName").html('사용할 수 있는 닉네임입니다.');
               $("#checkNickName").css('color', 'green');
            }
         }
         , error : function(e)
         {
            alert(e.responseText);
         }
      });
   });
   
   
   // 지역 대분류 → 소분류 선택 - 1
   $("#region_L_Id1").change(function()
   {
	   ajaxRegion1();
   });
   
   // 지역 대분류 → 소분류 선택 - 2
   $("#region_L_Id2").change(function()
   {
	   ajaxRegion2();
   });
   
   // 지역 대분류 → 소분류 선택 - 3
   $("#region_L_Id3").change(function()
   {
	   ajaxRegion3();
   });
   
   
   // 카테고리 대분류 → 소분류 선택 - 1
   $("#category_L_Id1").change(function()
   {
	   	ajaxCategory1();
   });
   
   // 카테고리 대분류 → 소분류 선택 - 2
   $("#category_L_Id2").change(function()
   {
	   ajaxCategory2();
   });
   
   // 카테고리 대분류 → 소분류 선택 - 3
   $("#category_L_Id3").change(function()
   {
	   ajaxCategory3();
   });
   
   // 카테고리 대분류 → 소분류 선택 - 4
   $("#category_L_Id4").change(function()
   {
	   ajaxCategory4();
   });
   
   
   // 카테고리 대분류 → 소분류 선택 - 5
   $("#category_L_Id5").change(function()
   {
	   ajaxCategory5();
   });

   ajaxRegion1();
   ajaxRegion2();
   ajaxRegion3();
   ajaxCategory1();
   ajaxCategory2();
   ajaxCategory3();
   ajaxCategory4();
   ajaxCategory5();
});

function isPassword(asValue) {
    
    var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
    return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
    
 }
 
// 지역1 소분류 ajax 
function ajaxRegion1()
{
	 var regionName = "<c:out value='${info.regionName}'/>";
     //alert(regionName);
     $.ajax(
     {
        type : "POST"
        ,url : "ajaxjoinregion.action"
        ,data : {region_L_Id : $("#region_L_Id1").val()}
        ,dataType : "json"
        ,success : function(result)
        {
           //alert(result);
           $("#region_S_Id1").children().remove();
           $("#region_S_Id1").append("<option value=\"\">선택</option>");
           
           for(var i=0; i<result.length; i++)
           {
	           	if(regionName == result[i].local)
	              		$("#region_S_Id1").append("<option value=\""+result[i].region_s_id+"\" selected>"+result[i].local+"</option>");
	           	else
	              		$("#region_S_Id1").append("<option value=\""+result[i].region_s_id+"\">"+result[i].local+"</option>");
           }
        }
        ,error : function(e)
        {
           alert(e.responseText);
        }
     
      });
}

function ajaxRegion2()
{
	var regionName2 = "<c:out value='${info.regionName2}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoinregion.action"
       ,data : {region_L_Id : $("#region_L_Id2").val()}
       ,dataType : "json"
       ,success : function(result)
       {
          $("#region_S_Id2").children().remove();
          $("#region_S_Id2").append("<option value=\"\">선택</option>");
          
          for(var i=0; i<result.length; i++)
          {
        	  if(regionName2 == result[i].local)
             	$("#region_S_Id2").append("<option value=\""+result[i].region_s_id+"\" selected>"+result[i].local+"</option>");
        	  else	
        	  	$("#region_S_Id2").append("<option value=\""+result[i].region_s_id+"\">"+result[i].local+"</option>");
          }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxRegion3()
{
	var regionName3 = "<c:out value='${info.regionName3}'/>";

	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoinregion.action"
       ,data : {region_L_Id : $("#region_L_Id3").val()}
       ,dataType : "json"
       ,success : function(result)
       {
		  $("#region_S_Id3").children().remove();
	      $("#region_S_Id3").append("<option value=\"\">선택</option>");
	          
          for(var i=0; i<result.length; i++)
          {
        	  if(regionName3 == result[i].local)
             	$("#region_S_Id3").append("<option value=\""+result[i].region_s_id+"\">"+result[i].local+"</option>");
        	  else
        	  	$("#region_S_Id3").append("<option value=\""+result[i].region_s_id+"\">"+result[i].local+"</option>");
          }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxCategory1()
{
	var CategoryName1 = "<c:out value='${info.categoryName}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoincategory.action"
       ,data : {category_L_Id : $("#category_L_Id1").val()}
       ,dataType : "json"
       ,success : function(result)
       {
          $("#category_S_Id1").children().remove();
          $("#category_S_Id1").append("<option value=\"\">선택</option>");
          
          for(var i=0; i<result.length; i++)
          {
        	  if(CategoryName1 == result[i].s_cat)
             	$("#category_S_Id1").append("<option value=\""+result[i].category_s_id+"\" selected>"+result[i].s_cat+"</option>");
        	  else
             	$("#category_S_Id1").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
          }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxCategory2()
{
	var CategoryName2 = "<c:out value='${info.categoryName2}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoincategory.action"
       ,data : {category_L_Id : $("#category_L_Id2").val()}
       ,dataType : "json"
       ,success : function(result)
       {
  	   		$("#category_S_Id2").children().remove();
	        $("#category_S_Id2").append("<option value=\"\">선택</option>");
	          
	        for(var i=0; i<result.length; i++)
	        {
	        	if(CategoryName2 == result[i].s_cat)
	           		$("#category_S_Id2").append("<option value=\""+result[i].category_s_id+"\" selected>"+result[i].s_cat+"</option>");
	        	else
	           		$("#category_S_Id2").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
	        		
	        }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxCategory3()
{
	var CategoryName3 = "<c:out value='${info.categoryName3}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoincategory.action"
       ,data : {category_L_Id : $("#category_L_Id3").val()}
       ,dataType : "json"
       ,success : function(result)
       {
    	   	
   	   		$("#category_S_Id3").children().remove();
	        $("#category_S_Id3").append("<option value=\"\">선택</option>");
	          
	        for(var i=0; i<result.length; i++)
	        {
	        	if(CategoryName3 == result[i].s_cat)
	           		$("#category_S_Id3").append("<option value=\""+result[i].category_s_id+"\" selected>"+result[i].s_cat+"</option>");
	        	else
		        	$("#category_S_Id3").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
	        }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxCategory4()
{
	var CategoryName4 = "<c:out value='${info.categoryName4}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoincategory.action"
       ,data : {category_L_Id : $("#category_L_Id4").val()}
       ,dataType : "json"
       ,success : function(result)
       {
          $("#category_S_Id4").children().remove();
          $("#category_S_Id4").append("<option value=\"\">선택</option>");
          
          for(var i=0; i<result.length; i++)
          {
        	  if(CategoryName4 == result[i].s_cat)
             	$("#category_S_Id4").append("<option value=\""+result[i].category_s_id+"\" selected>"+result[i].s_cat+"</option>");
        	  else
             	$("#category_S_Id4").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
          }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
}

function ajaxCategory5()
{
	var CategoryName5 = "<c:out value='${info.categoryName5}'/>";
	
	$.ajax(
    {
       type : "POST"
       ,url : "ajaxjoincategory.action"
       ,data : {category_L_Id : $("#category_L_Id5").val()}
       ,dataType : "json"
       ,success : function(result)
       {
          $("#category_S_Id5").children().remove();
          $("#category_S_Id5").append("<option value=\"\">선택</option>");
          
          for(var i=0; i<result.length; i++)
          {
        	  if(CategoryName5 == result[i].s_cat)
             	$("#category_S_Id5").append("<option value=\""+result[i].category_s_id+"\" selected>"+result[i].s_cat+"</option>");
        	  else
             	$("#category_S_Id5").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
          }
       }
       ,error : function(e)
       {
          alert(e.responseText);
       }
    
     });
	
}
</script>

</head>
<body>
<!-- 
 - 회원가입하기 페이지
 -->
<div>
<!-- nav 영역 -->
<div>
   <c:import url="subHeader.jsp"></c:import>
</div>

<div class="subheader">
      <p>B:CLE</p>
      <p class="title">회원정보 수정</p>
   </div>

<div class="outer">
   <!-- <div class="inner"> -->
      <div class="row register-form">
      <form action="myinfoupdate.action" method="post" id="updateForm" enctype="multipart/form-data">
      	<input type="hidden" name="oldUrl" value="${info.url }">
      	${info.url }
         <p id="err" style="color: red; font-size: small;">* 는 필수 입력사항 입니다.</p><br>
         <div class="form-group col-md-12 col-sm-12">  
            프로필 사진*<br>
            <input type="file" id="file" name="url" value="등록">
         </div>
         <br>
         <div class="id form-group col-md-6 col-sm-6">
            <label for="userId">아이디*
               <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요." value="${info.userId }" class="input_id form-control" readonly="readonly"/>
            </label>
         </div>
         <!-- 변경 -->
            <div class="form-group col-md-12 col-sm-12">
               <label for="email">이메일*</label>
               <input type="email" name="email" id="emailText" placeholder="이메일을 입력하세요." value="${info.email }" class="form-control" readonly="readonly"/>
            </div>
            <!-- 변경 -->
            <div class="form-group col-md-12 col-sm-12">
               <label for="pwd">비밀번호 확인</label>&nbsp;
               <input type="password" id="pwd" name="pwd" placeholder="패스워드를 입력하세요." required="required" class="form-control" />
               <span id="err" style="display: none; color: red; font-size: small;">비밀번호를 입력해주세요.</span><br>
               <span id="p_msg1" style="display: none; color: green; font-size: small;"></span><br>
            </div>
            <!-- 변경 -->
            <div class="form-group col-md-12 col-sm-12">
               <label for="pwd2">비밀번호 재확인*</label>
               <input type="password" id="pwd2" placeholder="패스워드를 다시 입력하세요." required="required" class="form-control"/>
               <!-- <span>안녕하세요</span> -->
               <span id="err" style="display: none; color: red; font-size: small;">비밀번호를 한번 더입력해주세요.</span><br>
               <span id="p_msg2" style="display: none; color: green; font-size: small;"></span><br>
            </div>
            <div class="form-group col-md-12 col-sm-12">
               <label for="tel1">연락처*</label>
               <input type="tel" id="tel1" name="tel" required="required" style="width: 100px" value="${info.tel }"><br>
               <span id="err" style="display: none; color: red; font-size: small;">전화번호를 입력해주세요.</span>
               <span id="t_msg" style="display: none; color: green; font-size: small;"></span><br>
            </div>

         <div class="form-group col-md-6 col-sm-6">
            <label for="nickName">닉네임*</label>
            <input type="text" id="nickName" name="nickName" placeholder="ex) 행복한비클" required="required" class="input_nickname form-control"  value="${info.nickname }">
            <span id=checkNickName  style="font-size: small;"></span><br>
         </div>
         <br>
         <div class="form-group col-md-6 col-sm-6">
            <label for="nickName">첫 번째 지역설정</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">지역은 최소 1개 설정해야합니다.</span><br> -->
            시*
            <select name="region_L_Id1" id="region_L_Id1" required="required" class="form-control">
               <c:forEach var="region" items="${regionLList }">
               		<c:choose>
               			<c:when test="${info.region_L_Id1 eq region.region_l_id}">
                  			<option value="${region.region_l_id }" selected>${region.city }</option>
               			</c:when>
               			<c:otherwise>
                  			<option value="${region.region_l_id }">${region.city }</option>
               			</c:otherwise>
               		</c:choose>
               </c:forEach>
            </select>
            군·구*
            <select name="region_S_Id1" id="region_S_Id1" required="required" class="form-control">
               <option value="-1">군·구 단위</option>
            </select><br>
         </div>
         <div class="form-group col-md-6 col-sm-6">
            <label for="nickName">두 번째 지역설정</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">지역은 최소 1개 설정해야합니다.</span><br> -->
            시
            <select name="region_L_Id2" id="region_L_Id2" required="required" class="form-control">
               <c:forEach var="region" items="${regionLList }">
               		<c:if test="${info.region_L_Id2 != null}"> 
	               		<c:choose>
	               			<c:when test="${info.region_L_Id2 eq region.region_l_id}">
	                  			<option value="${region.region_l_id }" selected>${region.city }</option>
	               			</c:when>
	               			<c:otherwise>
	                  			<option value="${region.region_l_id }">${region.city }</option>
	               			</c:otherwise>
	               		</c:choose>
               		</c:if>
               		<option value="${region.region_l_id }">${region.city }</option>
               </c:forEach>
                    
            </select>
            군·구
            <select name="region_S_Id2" id="region_S_Id2" required="required" class="form-control">
               <option value="-1">군·구 단위</option>
            </select><br>
            <!-- <input type="text" id="regionS2" placeholder="지역2"> -->
         </div>
         <div class="form-group col-md-6 col-sm-6">
            <label for="nickName">세 번째 지역설정</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">지역은 최소 1개 설정해야합니다.</span><br> -->
            시
            <select name="region_L_Id3" id="region_L_Id3" required="required" class="form-control">
               <c:forEach var="region" items="${regionLList }">
                  <c:choose>
               			<c:when test="${info.region_L_Id3 eq region.region_l_id}">
                  			<option value="${region.region_l_id }" selected>${region.city }</option>
               			</c:when>
               			<c:otherwise>
                  			<option value="${region.region_l_id }">${region.city }</option>
               			</c:otherwise>
               		</c:choose>
               </c:forEach>
            </select>
            군·구
            <select name="region_S_Id3" id="region_S_Id3" required="required" class="form-control">
               <option value="-1">군·구 단위</option>
            </select><br>
            <!-- <input type="text" id="regionS3" placeholder="지역3"> -->
         </div>
         <br>
         <div class="form-group col-md-6 col-sm-6">
            <label for="category">첫 번째 관심 카테고리*</label>
            <select name="category_L_Id1" id="category_L_Id1" required="required" class="form-control">
               <option value="">카테고리 선택</option>
               <c:forEach var="category" items="${categoryLList }">
               		<c:choose>
               			<c:when test="${info.add_category_id == category.category_l_id}">
		                  	<option value="${category.category_l_id }" selected>${category.l_cat }</option>
               			</c:when>
               			<c:otherwise>
		                  	<option value="${category.category_l_id }">${category.l_cat }</option>
               			</c:otherwise>
               		</c:choose>
               </c:forEach>
            </select><br>
            <select name="category_S_Id1" id="category_S_Id1" required="required" class="form-control">
               <option value="-1">카테고리 상세선택</option>
            </select><br>
         </div>
         <div class="form-group col-md-6 col-sm-6">
            <label for="category">두 번째 관심 카테고리</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">관심카테고리는 최소 1개 설정해야합니다.</span><br> -->
            <select name="category_L_Id2" id="category_L_Id2"  class="form-control">
               <option value="">카테고리 선택</option>
               <c:forEach var="category" items="${categoryLList }">
                   <c:choose>
               			<c:when test="${info.categoryId2 == category.category_l_id}">
		                  	<option value="${category.category_l_id }" selected>${category.l_cat }</option>
               			</c:when>
               			<c:otherwise>
		                  	<option value="${category.category_l_id }">${category.l_cat }</option>
               			</c:otherwise>
               		</c:choose>
               </c:forEach>
            </select><br>
            <select name="category_S_Id2" id="category_S_Id2" class="form-control">
               <option value="-1">카테고리 상세선택</option>
            </select><br>
         </div>
         
         <div class="form-group col-md-6 col-sm-6">
            <label for="category">세 번째 관심 카테고리</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">관심카테고리는 최소 1개 설정해야합니다.</span><br> -->
            <select name="category_L_Id3" id="category_L_Id3"  class="form-control">
               	<option value="">카테고리 선택</option>
               	<c:forEach var="category" items="${categoryLList }">
                    <c:choose>
               			<c:when test="${info.categoryId3 == category.category_l_id}">
		                  	<option value="${category.category_l_id }" selected>${category.l_cat }</option>
               			</c:when>
               			<c:otherwise>
		                  	<option value="${category.category_l_id }">${category.l_cat }</option>
               			</c:otherwise>
               		</c:choose>
              	</c:forEach>
            </select><br>
            <select name="category_S_Id3" id="category_S_Id3" class="form-control">
               <option value="-1">카테고리 상세선택</option>
            </select><br>
            <!-- <input type="text" id="category3" placeholder="카테고리3"> -->
         </div>
         
         <div class="form-group col-md-6 col-sm-6">
            <label for="category">네 번째 관심 카테고리</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">관심카테고리는 최소 1개 설정해야합니다.</span><br> -->
            <select name="category_L_Id4" id="category_L_Id4"  class="form-control">
               	<option value="">카테고리 선택</option>
               	<c:forEach var="category" items="${categoryLList }">
                   	<c:choose>
               			<c:when test="${info.categoryId4 == category.category_l_id}">
		                  	<option value="${category.category_l_id }" selected>${category.l_cat }</option>
               			</c:when>
               			<c:otherwise>
		                  	<option value="${category.category_l_id }">${category.l_cat }</option>
               			</c:otherwise>
               		</c:choose>
                </c:forEach>
            </select><br>
            <select name="category_S_Id4" id="category_S_Id4" class="form-control">
               <option value="-1">카테고리 상세선택</option>
            </select><br>
            <!-- <input type="text" id="category4" placeholder="카테고리4"> -->
         </div>
         
         <div class="form-group col-md-6 col-sm-6">
            <label for="category">다섯 번째 관심 카테고리</label>
            <!-- <span id="err" style="display: none; color: red; font-size: small;">관심카테고리는 최소 1개 설정해야합니다.</span><br> -->
            <select name="category_L_Id5" id="category_L_Id5" class="form-control">
               	<option value="">카테고리 선택</option>
               	<c:forEach var="category" items="${categoryLList }">
                   	<c:choose>
               			<c:when test="${info.categoryId5 == category.category_l_id}">
		                  	<option value="${category.category_l_id }" selected>${category.l_cat }</option>
               			</c:when>
               			<c:otherwise>
		                  	<option value="${category.category_l_id }">${category.l_cat }</option>
               			</c:otherwise>
               		</c:choose>
                </c:forEach>
            </select><br>
            <select name="category_S_Id5" id="category_S_Id5" class="form-control">
               <option value="-1">카테고리 상세선택</option>
            </select><br>
            <!-- <input type="text" id="category5" placeholder="카테고리5"> -->
         </div>
         
         <div class="form-group col-md-12 col-sm-12" style="text-align: center;">
            <!-- <span id="err" style="display: none; color: red; font-size: small;">회원가입의 항목들을 모두 입력해주세요.</span><br> -->
            <input type="button" value="수정하기" id="submitBtn" class="btn btn-warning">
            <input type="button" value="취소" class="btn btn-warning"
            onclick="javascript:location.href='<%=cp%>/myinfo.action'">
         </div>
      </form>
      </div>
   <!-- </div> -->
   
</div>

   <div>
      <c:import url="footer.jsp"></c:import>
   </div>

</div>

</body>
</html>