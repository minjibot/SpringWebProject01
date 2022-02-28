package com.bcle.controller;

public class BeePaging
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
	// -- 한 페이지에 10개의 게시물을 출력할 때
	// 총 32개의 게시물을 페이지로 구성하기 위해서는
	// [32/10]의 연산을 수행하여 결과 3을 얻을 수 있다.
	// -> [PageCount = dataCount/numPerPage;]
	// 그런데 이 때, 나머지 2개의 게시물을 출력해 주기 위해서는
	// 페이지 하나가 더 필요하다.
	
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
		// -- 만약 위 처리에서 (라인 95)
        // 현재 페이지가 20 페이지였다면 (CurrentPage=20)
        // [20/10=2]이며.. 여기에 [ * 10 ] (10을 곱해서)
        // 이와 같은 상황이라면... 다시 10을 빼서 10으로 만들어주기 위한 구문.

		// 1페이지
		if ( (totalPage>numPerBlock) && (currentPageSetup>0) )
		{
			strList.append(" <nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
					+ "<li class='page-item'><a href='#' onClick='ajaxRequest(1); return false' class='page-link'>1</a></li>");
		}
		
		// Prev
		n = currentPage - numPerBlock;	
		//-- n : 해당 페이지만큼 앞으로 가기 위한 변수
		if ( (totalPage>numPerBlock) && (currentPageSetup>0) )
		{
			strList.append(" <li class='page-item'><a href='#' onClick='ajaxRequest(" + n + "); return false' class='page-link'>Prev</a></li>");
		}	
		
		// 각 페이지 바로가기
		page = currentPageSetup + 1;

		while ( (page<=totalPage) && (page<=currentPageSetup+numPerBlock) )
		{
			// 현재쪽
			if(page==currentPage)
			{
				strList.append(" <li class='page-item'><a class='page-link'><spen style='color:orange; font-weight:bold;'>" + page + "</span></a></li>");
			}
			else
			{
				strList.append(" <li class='page-item'><a href='#' onClick='ajaxRequest(" + page + "); return false' class='page-link'>" + page + "</a></li>");
			}
			
			page++;
		}
		
		// Next
		n = currentPage + numPerBlock;
		if ( (totalPage-currentPageSetup) > numPerBlock )
		{
			strList.append(" <li class='page-item'><a href='#' onClick='ajaxRequest(" + n + "); return false' class='page-link'>Next</a></li>");
		}
		
		// 마지막 페이지
		if( (totalPage>numPerBlock) && (currentPageSetup+numPerBlock)<totalPage )
		{
			strList.append(" <li class='page-item'><a href='#' onClick='ajaxRequest(" + totalPage + "); return false'>"+ totalPage + "</a></li></ul></nav>");
		}
		
		return strList.toString();
		
	}
}
