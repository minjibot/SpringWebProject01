<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags"%>
<%
   request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ClubBeforeOpenedList.jsp</title>
<link rel="stylesheet" href="css/mainpage.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>


<style>
@import
   url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
   ;

.cate {
   
   margin-left : 30vh;
   margin-right : 30vh;
   margin-bottom : 5vh;
   text-align : center;
   padding : 3vh;
   border : 1px solid lightgray;
   border-radius : 0px 0px 20px 20px;
}

.cate img {width : 100%; height : 100%;}

img {
    width: 100%;
    height: 100%;
    transition: all .8s;
}

.card-body {height : 30vh; padding: 0rem;} 
/* 사진 꽉 차게 조정하기 */



.pagination{
   margin-bottom : 10vh;
}

button {border:none;}
button:active {
  outline: none;
  box-shadow: none;
}

.list_title{margin-top :5vh; text-align:center;}

.category{
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
   margin: 5vh 0vh 5vh 0vh;
}

.region{
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
   margin: 0vh 0vh 5vh 0vh;

}

select {
   color:white;
   background : gray;
   border-radius: 5px;
   padding : 5px;
}

.upper{

margin-left :30vh; 
margin-right : 30vh;
margin-bottom : 0vh;
padding : 3%;
background-color : #F2F2F2;
border-radius : 20px 20px 0px 0px;
}

.cate{
   margin-top:0vh;
}

.search{
   display : flex;
   padding-bottom : 10px;
   border-bottom: 1px solid lightgray;
}

.list-title{margin-top : 5vh;}

.searchBox input {   border : 1px solid lightgray;    height : 5vh; margin-right : 0vh; }
.searchBox button { margin-left : 0vh;    height : 5vh; padding-left : 5px; padding-right : 5px; border-radius : 0px 5px 5px 0px; background : orange; color:white;}
.search select {border-radius : 5px 0px 0px 5px;}
.card-body {padding : 0% ;}
.card-body img {width : 100%; height:100%;}

.contents a:hover{ color: orange; text-decoration: none;}

</style>
<script type="text/javascript">
   
$(document).ready(function()
{
   
   //카테고리 대분류(category_L_Id)가 변경되었을 경우 수행해야 할 코드 처리
   $("#category_l").change(function()
   {
      //lert($("#category_L_Id").val());
      
      // Ajax 요청 및 응답 처리
      $.ajax(
      {
         type : "POST"
         ,url : "ajaxcategory.action"
         ,data : {category_L_Id : $("#category_l").val()}
         ,dataType : "json" //{key : vlaue}
         ,success : function(result)
         {
            $("#category_s").children().remove();
            $("#category_s").append("<option value=\"\">소분류</option>");
            
            for(var i=0; i<result.length; i++)
            {
               $("#category_s").append("<option value=\""+result[i].category_s_id+"\">"+result[i].s_cat+"</option>");
            }
            
         }
         ,error : function(e)
         {
            alert(e.responseText);
         }
      });
   });
   
   //지역 대분류(region_L_Id)가 변경되었을 경우 수행해야 할 코드 처리 
   $("#region_l").change(function()
   {
      //alert('변경');
      //alert($("#region_L_Id").val());
      
      $.ajax(
      {
         type : "POST"
         ,url : "ajaxregion.action"
         ,data : {region_L_Id : $("#region_l").val()}
         ,dataType : "json"
         ,success : function(result)
         {
            $("#region_s").children().remove();
            $("#region_s").append("<option value=\"\">군/구</option>");
            
            for(var i=0; i<result.length; i++)
            {
               $("#region_s").append("<option value=\""+result[i].region_s_id+"\">"+result[i].local+"</option>");
            }
         }
         ,error : function(e)
         {
            alert(e.responseText);
         }
      
       });

   });
   
   ajaxRequest(1);
   
   
   $("#searchBtn").click(function()
   {
      ajaxRequest(1);               
   });
   $("#category_l").change(function()
   {
      ajaxRequest(1);               
   });
   $("#category_s").change(function()
   {
      ajaxRequest(1);               
   });
   $("#region_l").change(function()
   {
      ajaxRequest(1);               
   });
   $("#region_s").change(function()
   {
      ajaxRequest(1);               
   });
   $("#sort").change(function()
   {
      ajaxRequest(1);               
   });
   
});

//동아리 리스트, 페이징 처리
function ajaxRequest(pageNum)
{
   var keyword = "";
     
     if($.trim($("#searchValue").val()) != "")
        keyword = $.trim($("#searchValue").val());
    
   var params = "category_l_id=" + $("#category_l option:selected").attr("value") +"&category_s_id=" + $("#category_s option:selected").attr("value")
   +"&region_l_id=" + $("#region_l option:selected").attr("value")+"&region_s_id="+ $("#region_s option:selected").attr("value") 
   +"&keyword=" + keyword +"&sortOrder=" + $("#sort option:selected").attr("value")+ "&pageNum=" + pageNum;
   
   
   $.ajax(
   {   
      //alert("test");
      type : "POST"
      , url : "ajaxpreclublist.action"
      , data : params
      , dataType : "json"
      , success : function(jsonObj)
      {
         var str = "";
         
         if(jsonObj.length-1 == 0)
            str = "<p style='font-size : 24px; text-align: center; margin-top: 15vh; margin-bottom: 15vh;'>개설된 동아리가 없습니다.</p>";
         
         str += "<div class = 'cate'>";
         str += "         <div class='row' style= 'font-family: 'Noto Sans KR', sans-serif; font-weight:bold;'>";
         
         for(var idx=0; idx<(jsonObj.length)-1; idx++)      // 배열방 만큼 반복문 순환
         {
            var cid = jsonObj[idx].cid;
            var url = jsonObj[idx].url;
            var title = jsonObj[idx].title;
            var day = jsonObj[idx].day;
            
            str += "           <div class='col-sm-4'>";
            str += "             <div class='card'>";
            str += "               <div class='card-body' style='padding : 0vh;''>";
            str += "               <a href='preopenclubdetail.action?cid="+cid+"'>";
            str += "                   <img src='"+url+"' alt='...' style='width: 100%;'>";
            str += "                <div class='caption'>";
            str += "               <!-- 이미지 밑의 글귀 -->";
            str += "               </div>";
            str += "               </div>";
            str += "             </div>";
            str += "                <h6>"+title+"</h6>";
            str += "               <p>D - "+day+"</p> </a>";
            str += "               <br>";
            str += "           </div>";
            
         }
         str += "           </div>";
         
         $("#ClubList").html(str);
         
          var pageIndexList = jsonObj[(jsonObj.length)-1].pageIndexList;
         pageIndexList = "<nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
                     + pageIndexList + "</ul></nav>";
         $("#pageIndexList").html(pageIndexList); 
         
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
ClubBeforeOpenedList.jsp
- 메인화면(로그인 전) 페이지 2 -⑤ 회원 모집 동아리 리스트
 -->

   <!-- nav 영역 -->
   <div>
      <c:import url="/nav.action"></c:import> 
   </div>
   <!-- 컨텐츠영역 -->
      <section class="list-title">
         <div class="title">
            <h2>Pre-open Club<span>.</span></h2>
            <p>개설 예정 동아리의 운영진이 되어보세요</p>
         </div>
      </section>
   
   <div class="upper">
         
         
         <div class="category">
            카테고리 <select id="category_l" name="category_l">
               <option value="" >대분류</option>
               <c:forEach var="category" items="${categoryLList }">
                  <option value="${category.category_l_id }">${category.l_cat }</option>
               </c:forEach>
            </select> <select id="category_s" name="category_s">
               <option value="" >소분류</option>
            </select>
         </div>
         <div class="region">
         지역 <select id="region_l" name="region_l">
               <option value="" >시</option>
               <c:forEach var="region" items="${regionLList }">
                  <option value="${region.region_l_id }" >${region.city }</option>
               </c:forEach>
            </select> <select id="region_s" name="region_s">
               <option value="">군/구</option>
            </select>
         </div>

         <div class="search">
            <select id="sort" name="sort">
               <!-- 동아리 정렬 방법 -->
               <option value="desc" >최신순</option>
               <option value="asc" >등록순</option>
            </select> 
             <div class="searchBox">
                 <input type="text" placeholder="검색할 동아리명을 입력하세요" id="searchValue" name="searchValue" >
              <button type="button" id="searchBtn" class="btn" >검색하기</button> 
              <!-- <span id="searchBtn" class="searchBtn"><button>검색하기</button></span> -->
            </div>
         </div>
   </div>
      
      

   <br>
   <br>
   
<div id="contents" class="contents">
   <div id="ClubList">
   
      <%-- <div class = "cate">
         <div class="row" style= "font-family: 'Noto Sans KR', sans-serif; font-weight:bold;">
         <c:forEach var="preclub" items="${preopenList}">
           <div class="col-sm-4">
             <div class="card">
               <div class="card-body" style="padding : 0vh;">
               <a href="preopenclubdetail.action?cid=${preclub.cid}"> <img src="${preclub.url}" alt="${preclub.title}" style="width: 100%;"></a>
                <div class="caption">
               <!-- 이미지 밑의 글귀 -->
               </div>
               </div>
             </div>
                <p>${preclub.title}</p>
               <div>D - ${preclub.day}</div>
               <br>
           </div>
           </c:forEach>
           </div>
           
      </div> --%>
   
   </div>
   
 <!-- 페이지네이션 -->
   <div class="col-md-12"  id="pageIndexList">
      
   </div>

</div>

   


   <!-- 풋터영역 -->
   <div>
      <c:import url="footer.jsp"></c:import>
   </div>

</body>
</html>