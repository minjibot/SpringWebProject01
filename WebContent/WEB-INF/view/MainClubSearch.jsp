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
<title>CategoryPage.jsp</title>
<link rel="stylesheet" href="css/mainpage.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"> 
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<style>
@import
   url('https://fonts.googleapis.com/css?family=Exo+2|Noto+Sans+KR&display=swap')
   ;

/* 
 .contents{
   margin : 5vh 34vh 5vh 30vh; 
   margin : 5vh 30vh 5vh 30vh; 
   padding : 3%;
   border : 1px solid lightgray;
   border-radius : 20px;
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
}  */
.card{
/* margin-left : 5vh; */
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

.list-title{margin-top : 5vh;}

#contents {
    margin : 0vh 34vh 5vh 30vh; 
    
 /*   padding : 3%; */
   padding-left : 3%;
   padding-right : 3%;
   padding-bottom : 3%;
  /*  border : 1px solid lightgray; */
   border-radius : 20px;
   font-family: 'Noto Sans KR', sans-serif; 
   font-weight:bold;
}

#searchSet {
/* margin-top : 5vh; */
/* margin-left :30vh;  */
margin-right : 30vh;
margin-bottom : 0vh;
padding : 3%;
background-color : #F2F2F2;
border-radius : 20px 20px 0px 0px;
text-align: center;
width: 100%;
}

select {
   color:white;
   background : gray;
   border-radius: 5px;
   padding : 5px;

}

.contents a:hover{ color: orange;}
/* #accountSelect{
margin : 10vh 0vh 10vh 40vh;
} */

.card-body p{ margin-top: 1vh;}
</style>
<script type="text/javascript">

$(document).ready(function()
{
   
   //카테고리 대분류(category_l)가 변경되었을 경우 수행해야 할 코드 처리
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
   
   //지역 시(region_l)가 변경되었을 경우 수행해야 할 코드 처리
   $("#region_l").change(function()
   {
      //alert($("#region_l").val());
      
      $.ajax(
      {
         type : "POST"
         ,url : "ajaxregion.action"
         ,data : {region_L_Id : $("#region_l").val()}
         ,dataType : "json"
         ,success : function(result)
         {
            //alert(result);
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
   var keyword = '${keyword}';
    
     var params = "category_l_id=" + $("#category_l option:selected").attr("value") +"&category_s_id=" + $("#category_s option:selected").attr("value")
    +"&region_l_id=" + $("#region_l option:selected").attr("value")+"&region_s_id="+ $("#region_s option:selected").attr("value") 
    +"&keyword=" + keyword +"&sortOrder=" + $("#sort option:selected").attr("value")+ "&pageNum=" + pageNum;
    
   
   $.ajax(
   {   
      //alert("test");
      type : "POST"
      , url : "ajaxclubsearchlist.action"
      , data : params
      , dataType : "json"
      , success : function(jsonObj)
      {
         var str = "";
         
         if(jsonObj.length-1 == 0)
            str = "<p style='font-size : 24px; text-align: center; margin-top: 15vh; margin-bottom: 15vh;'>개설된 동아리가 없습니다.</p>";
         
         for(var idx=0; idx<(jsonObj.length)-1; idx++)      // 배열방 만큼 반복문 순환
         {
            var cid = jsonObj[idx].cid;
            var url = jsonObj[idx].url;
            var title = jsonObj[idx].title;
            var city = jsonObj[idx].city;
            var local = jsonObj[idx].local;
            var count = jsonObj[idx].count;
            var max = jsonObj[idx].max;
            var bdate = jsonObj[idx].bdate;
            var agelimit_id = jsonObj[idx].agelimit_id;
            var limit_id = jsonObj[idx].limit_id;
            var min_age = jsonObj[idx].min_age;
            var max_age = jsonObj[idx].max_age;
            
            
            str += "         <a href='clubmain.action?cid=" + cid+"' style='text-decoration: none; '>";
            str += "            <div class='card mb-3' >";
            str += "            <div class='row g-0'>";
            str += "               <div class='col-md-4'>";
            str += "                  <img src='"+ url + "' class='img-fluid rounded-start' alt='...'>";
            str += "               </div>";
            str += "               <div class='col-md-8'>";
            str += "                  <div class='card-body'>";
            str += "                     <h5 class='card-title'>" + title + "</h5>";
            
            str += "                        <p class='card-text'>" + city + " - " + local + " </p>";
            str += "                        <p class='card-text'>인원수 : (" + count + " / " + max + ")</p>";
            
            if(limit_id == "X")
               str += "                        <p class='card-text'> 지역제한 : 있음 </p>";
            else
               str += "                        <p class='card-text'> 지역제한 : 없음 </p>";
            
            if(agelimit_id == "O")
               str += "                        <p class='card-text'> 나이제한 : " + min_age + " ~ " + max_age + " </p>";
            else
               str += "                        <p class='card-text'> 나이제한 : 없음 </p>";
               
            str += "                        <p class='card-text'><small class='text-muted'>개설일 " + bdate + "</small></p>";
            str += "                  </div>";
            str += "               </div>";
            str += "            </div>";
            str += "            </div>";
            str += "         </a><br>";
         
             
         }
         
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
- 메인화면(로그인 전) 페이지 2 -③ 카테고리 상세 페이지 

 -->
 
<!-- nav 영역 -->
<div>
   <c:import url="nav.jsp"></c:import>
</div>

<!-- 컨텐츠 영역 -->
<div>
<section class="list-title">
         <div class="title">
            <h2>Club<span>.</span></h2>
            <p>동아리를 구경하고 가입해보세요</p>
         </div>
      </section>
   <div id="contents" class="contents">

      <div id="searchSet">
      
         <div style="margin-top : 0vh; margin-bottom: 2vh;">
         
         <!-- 카테고리 -->
         <select id="category_l"  style="display: none;">
            <option value="" >대분류</option>
            <c:forEach var="cl" items="${cateL }">
               <option value="${cl.category_l_id }">${cl.l_cat }</option>
            </c:forEach>
         </select>
         
         <select id="category_s" style="display: none;">
            <option value="" >소분류</option>
         </select>
         <br><br>
         지역
         <select id="region_l">
            <option value="" >시</option>
            <c:forEach var="rl" items="${regionL }">
               <option value="${rl.region_l_id }">${rl.city }</option>
            </c:forEach>
         </select>
         
         <select id="region_s">
            <option value="">군/구</option>
         </select>
         <br><br>
         
         
         정렬
         <select id="sort" >
            <option value="desc" >최신순</option>
            <option value="asc">등록순</option>
         </select>
         
   
      </div>
   </div>
   

   <div id="ClubList">
   
   </div>
      
    
    <div class="col-md-12"  id="pageIndexList">
      
   </div>
    
   </div> <!-- end contents -->
   
   
     
    <!-- 풋터영역 --> 
    <div>
       <c:import url="footer.jsp"></c:import>    
    </div> 

</div>
</body>
</html>