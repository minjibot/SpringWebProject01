package com.bcle.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.bcle.DAO.IBeeDAO;
import com.bcle.DAO.IClubDAO;
import com.bcle.DTO.Bee;
import com.bcle.DTO.MemberInfo;

public class AjaxClubJoinListController implements Controller
{
	//주요 속성 구성
	// → 인터페이스 형태의 자료형을 속성으로 구성
	private IClubDAO dao;

	// setter 구성
	public void setDao(IClubDAO dao)
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

		String cid = request.getParameter("cid");
		//System.out.println(cid);
		
		ArrayList<MemberInfo> clubJoinList = new ArrayList<MemberInfo>();
		try
		{
			
			clubJoinList = dao.joinClubmemList(cid);
			
			mav.addObject("clubJoinList", clubJoinList);
			
			mav.setViewName("/WEB-INF/view/AjaxClubJoinList.jsp");
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;
	}

}
