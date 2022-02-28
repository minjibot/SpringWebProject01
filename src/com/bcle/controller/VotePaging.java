package com.bcle.controller;

public class VotePaging
{
   // ■ 전체 페이지 수를 구하는 메소드
   // numPerPage : 한 페이지에 표시할 데이터(게시물)의 수
   // dataCount : 전체 데이터(게시물) 수
   public int getPageCount(int numPerPage, int dataCount)
   {
      int pageCount = 0;
      
      pageCount = dataCount/numPerPage;
      
      if(dataCount % numPerPage != 0)
         pageCount++;
      
      return pageCount;
   }
   
   // ■ 페이징 처리 기능의 메소드
   // currentPage : 현재 표시할 페이지
   // totalPage : 전체 페이지 수
   // listUrl : 링크를 설정할 url
   public String pageIndexList(int currentPage, int totalPage)
   {
      // 실제 페이징을 저장할 StringBuffer 변수
      StringBuffer strList = new StringBuffer();
      
      int numPerBlock = 10;

      int currentPageSetup;
      //-- 현재 페이지(이 페이지를 기준으로 보여주는 숫자가 달라져야 하기 때문...)
      int page;
      int n;
      //-- 이전 페이지 블럭과 같은 처리에서 이동하기 위한 변수
      
      // 페이징 처리가 별도로 필요하지 않은 경우
      if(currentPage==0)
         return "";
      
      // currentPageSetup = 표시할 첫 페이지 -1
      currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
      
      if(currentPage % numPerBlock == 0)
      {
         currentPageSetup = currentPageSetup - numPerBlock;
         // currentPageSetup -= numPerBlock;
      }
      
      // 1페이지
      if ( (totalPage>numPerBlock) && (currentPageSetup>0) )
      {
         strList.append(" <nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
               + "<li class='page-item'><a href='#' onClick='ajaxVoteRequest(1); return false' class='page-link'>1</a></li>");
      }
      
      // Prev
      n = currentPage - numPerBlock;   
      //-- n : 해당 페이지만큼 앞으로 가기 위한 변수
      if ( (totalPage>numPerBlock) && (currentPageSetup>0) )
      {
         strList.append(" <li class='page-item'><a href='#' onClick='ajaxVoteRequest(" + n + "); return false' class='page-link'>Prev</a></li>");
      }   
      
      // 각 페이지 바로가기
      page = currentPageSetup + 1;

      while ( (page<=totalPage) && (page<=currentPageSetup+numPerBlock) )
      {
         if(page==currentPage)
         {
            strList.append(" <li class='page-item'><a class='page-link'><spen style='color:orange; font-weight:bold;'>" + page + "</span></a></li>");
         }
         else
         {
            strList.append(" <li class='page-item'><a href='#' onClick='ajaxVoteRequest(" + page + "); return false' class='page-link'>" + page + "</a></li>");
         }
         
         page++;
      }
      
      // Next
      n = currentPage + numPerBlock;
      if ( (totalPage-currentPageSetup) > numPerBlock )
      {
         strList.append(" <li class='page-item'><a href='#' onClick='ajaxVoteRequest(" + n + "); return false' class='page-link'>Next</a></li>");
      }
      
      // 마지막 페이지
      if( (totalPage>numPerBlock) && (currentPageSetup+numPerBlock)<totalPage )
      {
         strList.append(" <li class='page-item'><a href='#' onClick='ajaxVoteRequest(" + totalPage + "); return false'>"+ totalPage + "</a></li></ul></nav>");
      }
      
      return strList.toString();
      
   }
}