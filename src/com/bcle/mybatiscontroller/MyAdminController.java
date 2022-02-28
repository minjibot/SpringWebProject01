package com.bcle.mybatiscontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bcle.DTO.Bee;
import com.bcle.DTO.MemberInfo;
import com.bcle.controller.BeePaging;

@Controller
public class MyAdminController
{
	// SqlSession 을 활용하여 mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/ajaxmemberlist.action", method = RequestMethod.POST)
	public String ajaxMemberList(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyAdminDAO dao = sqlSession.getMapper(IMyAdminDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
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
			
			// select(옵션), inputValue(검색 값)
			String select = request.getParameter("select");
			String inputValue = request.getParameter("inputValue");
			//System.out.println(select);
			//System.out.println(inputValue);
			
			int dataCount = 0;
			
			// 전체 리뷰 갯수 구하기
			if(select.equals("0"))
				dataCount = dao.countMember();
			else
				dataCount = dao.countSearchMember(select, inputValue);
			//System.out.println("data" + dataCount);
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 10;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = beePaging.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = dataCount - currentPage * numPerPage + 1;
			int end = dataCount - (currentPage-1) * numPerPage;
			
			// 실제 리스트 가져오기
			ArrayList<MemberInfo> lists = new ArrayList<MemberInfo>();
			
			if(select.equals("0"))
				lists = dao.memberList(start, end);
			else
				lists = dao.searchMemberList(select, inputValue, start, end);
			
			System.out.println(lists);
			
			String pageIndexList = beePaging.pageIndexList(currentPage, totalPage);
			
			
			model.addAttribute("lists", lists);
			model.addAttribute("pageIndexList", pageIndexList);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxMemberList.jsp";
	}
	
	@RequestMapping(value = "/clublist.action", method = RequestMethod.GET)
	public String clubList(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		try
		{
			
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/ClubList.jsp";
	}
	
	@RequestMapping(value = "/ajaxclublist.action", method = RequestMethod.POST)
	public String ajaxClubList(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyAdminDAO dao = sqlSession.getMapper(IMyAdminDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
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
			
			// select(옵션), inputValue(검색 값)
			String sort = request.getParameter("sort");
			//System.out.println(select);
			//System.out.println(inputValue);
			
			int dataCount = 0;
			
			// 전체 동아리 갯수 구하기
			dataCount = dao.countClub();
			
			// 전체 페이지를 기준으로 총 페이지 수 계산
			int numPerPage = 10;		//-- 한 페이지에 표시할 데이터 갯수
			int totalPage = beePaging.getPageCount(numPerPage, dataCount);
			
			// 전체 페이지 수 보다 표시할 페이지가 큰 경우 표시할 페이지를 전체 페이지로 처리
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			// 데이터베이스에서 가져올 시작과 끝 위치
			int start = dataCount - currentPage * numPerPage + 1;
			int end = dataCount - (currentPage-1) * numPerPage;
			
			// 실제 리스트 가져오기
			ArrayList<MemberInfo> lists = new ArrayList<MemberInfo>();
			
			lists = dao.sortClubList(sort, start, end);
			
			System.out.println(lists);
			
			String pageIndexList = beePaging.pageIndexList(currentPage, totalPage);
			
			
			model.addAttribute("lists", lists);
			model.addAttribute("pageIndexList", pageIndexList);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxClubList.jsp";
	}
}

