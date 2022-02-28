package com.bcle.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.bcle.DAO.IBeeDAO;
import com.bcle.DTO.Bee;

public class AjaxClubCalendarListController implements Controller
{
	//주요 속성 구성
	// → 인터페이스 형태의 자료형을 속성으로 구성
	private IBeeDAO dao;

	// setter 구성
	public void setDao(IBeeDAO dao)
	{
		this.dao = dao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		// 세션 처리 과정 추가 ------------------------------------------
		/*
		 * HttpSession session = request.getSession();
		 * 
		 * if (session.getAttribute("name") == null) // -- 로그인이 되어 있지 않은 상황 {
		 * mav.setViewName("redirect:loginform.action"); return mav; } else if
		 * (session.getAttribute("admin") == null) // -- 로그인은 되었지만 관리자가 아닌 상황 {
		 * mav.setViewName("redirect:logout.action"); return mav; // -- 로그인은 되어 있지만 이 때
		 * 클라이언트는 // 일반 직원으로 로그인 되어 있는 상황이므로 // 로그아웃 액션 처리하여 다시 관리자로 로그인할 수 있도록 처리 }
		 */
		// ------------------------------------------ 세션 처리 과정 추가

		//ArrayList<Bee> beeList = new ArrayList<Bee>();
		String cid = request.getParameter("cid");
		try
		{
			
			// 페이징을 위한 util.java
			BeePaging beePaging = new BeePaging();
			
			// 넘어온(요청된) 페이지 번호 확인
			String pageNum = request.getParameter("pageNum");
			//System.out.println(pageNum);
			
			// 현재 표시되어야 하는 페이지
			int currentPage = 1;
			
			if(pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 전체 모임 갯수 구하기
			int dataCount = dao.countBee(cid);
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 3;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = beePaging.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = (currentPage-1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			//System.out.println(pageNum);
			//System.out.println(start);
			//System.out.println(end);
			
			// 실제 리스트 가져오기
			ArrayList<Bee> lists = dao.list(start, end, cid);
			//System.out.println(lists);
			
			String pageIndexList = beePaging.pageIndexList(currentPage, totalPage);
			
			
			
			mav.addObject("lists", lists);
			mav.addObject("pageIndexList", pageIndexList);
			mav.addObject("cid", cid);
			
			mav.setViewName("/WEB-INF/view/AjaxCalendarList.jsp");

			
			
			
			
			
			
			
			//beeList = dao.list(cid);

			//mav.addObject("beeList", beeList);

			//mav.setViewName("/WEB-INF/view/ClubCalendarList.jsp");
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;
	}

}
