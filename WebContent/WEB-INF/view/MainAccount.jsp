<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainAccounts.jsp</title>

<link rel="stylesheet" href="css/bootstrap.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

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
   
</style>

<script type="text/javascript">
$(document).ready(function()
{
   $("#category_L_ID").change(function()
   {

      var test = $("#category_L_ID option:selected").attr("value");
      $(location).attr("href","mainaccount.action?category_L_ID=" + test);
   
   });
});

</script>
<style type="text/css">
.bg
{
   position: relative;   
} 
</style>
</head>
<body>
   <!-- 
   MainAccountsList.jsp
메인페이지 - 결산 - 총결산

 -->

   <div class="bg">
      <!-- 네브 영역 -->
      <div>
         <c:import url="nav.jsp"></c:import>
      </div>


      <!-- 메뉴 영역 -->
      <div>
         <!-- 결산 사이드바 아직 미완성 -->
         <%-- <c:import url="mainSideTab.jsp"></c:import> --%>
      </div>

      <!-- 콘텐츠 영역 -->
      <div id="content" style="margin-left: 30vh;">
         <h1>[ 총결산 목록 ]</h1>
         <hr>
         <div>
            <p></p>
         </div>
         <div>
            <p>회원 수 변화</p>
            <div>
            <canvas id="myChart1" width="500" height="200">
               1. 막대 그래프-회원수(레이블:회원 수) 누적 : 
               <c:forEach var="summary" items="${summaryList }">
               ${summary.perTimeMemCnt1 }&nbsp;
               ${summary.perTimeMemCnt2 }&nbsp;
               ${summary.perTimeMemCnt3 }&nbsp;
               ${summary.perTimeMemCnt4 }&nbsp;
               ${summary.perTimeMemCnt5 }&nbsp;
               ${summary.perTimeMemCnt6 }&nbsp;
               
               <c:set var="data1" value="${summary.perTimeMemCnt1 }" />
               <c:set var="data2" value="${summary.perTimeMemCnt2 }" />
               <c:set var="data3" value="${summary.perTimeMemCnt3 }" />
               <c:set var="data4" value="${summary.perTimeMemCnt4 }" />
               <c:set var="data5" value="${summary.perTimeMemCnt5 }" />
               <c:set var="data6" value="${summary.perTimeMemCnt6 }" />
               
               
               </c:forEach>
            </canvas>
            </div>
            <br><br>
            <div>
            <canvas id="myChart2" width="500" height="200">
               2. 꺽은선 그래프 - 증감률(레이블 : 증감률)
               <c:forEach var="summary" items="${psummaryList }">
               ${summary.p_TimerMemCnt1 }&nbsp;
               ${summary.p_TimerMemCnt2 }&nbsp;
               ${summary.p_TimerMemCnt3 }&nbsp;
               ${summary.p_TimerMemCnt4 }&nbsp;
               ${summary.p_TimerMemCnt5 }&nbsp;
               ${summary.p_TimerMemCnt6 }&nbsp;
               
               <c:set var="pmdata1" value="${summary.p_TimerMemCnt1 }" />
               <c:set var="pmdata2" value="${summary.p_TimerMemCnt2 }" />
               <c:set var="pmdata3" value="${summary.p_TimerMemCnt3 }" />
               <c:set var="pmdata4" value="${summary.p_TimerMemCnt4 }" />
               <c:set var="pmdata5" value="${summary.p_TimerMemCnt5 }" />
               <c:set var="pmdata6" value="${summary.p_TimerMemCnt6 }" />
               
               </c:forEach>
            </canvas>
            </div>
         </div>
         <div>
            <p>신규 가입자 수(당일 기준) : ${newbiecnt }</p>
         </div>
         <div>
            <p>신규 동아리 수(당일 기준) : ${newclubcnt }</p>
         </div>
         <div>
            <p>정모 수(당일 기준) : ${beecnt }</p>
         </div>
   
         <h1>[ 카테고리별 목록 ]</h1>
         <select id="category_L_ID">
            <option value="1" selected="selected">여행</option>
            <option value="2">요리/베이킹</option>
            <option value="3">건강/운동</option>
            <option value="4">공연/축제</option>
            <option value="5">음악</option>
            <option value="6">라이프</option>
            <option value="7">교육/스터티</option>
            <option value="8">창작/디자인</option>
            <option value="9">사진/영상</option>
            <option value="10">게임/오락</option>
            <option value="11">자유주제</option>
         </select>
         <hr>
         <div>
            <p></p>
         </div>
         <div>
            <p>회원 수 변화</p>
         </div>
         1. 막대 그래프-회원수(레이블:회원 수) 누적 :
         <canvas id="myChart3" width="500" height="200">
         <c:forEach var="cate" items="${cateList }">
            ${cate.perCateMemCnt1 }&nbsp;
            ${cate.perCateMemCnt2 }&nbsp;
            ${cate.perCateMemCnt3 }&nbsp;
            ${cate.perCateMemCnt4 }&nbsp;
            ${cate.perCateMemCnt5 }&nbsp;
            ${cate.perCateMemCnt6 }&nbsp;
         
            <c:set var="cadata1" value="${cate.perCateMemCnt1 }"/>
            <c:set var="cadata2" value="${cate.perCateMemCnt2 }"/>
            <c:set var="cadata3" value="${cate.perCateMemCnt3 }"/>
            <c:set var="cadata4" value="${cate.perCateMemCnt4 }"/>
            <c:set var="cadata5" value="${cate.perCateMemCnt5 }"/>
            <c:set var="cadata6" value="${cate.perCateMemCnt6 }"/>
         
         </c:forEach>
         </canvas>
         
         <br>
         2. 만남 지역 top5 :
         <%-- <c:forEach var="top" items="${topList }" varStatus="status">
            ${top.city }${top.cnt }&nbsp;
            ${status.index }
            
            <c:set var="citycnt" value="citycnt${status.index }"/>
            
         </c:forEach>
          --%>
         <%-- ${topListCity0 } ${topListCnt0 } --%>   
         <canvas id="myChart4" width="500" height="200">
         </canvas>
         <br>
         <div>
         <canvas id="myChart5" width="500" height="200">
         <c:forEach var="cat" items="${catevariationList }">
            ${cat.perCateMemCnt1 }&nbsp;
            ${cat.perCateMemCnt2 }&nbsp;
            ${cat.perCateMemCnt3 }&nbsp;
            ${cat.perCateMemCnt4 }&nbsp;
            ${cat.perCateMemCnt5 }&nbsp;
            ${cat.perCateMemCnt6 }&nbsp;
            
            <c:set var="cdata1" value="${cat.perCateMemCnt1 }"/>
            <c:set var="cdata2" value="${cat.perCateMemCnt2 }"/>
            <c:set var="cdata3" value="${cat.perCateMemCnt3 }"/>
            <c:set var="cdata4" value="${cat.perCateMemCnt4 }"/>
            <c:set var="cdata5" value="${cat.perCateMemCnt5 }"/>
            <c:set var="cdata6" value="${cat.perCateMemCnt6 }"/>
            
         </c:forEach>
         </canvas>
         </div>
         <div>
            <p>신규 가입자 수(당일 기준) : ${catenewbie }</p>
         </div>
         <div>
            <p>신규 동아리 가입자 수(당일 기준) : ${cateclubcnt }</p>
         </div>
         <div>
            <p>평균 정모 회비 : ${catemoney }</p>
         </div>
      </div>
      
      
      
       <!-- 풋터영역 -->
        <div style="">
            <c:import url="footer.jsp"></c:import>
        </div>
   </div>


<script type="text/javascript">
            var context = document
                .getElementById('myChart1')
                .getContext('2d');
            
            var data1 = "<c:out value='${data1}'/>";
            var data2 = "<c:out value='${data2}'/>";
            var data3 = "<c:out value='${data3}'/>";
            var data4 = "<c:out value='${data4}'/>";
            var data5 = "<c:out value='${data5}'/>";
            var data6 = "<c:out value='${data6}'/>";
            
            
            var myChart1 = new Chart(context, {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                        '누적 1개월','누적 2개월','누적 3개월','누적 4개월','누적 5개월','누적 6개월'
                    ],
                    datasets: [
                        { //데이터
                            label: '6개월 간 누적 회원 수', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                               data1,data2,data3,data4,data5,data6
                                
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)' 
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                   responsive : false,
                    scales: {
                        yAxes: [
                            {
                                ticks: {

                           
                                   
                                }
                            }
                        ]
                    }
                }
            });
</script>


<script type="text/javascript">
            var context = document
                .getElementById('myChart2')
                .getContext('2d');
            
            var pmdata1 = "<c:out value='${pmdata1}'/>";
            var pmdata2 = "<c:out value='${pmdata2}'/>";
            var pmdata3 = "<c:out value='${pmdata3}'/>";
            var pmdata4 = "<c:out value='${pmdata4}'/>";
            var pmdata5 = "<c:out value='${pmdata5}'/>";
            var pmdata6 = "<c:out value='${pmdata6}'/>";
            
            var myChart = new Chart(context, {
                type: 'line', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                       '1개월','2개월','3개월','4개월','5개월','6개월'
                    ],
                    datasets: [
                        { //데이터
                            label: '회원 수 증감률', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                               pmdata1,pmdata2,pmdata3,pmdata4,pmdata5,pmdata6 //x축 label에 대응되는 데이터 값
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                   responsive : false,
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });
</script>
<script type="text/javascript">
            var context = document
                .getElementById('myChart3')
                .getContext('2d');
            
            var cadata1 = "<c:out value='${cadata1}'/>";
            var cadata2 = "<c:out value='${cadata2}'/>";
            var cadata3 = "<c:out value='${cadata3}'/>";
            var cadata4 = "<c:out value='${cadata4}'/>";
            var cadata5 = "<c:out value='${cadata5}'/>";
            var cadata6 = "<c:out value='${cadata6}'/>";
            
            
            var myChart3 = new Chart(context, {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                        '누적 1개월','누적 2개월','누적 3개월','누적 4개월','누적 5개월','누적 6개월'
                    ],
                    datasets: [
                        { //데이터
                            label: '카테고리 6개월 간 누적 회원 수', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                               cadata1,cadata2,cadata3,cadata4,cadata5,cadata6
                                
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)' 
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                   responsive : false,
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });
</script>

<script type="text/javascript">
            var context = document
                .getElementById('myChart4')
                .getContext('2d');
            
            var myChart4 = new Chart(context, {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                       "<c:out value='${topListCity0}'/>",
                       "<c:out value='${topListCity1}'/>",
                       "<c:out value='${topListCity2}'/>",
                       "<c:out value='${topListCity3}'/>",
                       "<c:out value='${topListCity4}'/>"
                    ],
                    datasets: [
                        { //데이터
                            label: '만남 지역 top5', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                               "<c:out value='${topListCnt0}'/>",                    
                               "<c:out value='${topListCnt1}'/>",                    
                               "<c:out value='${topListCnt2}'/>",                    
                               "<c:out value='${topListCnt3}'/>",                    
                               "<c:out value='${topListCnt4}'/>"                    
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)' 
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 206, 86, 0.2)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                   responsive : false,
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });
</script>

<script type="text/javascript">
            var context = document
                .getElementById('myChart5')
                .getContext('2d');
            
            var cdata1 = "<c:out value='${cdata1}'/>";
            var cdata2 = "<c:out value='${cdata2}'/>";
            var cdata3 = "<c:out value='${cdata3}'/>";
            var cdata4 = "<c:out value='${cdata4}'/>";
            var cdata5 = "<c:out value='${cdata5}'/>";
            var cdata6 = "<c:out value='${cdata6}'/>";
            
            var myChart = new Chart(context, {
                type: 'line', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                       '1개월','2개월','3개월','4개월','5개월','6개월'
                    ],
                    datasets: [
                        { //데이터
                            label: '회원 수 증감률', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                               cdata1,cdata2,cdata3,cdata4,cdata5,cdata6 //x축 label에 대응되는 데이터 값
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                   responsive : false,
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });
</script>

</body>
</html>