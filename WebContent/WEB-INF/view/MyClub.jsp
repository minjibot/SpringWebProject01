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
<title>MyClub.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript">
	$(document).ready(function()
    {
		var today = new Date();
  		
  		document.getElementById("txtYear").value = today.getFullYear();
  		document.getElementById("txtMonth").value = today.getMonth()+1;
  		
	    showMyClub();
	    getClubList();
	    
        $("input[name='btnradio']").change(function()
	    {
    	    getClubList();
	    });
        
        $("#prev").click(function()
		{
      		if(parseInt(document.getElementById("txtMonth").value) == 1)
   			{
      			document.getElementById("txtYear").value = parseInt(document.getElementById("txtYear").value)-1;
      			document.getElementById("txtMonth").value = 12;
   			}
      		else
      		{
      			document.getElementById("txtMonth").value = parseInt(document.getElementById("txtMonth").value) - 1;
      		}	
      		
      		showCal();
		});
        
        $("#next").click(function()
   		{
       		if(parseInt(document.getElementById("txtMonth").value) == 12)
   			{
      			document.getElementById("txtYear").value = parseInt(document.getElementById("txtYear").value)+1;
      			document.getElementById("txtMonth").value = 1;
   			}
       		else
       		{
       			document.getElementById("txtMonth").value = parseInt(document.getElementById("txtMonth").value) + 1;
       		}	
       		
       		showCal();
   		});
        
        $("#txtYear").focusout(function()
		{
        	showCal();
		});
        
        $("#txtMonth").focusout(function()
   		{
           	showCal();
   		});
      
        showCal();
        
        $("#status").change(function()
        {
			$("#clublist").append("<p><input class='radioClub' type='radio' name='radioClub' id='radioClub0' value='total' checked='checked' onclick='showCal()'><label for='radioClub0'>??????</label></p>");
			showMyClub();
			showCal();
        });
        
    });
   
    // ?????? ????????? ????????? ???????????? ajax ??????
   	function showMyClub()
	{
   		$.ajax(
         {
            type : "POST"
            ,url : "ajaxmyclub.action"
            ,data : {status : $("#status").val()}
            ,dataType : "json" //{key : value}
            ,success : function(result)
            {
               $("#clublist").html("");
               if(result.length != 0)
               		$("#clublist").append("<p><input class='radioClub' type='radio' name='radioClub' id='radioClub0' value='total' checked='checked' onclick='showCal()'><label for='radioClub0'>??????</label></p>");
               
               for(var i=0; i<result.length; i++)
               {
            	   $("#clublist").append("<p><input class='radioClub' type='radio' name='radioClub' id='radioClub" + (i+1) + "' value='"+ result[i].cid +"' onclick='showCal()'><label for='radioClub" + (i+1) + "'>" + result[i].title + "</label><a href='#'></a></p>");
               } 
               
                if(result.length == 0)
           		{
	           	   $("#calendarTbl").empty();
	           	   $("#calendarTbl").html("???????????? ??????????????????!");
           		}
            }
            ,error : function(e)
            {
               alert(e.responseText);
            }
         });
	}
   	
    // ????????????, ???????????? ?????????
   	function getClubList()
	{
   		$("input[name='btnradio']").each(function()
		{
			var value = $(this).val();
			var checked = $(this).prop('checked');
			var $label = $(this).next();
			
			if(checked)
			{
				//alert(value);
				// Ajax ?????? ??? ?????? ??????
		         $.ajax(
		         {
		            type : "POST"
		            ,url : "ajaxgetclub.action"
		            ,data : {value : value}	// join or preopen ??? ?????????
		            ,dataType : "json" //{key : value}
		            ,success : function(result)
		            {
		            	var str = "";
		            	$("#showClub").html("");
		            	//str += "<div class='row'>";
		               for(var i=0; i<result.length; i++)
		               {
		            	    if (i%3 == 0)
		            		{
		            	    	/* $("#showClub").append("</div>");
					            $("#showClub").append("</div>");
					            $("#showClub").append("<div class='carousel-item active container'>"); */
					            
					            /* str += "</div>";
					            str += "</div>";
					            str += "<div class='carousel-item active container'>";
					            str += "<div class='row'>"; */

		            		}
		            		
			               //??????????????? ???????????? ?????? ?????? ????????? ???????????? ???????????? ???????????? ???. (??????)
			               // ?????? ?????? ???????????? <span class="badge bg-secondary">New</span>
			               	str += "<div class='col' style='padding-bottom: 10px; margin-right:20px;'>";
			               	str += "	<div class='card' style='width: 18rem; '>";
			               	
			               	if (value == "preopen") // ???????????????????????????
			               		str += "	<a href='preopenclubdetail.action?cid=" + result[i].cid + "' style='text-decoration: none;'>";
			               	else // ???????????? ???????????????
			               	{
			               		if (result[i].bdate == null)
			               			str += "	<a href='preopenclubdetail.action?cid=" + result[i].cid + "' style='text-decoration: none;'>";
			               		else
			               			str += "	<a href='clubmain.action?cid=" + result[i].cid + "' style='text-decoration: none;'>";
			               	}
		         		   	//str += "			<img src='"+ result[i].url +"' class='card-img-top' alt='...'>";
		         		   	
		         		   	str += "			<div class='row'>";	
		         		   	str += "				<div class='col' style='padding: 0;'>";	
		         		   	
		         		   	str += "					<img style='' src='images/profile.png' class='card-img-top' alt='...'>";
		         		   	
		         		   	str += "				</div>";
		         		   	str += "				<div class='col' style='padding: 0;'>";	
		         		   	
		         		   	str += "					<div class='card-body'>";
		         		   	//str += "						<p class='card-text'>" + result[i].title + ":" + result[i].preopendate + "</p>";
		         		   	str += "						<p class='card-text' style='font-weight: bold; font-size: larger;'>" + result[i].title + "</p>";
		         		   	//str += " <hr> ";
		         		   	if (value == "preopen")
		         		   		str += "						<p class='card-text' style='font-size:smaller; color: gray;'>?????????: " + result[i].preopendate.substring(0, 10) + "</p>";
		         		   	else 
		         		   		str += "						<p class='card-text' style='font-size:smaller; color: gray;'>?????????: " + result[i].joinDate.substring(0, 10) + "</p>";
		         		   			
		         			str += "					</div>";
		         			
		         			str += "				</div>";
		         			
    	  					str += "			</div>";
    	  					str += "		</a>";
    	  					str += "	</div>";
    	  					str += "</div>";
		               }
			           //str += "</div>";
		               $("#showClub").html(str);
		               
							
		            }
		            ,error : function(e)
		            {
		               alert(e.responseText);
		            }
		         });
			}
				
		})
	}
   
   	function showCal()
	{
   		$("#calendarTbl").empty();
		//alert("test");
		
		var year = parseInt(document.getElementById("txtYear").value);
        var month = parseInt(document.getElementById("txtMonth").value);
        //alert(year + month);
        
		var days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        
        if (year%4 == 0 && year%100 != 0 && year%400 == 0)
           days[1] = 29;
        
        var nalsu = (year-1)*365 + parseInt((year-1)/4) - parseInt((year-1)/100) + parseInt((year-1)/400);
        
        for (var i = 0; i < month-1; i++)
        {
           nalsu = nalsu + parseInt(days[i]);
        }
        //alert(nalsu);
        
        var yoil = Number(nalsu)%7;
        var copyYoil = yoil;
        //alert(yoil);
        
        // table ???????????? ??????
        var tableNode = document.getElementById("calendarTbl");
        
        $("#calendarTbl").append("<tr><tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>");
         
         var trNode = document.createElement("tr");      // <tr></tr>
         
         // ?????? ??????
         if(copyYoil != 6)
        {
           for (var j = 0; j <= copyYoil; j++)
           {
               trNode.appendChild(createTdNode(" "));
               tableNode.appendChild(trNode);
           }
        }
		
		$("input[name='radioClub']").each(function()
		{
			//value = "radioClub0";
			//alert(value);
			var value = $(this).val();	// ???????????????
			var checked = $(this).prop('checked');
			var $label = $(this).next();
			
			if(checked)
			{
				// IF????????? ????????? ?????? ?????? ?????? ??????
				// ????????? ?????? AJAX??? ??????
				
				 //alert(value);
				 var params = "cid=" + value + "&year=" + year + "&month=" + month +"&status=" + $("#status").val();
				
				 // Ajax ?????? ??? ?????? ??????
		         $.ajax(
		         {
		            type : "POST"
		            ,url : "ajaxmypagecal.action"
		            ,data : params
		            ,dataType : "json" //{key : value}
		            ,success : function(result)
		            {
		            	var str = "";
		            	//$("#showClub").html("");
		            	//str += "<div class='row'>";
		            	
		            	alert(result.length);
		            	
		            	 // ?????? ??????
				         for (var i = 1; i <= days[month-1]; i++)
				         {
				        	 
				            if( (yoil + i)%7==0 )
				            {
				               trNode = document.createElement("tr");
				            }
				            
				            // ajax ?????????
				            if (result.length == 0) // ??? ?????? ???????????? ?????? ?????????
			            	{
				            	trNode.appendChild(createTdNode(i)); // ????????? ??????
			            	}	
				            else					// ??? ?????? ???????????? ?????? ?????????
				            {
		            	       // td ?????? ?????????
		            	       var tdNode = document.createElement("td");
		            	       
		            	       // td ?????? ?????? ??????
		            	       tdNode.appendChild(document.createTextNode(i));
		            	       
				            	// ?????? ???????????? ??? ?????? ????????? ??????... ???????
				            	for(var j=0; j<result.length; j++)
				                {
				            	   if(result[j].beeTime.substring(8, 10) == i) // ?????? ????????? 
				            	   {
				            		   //alert("test");
				            	        
				            	       // td ?????? br ??????
				            	       tdNode.appendChild(document.createElement("br"));

				            	       // a ?????? ?????????
				            	       var aTag = document.createElement("a");
				            	       
				            	       // td ?????? a?????? ??????
				            	       tdNode.appendChild(aTag);
				            	       
				            	       // href ??????
				            	       aTag.href = "beedetailpage.action?beeId=" + result[j].beeId + "&cid=" + result[j].cid;
				            	       
				            	       // a ????????? ??? ?????????
				            	       var aTagTextNode = document.createTextNode("????" + result[j].title);
				            	       
				            	       // a ?????? ?????? ????????? ??????
				            	       aTag.appendChild(aTagTextNode);
				            	       
				            	   }
				            	   
				                } 
				            	// td ?????? br ??????
			            	    tdNode.appendChild(document.createElement("br"));
				            	
				            	trNode.appendChild(tdNode);
				            }
				            
				            
				            //trNode.appendChild(createTdNode(i));
				            tableNode.appendChild(trNode);
				            
				         }
		            	
							
		            }
		            ,error : function(e)
		            {
		               alert(e.responseText);
		            }
		         });
			}
				
		})

	}
   	
   	function createTdNode(val)
    {
       var textNode = document.createTextNode(val);
       
       // td ?????? ?????????
       var tdNode = document.createElement("td");
       
       // td ?????? ?????? ??????
       tdNode.appendChild(textNode);
       
       // td ?????? br ??????
       /* tdNode.appendChild(document.createElement("br"));*/

       return tdNode;
    }
   	


</script>
<style>

td
{
	width: 90px;
	height: 70px;
	text-align: left;
	vertical-align: top;
	padding: 5px;
	padding-left: 10px;
	/* border: 10px solid gray;
	border-radius: 5px; */
}
td > a
{
	text-decoration: none;
	font-size: small;
}
td > a:hover
{
	color: orange;
	text-decoration: none;
}

.radioClub
{
	display: none;
}

input[type=radio]:checked + label
{
	color: orange;
	font-weight: bold;
}

#clubcontent {
  	width: 40%;
  	white-space: nowrap;
  	overflow: hidden;
  	text-overflow: ellipsis;  /* ????????? ?????? */
}

.col
{
	/* padding-left: 0px;
	padding-right: 0px; */
}

table
{
	width: 100%;
	border-radius: 30px;
}
#txtYear, #txtMonth
{
	border-color: #ebebeb;
}
th
{
	background-color: #ebebeb;
}
</style>
</head>
<body>
<!-- 
MyClub.jsp
- ??????????????? - ?????? ????????? ??????
 -->

<div>
	<!-- ?????? ?????? -->
	<div>
		<c:import url="nav.jsp"></c:import>
	</div>


	<!-- ?????? ?????? -->
	<div style="float: left;">
		<c:import url="MyPageSideTab2.jsp"></c:import>
	</div>

	<!-- ????????? ?????? -->
	<div id="content" style="margin-left: 5vh; margin-right: 20vh; float: left; width: 70%;"><!-- ??? ???????????? ?????? -->
		<br>
		<h1 class="display-6">?????? ????????? ??????</h1>
		<hr>

		<div class="container">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-6">
					<select id="status">
						<option value="0" selected="selected">?????????</option>
						<option value="1">?????? ??????</option>
					</select>
					<div id="clublist">
						<!-- ????????? ?????? ?????? -->
						<p><input class='radioClub' type='radio' name='radioClub' id='radioClub0' value='total' checked='checked' onclick='showCal()'><label for='radioClub0'>??????</label></p>
					</div>
				</div>
				<div class="col-lg-10 col-md-9 col-sm-6" style="text-align: center;">
					<button id="prev" style="border: none; background: none; color: orange;">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-left" viewBox="0 0 16 16">
  							<path d="M10 12.796V3.204L4.519 8 10 12.796zm-.659.753-5.48-4.796a1 1 0 0 1 0-1.506l5.48-4.796A1 1 0 0 1 11 3.204v9.592a1 1 0 0 1-1.659.753z"/>
						</svg>
					</button>
					
					<input type="text" id="txtYear" class="txt form-control-sm" style="text-align: center; width: 10%;"> ??? &nbsp;&nbsp;&nbsp;
					<input type="text" id="txtMonth" class="txt form-control-sm" style="text-align: center; width: 5%;"> ??? 
					
					<button id="next" style="border: none; background: none; color: orange;">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right" viewBox="0 0 16 16">
  							<path d="M6 12.796V3.204L11.481 8 6 12.796zm.659.753 5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
						</svg>
					</button>
					
			        <br><br>
					<div id="cal">
					
					</div>
					
					<table class="" border="1" id="calendarTbl" style="">
			            
			         </table>
												
				</div>
			</div>
		</div>
		
		<br>
		<br>
		
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="font-size: smaller;">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" value="join" autocomplete="off" checked>
			  <label class="btn btn-outline-warning" for="btnradio1" style="border-bottom-left-radius: 5px; 
			  border-top-left-radius: 5px; /*  background-color: gray; */">?????? ?????? ?????????</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" value="preopen" autocomplete="off">
			  <label class="btn btn-outline-warning" for="btnradio2">?????? ?????? ?????????</label>
			</div>
			
			<div id="slideWrap" class="carousel" data-ride="carousel" style="margin-top: 10px;">
				<!-- <a class="carousel-control-prev" href="#slideWrap" data-slide="prev" style="/* left: -10vh; */">
					<span class="carousel-control-prev-icon" style=""></span>
				</a> -->
				<div class="carousel-inner">
					<div class="container carousel-item active">
						<div class="row" id="showClub">
						
							
						</div>
						
					</div> 
					
					</div>
			</div>
			<br>
			
		<br>
		
	</div>
	 
	</div>
 	<!-- ???????????? -->
      <%-- <div>
         <c:import url="footer.jsp"></c:import>
      </div> --%>

</body>
</html>