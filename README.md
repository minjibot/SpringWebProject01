# :honeybee: B:CLE - 동아리 웹사이트
B:CLE이란? <br>
Bee(부지런한 사람) + Class(모임) = B:CLE <br>
<br>

## 프로젝트 개요 
비클은 Spring MVC 패턴과 Oracle DB 를 기반으로 제작한 동아리 웹 사이트 입니다. <br>
사용자가 보다 편리하게 취미 생활을 공유할 모임을 찾거나 개설할 수 있고, <br>
쉽게 관리하여 모임 활동이 활성화될 수 있는 플랫폼을 기획하였습니다.

## 개발 환경
- IDE : Eclipse IDE for Enterprise Java Developers 2021-12 <br>
- Language : JAVA , HTML5, CSS3(bootstrap), JavaScript, JQuery <br>
- Database: Oracle RDBMS <br>
- WAS : Apache Tomcat 8.5 <br>
- Framework: Spring Framework <br>

## 핵심 기능
- 회원 가입 및 로그인(유효성 검사, 아이디/비밀번호 찾기 등)  
- 동아리 개설(개설 예정 동아리, 정식 개설 동아리)
- 검색 기능(카테고리,지역,정렬,검색어 기반) 
- 모임 개설 및 평가(동아리 내의 모임 개설 및 모임 후기, 모임 평가, 회원 평가 등) 
- 마이 페이지(내 정보 수정, 받은 회원 평가 목록, 나의 동아리 활동 내역) 
- 게시판 (모집, 투표, 공지사항) 
- 결산 (모든 동아리 관련 데이터 수치화, 그래프화)

 ## :star: 담당 역할
 - 기획 및 정책 수립
 - 데이터베이스 설계
 - 동아리 개설(개설 예정 동아리, 정식 개설 동아리)
 - 검색 기능(카테고리,지역,정렬,검색어 기반)
 - 모집 게시판 CRUD 
 - 담당 화면 SQL 및 PL/SQL 작성
 - 담당 화면 UI/UX
 
 ## 데이터베이스 ERD
 ![ERD](https://user-images.githubusercontent.com/88035374/152681344-f1aedd2a-254d-40e4-80b2-b2bdcf318c3a.png)
 
 <br>
 
 ## :computer: 작동 화면
- 메인
![main](https://user-images.githubusercontent.com/88035374/152681882-c11dd2a3-22f6-4123-89bb-6c1efb15050b.png)
- 회원가입 및 로그인 
![join](https://user-images.githubusercontent.com/88035374/152681915-1c8f9ba8-b3fd-4261-ae21-2d965897035d.png)
![login](https://user-images.githubusercontent.com/88035374/152681918-96b3bfb4-72f0-4480-aaf6-4a83ca445718.png)
- 검색 기능(카테고리,지역,정렬,검색어 기반) 
![search](https://user-images.githubusercontent.com/88035374/152682156-0fe0a46b-25a6-4dc2-ae54-8b49ed979dce.png)
- 동아리 개설(개설 예정 동아리, 정식 개설 동아리)
![create](https://user-images.githubusercontent.com/88035374/152681966-5826946b-0d26-4fd3-804d-fc5d8034de33.png)
![preOpen](https://user-images.githubusercontent.com/88035374/152682018-be95f061-e200-4e6a-9e85-6c57b472772e.png) <br>
동아리 개설 후 30일 이내에 스태프 1, 총무 1명 선정 시 정식 동아리로 변환
![club](https://user-images.githubusercontent.com/88035374/152682106-7179122f-0760-416d-a2d3-f5508df41c32.png)
- 모임 개설 및 평가(동아리 내의 모임 개설 및 모임 후기, 모임 평가, 회원 평가 등) 모임
![beeCreate](https://user-images.githubusercontent.com/88035374/152682136-f3e85617-140f-4141-ba17-981d60c6da3f.png)
![beeAfter](https://user-images.githubusercontent.com/88035374/152682139-a0fa6bcc-ddb0-45ae-8412-c4e2449d1307.png)
- 모집 게시판 crud
<br>동아리의 스태프와 총무를 모집할 경우 모집 게시판 이용. 동아리 원들은 지원 가능하고 1주일의 모집 후 <br> 
자동 운영진(동아리장,스태프,총무)투표로 진행. 3일간의 투표 후 최다 득표자가 해당 직위로 선정,<br>
동점 시 빨리 신청한 사람이 선정됨 
![recruitAfter](https://user-images.githubusercontent.com/88035374/152682149-1736a3c7-ca83-47ab-a20c-b2ccf702a232.png)
- 투표 게시판 crud 
<br> 동아리의 회원 강등이나 강퇴 여부 투표를 실시하는 게시판.
![vote](https://user-images.githubusercontent.com/88035374/152682155-c737aaa8-8dbe-4359-8bcd-0eac9bc496bf.png)
- 마이 페이지
![myPage1](https://user-images.githubusercontent.com/88035374/152682599-2898b683-ce7d-4524-b77c-e57321dd2937.png)
![myPage2](https://user-images.githubusercontent.com/88035374/152682605-92241803-04b5-4a83-a07a-38472bf4f6fa.png)
- 결산 
![result](https://user-images.githubusercontent.com/88035374/152682158-e4eb2a21-c7ed-4579-8050-50d4770f8fca.png)


 

