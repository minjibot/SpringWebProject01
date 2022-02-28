package com.bcle.mybatiscontroller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bcle.DTO.MemberInfo;
import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class JoinController
{
	// SqlSession 을 활용하여 mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/ajaxclubmeminsert.action", method = RequestMethod.POST)
	public String AjaxClubMemInsert(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IJoinDAO dao = sqlSession.getMapper(IJoinDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		String joinId = request.getParameter("joinId");
		String cid = request.getParameter("cid");
		
		int cntMaxClubMem = 0;
		int cntClubMem = 0;
		
		// CID 얻어와서 이 CID MAX랑 REQCNT? 비교해서 
		// MAX랑 신청자 수랑 같으면
		// INSERT 수행 한 하고 INSERT에다가 다른 값 넣어서 넘기기
		
		try
		{
			cntMaxClubMem = dao.cntMaxClubMem(cid);
			cntClubMem = dao.cntClubMem(cid);
			
			if (cntMaxClubMem == cntClubMem)
				model.addAttribute("insert", -1);
			else
				model.addAttribute("insert", dao.clubmemInsert(joinId));
			
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxClubMemInsert.jsp";
	}
	
	@RequestMapping(value = "/ajaxjoinclubreturninsert.action", method = RequestMethod.POST)
	public String AjaxJoinClubReturnInsert(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IJoinDAO dao = sqlSession.getMapper(IJoinDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		String joinId = request.getParameter("joinId");
		System.out.println("test" + joinId);
		
		try
		{
			model.addAttribute("insert", dao.joinClubReturnInsert(joinId));
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxJoinClubReturnInsert.jsp";
	}
	
}

