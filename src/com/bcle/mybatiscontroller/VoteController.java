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

import com.bcle.DTO.Vote;
import com.bcle.controller.VotePaging;
import com.google.gson.Gson;

@Controller
public class VoteController
{
	// SqlSession 을 활용하여 mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/conferenceList.action", method = RequestMethod.GET)
	public String voteBoardList(HttpServletRequest request, Model model) throws SQLException
	{
		String result = "/WEB-INF/view/";

		HttpSession session = request.getSession();

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		/*
		 * IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);
		 * 
		 * model.addAttribute("votelist",dao.voteList());
		 */
		String cid = request.getParameter("cid");
		model.addAttribute("cid", cid);

		Object getId = session.getAttribute("id");
		String id = (String) getId;

		model.addAttribute("checkvotebutton", dao.checkvotebutton(cid, id));

		result += "ConferenceList.jsp";

		return result;
	}

	@RequestMapping(value = "/beevotecreated.action", method = RequestMethod.GET)
	public String voteCreate(HttpServletRequest request, Model model) throws SQLException
	{

		String result = "/WEB-INF/view/";

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);
		String cid = request.getParameter("cid");

		model.addAttribute("cid", cid);

		model.addAttribute("suspectlist", dao.suspectList(cid));

		result += "beeVoteCreated.jsp";

		return result;
	}

	@RequestMapping(value = "/insertconferenceList.action", method = RequestMethod.POST)
	public String voteInsertList(HttpServletRequest request, Model model) throws SQLException
	{
		String result = "";

		HttpSession session = request.getSession();

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		String type = request.getParameter("type");
		String title = request.getParameter("title");
		
		// 닉네임
		String realsuspect = request.getParameter("realsuspect");
		String content = request.getParameter("content");
		String cid = request.getParameter("cid");

		// 세션에서 id 가져오기
		Object getId = session.getAttribute("id");
		String id = (String) getId;
		
		// 넘어온 닉네임이 null = 동아리 탈퇴 투표를 발의한 경우
		if(realsuspect == null)
			dao.insertSuspectList2(id, cid, type, title, content);
		else 
			dao.insertSuspectList(id, cid, type, title, realsuspect, content);

		result += "redirect:clubmain.action?cid=" + cid;

		return result;
	}

	@RequestMapping(value = "/vote.action", method = RequestMethod.GET)
	public String voteInsert(HttpServletRequest request, Model model) throws SQLException
	{

		String result = "/WEB-INF/view/";
		
		HttpSession session = request.getSession();

		String bid = request.getParameter("bid");

		IVoteDAO suspectdao = sqlSession.getMapper(IVoteDAO.class);
		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// id 가져오기
		Object getId = session.getAttribute("id");
		String id = (String) getId;
		
		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		model.addAttribute("checkCap", dao.checkvotebutton(cid, id));

		model.addAttribute("list", suspectdao.suspecterInformation(cid, bid));
		model.addAttribute("bid", bid);
		model.addAttribute("cid2", cid);
		model.addAttribute("voterlist", dao.voterlist(bid));
		model.addAttribute("checkClosedClub", dao.checkClosedClub(cid));
		model.addAttribute("checkPosition", dao.checkPosition(suspectdao.suspecterInformation(cid, bid).getSuspect(), cid)); // 직위 체크 - 대상자가 일반 동아리원이면 1, 아니면 0
		model.addAttribute("checkEliminated", dao.checkEliminated(suspectdao.suspecterInformation(cid, bid).getSuspect(), cid)); // 강퇴회원인지 체크 - 강퇴회원이면 1 아니면 0
		model.addAttribute("checkVote", dao.checkVote(bid, dao.getClubMem_id2(id, cid)));

		result += "beeVoteArticle.jsp";

		return result;
	}

	@RequestMapping(value = "/typecheck.action", method = RequestMethod.POST)
	public String typeList(HttpServletRequest request, Model model) throws SQLException
	{
		String result = "/WEB-INF/view/";

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		String type = request.getParameter("type");
		String cid = request.getParameter("cid");

		// ArrayList<Vote> suspectlist = new ArrayList<Vote>();

		String list = "";

		if (type.equals("1"))
		{
			Gson gson = new Gson();
			list = gson.toJson(dao.devoterlist(cid));
			// suspectlist = dao.devoterlist();

		} else
		{
			Gson gson = new Gson();
			list = gson.toJson(dao.suspectList(cid));
		}

		model.addAttribute("suspectlist", list);
		// System.out.println(suspectlist);

		result += "AjaxVoterType.jsp";

		return result;
	}

	@RequestMapping(value = "/votelistpage.action")
	public String votelistpage(HttpServletRequest request, Model model) throws SQLException
	{

		String result = "/WEB-INF/view/";

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		try
		{

			VotePaging votePaging = new VotePaging();

			String pageNum = request.getParameter("pageNum");
			String cid = request.getParameter("cid");
			// System.out.println(cid);
			int currentPage = 1;

			if (pageNum != null)
				currentPage = Integer.parseInt(pageNum);

			int dataCount = dao.votetotaldata(cid);

			int numPerPage = 10;
			int totalPage = votePaging.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage)
				currentPage = totalPage;

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			ArrayList<Vote> lists = dao.votepagelist(cid, start, end);

			String pageIndexList = votePaging.pageIndexList(currentPage, totalPage);

			model.addAttribute("lists", lists);
			model.addAttribute("pageIndexList", pageIndexList);

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		result += "AjaxVoteList.jsp";

		return result;

	}

	@RequestMapping(value = "/agree.action", method = RequestMethod.GET)
	public String agree(Model model) throws SQLException
	{

		String result = "";

		result += "redirect:conferenceList.action";

		return result;
	}

	@RequestMapping(value = "/disagree.action", method = RequestMethod.GET)
	public String disagree(Model model) throws SQLException
	{

		String result = "";

		result += "redirect:conferenceList.action";

		return result;
	}
	
	// 강등
	@RequestMapping(value = "/demotion.action", method = RequestMethod.GET)
	public String demotion(HttpServletRequest request, Model model) throws SQLException
	{
		String bid = request.getParameter("bid");
		String nickname = request.getParameter("suspect");

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		String clubmem_id = dao.getClubMem_id(nickname, cid);

		// 강등 
		dao.updatePosition(clubmem_id);

		return "redirect:clubmain.action?cid=" + cid;
	}
	
	// 강퇴
	@RequestMapping(value = "/eliminated.action", method = RequestMethod.GET)
	public String eliminated(HttpServletRequest request, Model model) throws SQLException
	{
		String bid = request.getParameter("bid");
		String nickname = request.getParameter("suspect");

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		String clubmem_id = dao.getClubMem_id(nickname, cid);

		// 강등 
		dao.insertBanMemList(clubmem_id);

		return "redirect:clubmain.action?cid=" + cid;
	}
	
	// 동아리 폐쇄
	@RequestMapping(value = "/closing.action", method = RequestMethod.GET)
	public String closing(HttpServletRequest request, Model model) throws SQLException
	{
		String bid = request.getParameter("bid");

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		// 강등 
		dao.insertClubStatus(cid);

		return "redirect:clubmain.action?cid=" + cid;
	}
	
	// 찬반 insert
	@RequestMapping(value = "/insertpac.action", method = RequestMethod.GET)
	public String insertPac(HttpServletRequest request, Model model) throws SQLException
	{
		HttpSession session = request.getSession();

		String bid = request.getParameter("bid");
		String pacId = request.getParameter("pacId");
		//System.out.println(bid + ":" + pacId);

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// id 가져오기
		Object getId = session.getAttribute("id");
		String id = (String) getId;
		
		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		//System.out.println(id + ":" + cid);
		
		dao.insertPac(id, cid, bid, pacId);

		return "redirect:vote.action?bid=" + bid;
	}
	
	// 찬반 delete
	@RequestMapping(value = "/deletepac.action", method = RequestMethod.GET)
	public String deletePac(HttpServletRequest request, Model model) throws SQLException
	{
		HttpSession session = request.getSession();

		String bid = request.getParameter("bid");

		IVoteDAO dao = sqlSession.getMapper(IVoteDAO.class);

		// id 가져오기
		Object getId = session.getAttribute("id");
		String id = (String) getId;

		// bid 로 동아리 코드 가져오기
		String cid = dao.getCid(bid);
		
		String clubmem_id = dao.getClubMem_id2(id, cid);

		//System.out.println(clubmem_id);

		dao.deletePac(bid, clubmem_id);

		return "redirect:vote.action?bid=" + bid;
	}

}