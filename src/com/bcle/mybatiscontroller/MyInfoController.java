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
public class MyInfoController
{
	// SqlSession 을 활용하여 mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/myinfo.action", method = RequestMethod.GET)
	public String myInfoPage(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyInfoDAO dao = sqlSession.getMapper(IMyInfoDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		//String evalId = "P1";
		
		try
		{
			//System.out.println(dao.countEval(id, evalId));
			model.addAttribute("info", dao.showMyInfo(id));
			
			// 평가 수
			model.addAttribute("p1", dao.countEval(id, "P1"));
			model.addAttribute("p2", dao.countEval(id, "P2"));
			model.addAttribute("p3", dao.countEval(id, "P3"));
			model.addAttribute("p4", dao.countEval(id, "P4"));
			model.addAttribute("p5", dao.countEval(id, "P5"));
			model.addAttribute("p6", dao.countEval(id, "P6"));
			model.addAttribute("p7", dao.countEval(id, "P7"));
			model.addAttribute("n1", dao.countEval(id, "N1"));
			model.addAttribute("n2", dao.countEval(id, "N2"));
			model.addAttribute("n3", dao.countEval(id, "N3"));
			model.addAttribute("n4", dao.countEval(id, "N4"));
			model.addAttribute("n5", dao.countEval(id, "N5"));
			model.addAttribute("n6", dao.countEval(id, "N6"));
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/MyInfo.jsp";
	}
	
	@RequestMapping(value = "/mypagecheckpwd.action", method = RequestMethod.POST)
	public String myPageCheckPwdAjax(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyInfoDAO dao = sqlSession.getMapper(IMyInfoDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		String pwd = request.getParameter("pwd");
		try
		{
			//System.out.println(dao.checkPwd(id, pwd));
			model.addAttribute("check", dao.checkPwd(id, pwd));
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
				
		return "/WEB-INF/view/AjaxCheckPwd.jsp";
		//return "";
	}
	
	@RequestMapping(value = "/myinfoupdateform.action", method = RequestMethod.POST)
	public String myInfoUpdateForm(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyInfoDAO dao = sqlSession.getMapper(IMyInfoDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		try
		{
			model.addAttribute("regionLList", dao.regionLList());
			model.addAttribute("categoryLList", dao.categoryLList());
			model.addAttribute("info", dao.showMyInfo(id));
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
				
		return "/WEB-INF/view/MyInfoUpdateForm.jsp";
	}
	
	@RequestMapping(value = "/myinfoupdate.action", method = RequestMethod.POST)
	public String myInfoUpdate(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyInfoDAO dao = sqlSession.getMapper(IMyInfoDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		// 파일 업로드의 정보
		String path = "upload/image";
		String savePath = request.getServletContext().getRealPath(path);
		int maxSize = 1024 * 1024 * 1024; // 1G 이하
		String encodingType = "UTF-8";

		try
		{
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encodingType,
					new DefaultFileRenamePolicy());
	
			// Join.jsp로부터 데이터 수신. -- ★multi에서 데이터 가져와야함
			// 16개
			String url = multi.getFilesystemName("url"); // --★ check!
			String oldUrl = multi.getParameter("oldUrl"); // 
			String pwd = multi.getParameter("pwd");
	
			// check~!!!
			String tel = multi.getParameter("tel");
			String nickName = multi.getParameter("nickName");
			
			String region_S_Id1 = multi.getParameter("region_S_Id1");  
			//String region_S_Id2 = multi.getParameter("region_S_Id2");
			//String region_S_Id3 = multi.getParameter("region_S_Id3");
			String category_S_Id1 = multi.getParameter("category_S_Id1");
			
			//System.out.println("r2 = " + region_S_Id2);
			//System.out.println("r3 = " + region_S_Id3);
			//System.out.println(oldUrl + ":" + url + ": " + pwd + tel + nickName + category_S_Id1);
			
			// update...
			MemberInfo dto = new MemberInfo();
			
			// 사진 변경 여부에 따라서 분기
			if(url == null)
				dto.setUrl(oldUrl);
			else 
				dto.setUrl("upload/image/" + url);

			dto.setId(id);
			dto.setPwd(pwd);
			dto.setTel(tel);
			dto.setNickname(nickName);
			dto.setRegionId1(region_S_Id1);
			dto.setCategoryId1(category_S_Id1);
			// System.out.println(region_S_Id2 + " : " + category_L_Id2);

			
			// memberinfo/member 테이블 업데이트
			dao.updateMemberInfo(dto);
			dao.updateMember(dto);
			
			// 기존 추가지역/추가카테고리 삭제
			dao.deleteAddRegion(id);
			dao.deleteAddCategory(id);
			
			for (int i = 2; i <= 3; i++)
			{
				if (!( multi.getParameter("region_S_Id" + i).equals("-1") || multi.getParameter("region_S_Id" + i).equals("") )  ) // -1 이거나 null!
				{
					//System.out.println(i + " : " + (multi.getParameter("region_S_Id" + i)));
					String region_s_id = multi.getParameter("region_S_Id" + i);
					dao.insertAddRegion(id, region_s_id);
				}
			}
			
			for (int i = 2; i <= 5; i++)
			{
				if (!( multi.getParameter("category_S_Id" + i).equals("-1") || multi.getParameter("category_S_Id" + i).equals("") )  ) // -1 이거나 null!
				{
					//System.out.println(i + " : " + (multi.getParameter("category_S_Id" + i)));
					String category_s_id = multi.getParameter("category_S_Id" + i);
					dao.insertAddCategory(id, category_s_id);
				}
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
				
		return "redirect:myinfo.action";
	}
	
	@RequestMapping(value = "/myclub.action", method = RequestMethod.GET)
	public String myClubPage(Model model)
	{
		
		return "/WEB-INF/view/MyClub.jsp";
	}
	
	// 내 동아리(활동중/종료중) 가져오기
	@RequestMapping(value = "/ajaxmyclub.action", method = RequestMethod.POST)
	public String ajaxMyClub(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyClubDAO dao = sqlSession.getMapper(IMyClubDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		// 셀렉트박스 옵션값 가져오기
		String status = request.getParameter("status");
		//System.out.println(status);
		
		// 동아리 리스트 담을 변수
		String result = "";
		try
		{
			if (status.equals("0")) // 활동중인 동아리이면
			{
				Gson gson = new Gson();
				result = gson.toJson(dao.myClubActive(id));
			}
			else // 종료된 동아리이면
			{
				Gson gson = new Gson();
				result = gson.toJson(dao.myClubClosed(id));
			}
		
			model.addAttribute("myClubActive", result);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxMyClubActive.jsp";
	}
	
	// 가입 신청 동아리/개설 예정 동아리 가져오기
	@RequestMapping(value = "/ajaxgetclub.action", method = RequestMethod.POST)
	public String ajaxGetClub(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyClubDAO dao = sqlSession.getMapper(IMyClubDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		// 셀렉트박스 옵션값 가져오기
		String value = request.getParameter("value");
		//System.out.println(status);
		
		// 동아리 리스트 담을 변수
		String result = "";
		try
		{
			if (value.equals("join")) // 가입 신청 동아리이면
			{
				//System.out.println("Test");
				Gson gson = new Gson();
				result = gson.toJson(dao.getClubJoin(id));
			}
			else // 개설 예정 동아리이면
			{
				Gson gson = new Gson(); 
				result = gson.toJson(dao.getClubPreOpen(id));
				 
			}
		
			model.addAttribute("getClub", result);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxGetClub.jsp";
	}
	
	// 마이페이지 캘린더 - 동아리코드, 년, 월, id 로 모임 가져오기
	@RequestMapping(value = "/ajaxmypagecal.action", method = RequestMethod.POST)
	public String ajaxMyPageCal(HttpServletRequest request, Model model)
	{
		// 세션 처리 추가
		HttpSession session = request.getSession();
		
		IMyClubDAO dao = sqlSession.getMapper(IMyClubDAO.class);
		
		// 세션에서 id 얻어오기
		Object getId = session.getAttribute("id");
		String id = (String)getId;
		
		// 활동중: 0, 활동종료: 1
		String status = request.getParameter("status");
		//System.out.println(status);
		
		// radio 옵션값 가져오기
		String cid = request.getParameter("cid");
		
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		// 월이 한 자리 수이면 앞에 0을 붙여줌. 
		if (Integer.parseInt(month) < 10)
			month = "0" + month;
		//System.out.println(year + "-" + month);
		
		// 동아리 리스트 담을 변수
		String result = "";
		try
		{
			Gson gson = new Gson(); 
			
			if(status.equals("0")) 	// 활동중 동아리
			{
				if(cid.equals("total"))
					result = gson.toJson(dao.getMyPageTotalCal(year, month, id));
				else
					result = gson.toJson(dao.getMyPageCal(cid, year, month, id));
			}
			else					// 활동 종료 동아리
			{
				  if(cid.equals("total")) 
					  result = gson.toJson(dao.getMyPageTotalCalClosed(year, month, id)); 
				  else 
					  result = gson.toJson(dao.getMyPageCalClosed(cid, year, month, id));
				 
			}
				
			
			
			model.addAttribute("getCal", result);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return "/WEB-INF/view/AjaxMyPageCal.jsp";
	}
	
}

