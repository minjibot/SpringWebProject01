package com.bcle.mybatiscontroller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bcle.DTO.Club;
import com.bcle.DTO.MemberEval;
import com.bcle.DTO.MemberInfo;
import com.bcle.DTO.Recruit;
import com.bcle.DTO.Volunteer;
import com.bcle.controller.Paging;
import com.google.gson.Gson;

@Controller
public class RecruitController
{
   @Autowired
   private SqlSession sqlSession;

   @RequestMapping(value = "/recruitlist.action", method = RequestMethod.GET)
   public String recruitList(Recruit r, ModelMap model, HttpServletRequest request)
   {

      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ------------------------------------------------- 세션 처리
      
      //
      String id = (String) session.getAttribute("id");
      String cid = request.getParameter("cid");

      // System.out.println(id+"확인");
      // System.out.println(cid);
      // System.out.println(dao.positionCheck(id,cid));
      model.addAttribute("cid", cid);
      model.addAttribute("positionCheck", dao.positionCheck(id, cid)); //모집등록은 동아리장만 할 수 있기 때문에 필요
      //model.addAttribute("list", dao.list(r));

      return "/WEB-INF/view/RecruitList.jsp";
   }
   @RequestMapping(value = "/ajaxrecruitlist.action", method = RequestMethod.POST)
   public String ajaxRecruitList(ModelMap model, HttpServletRequest request)
   {

      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ------------------------------------------------- 세션 처리
      
      // 페이징
      Paging paging = new Paging();
      
      // 넘어온(요청된) 페이지 번호 확인
      String pageNum = request.getParameter("pageNum");
      
      // 현재 표시되어야 하는 페이지
      int currentPage = 1;

      if(pageNum != null)
         currentPage = Integer.parseInt(pageNum);
      
      //넘어온 값 수신 
      String cid = request.getParameter("cid");
      String sortOrder = request.getParameter("sortOrder");
      
       //System.out.println(sortOrder + "입니다");
      
      // 전체 리뷰 갯수 구하기
      int dataCount = dao.listCount(cid, sortOrder);
      
      //System.out.println(dataCount);
      
      // 전체 페이지를 기준으로 총 페이지 수 계산
      int numPerPage = 10;      //-- 한 페이지에 표시할 데이터 갯수
      int totalPage = paging.getPageCount(numPerPage, dataCount);
      
      //System.out.println(totalPage);
      
      // 전체 페이지 수 보다 표시할 페이지가 큰 경우
      // 표시할 페이지를 전체 페이지로 처리
      if (currentPage > totalPage)
         currentPage = totalPage;
      
      // 데이터베이스에서 가져올 시작과 끝 위치(1페이지의 start/end, 2페이지의 start/end, ... 페이지마다 개수가 다를수있음)
      int start = (currentPage-1) * numPerPage + 1;
      int end = (currentPage * numPerPage);
      
      //실제 리스트 가져오기
      ArrayList<Recruit> lists = dao.lists(cid, start, end, sortOrder);
      
      //운영진 투표발의 check 및 insert
      for (Recruit recruit : lists)
      {
         if(recruit.getDay() <= 0)
         {
            int insertCheck = dao.motionVoteCheck(recruit);
            if(insertCheck == 0) 
               dao.motionVoteInsert(recruit);
         }
      }
      
      //System.out.println(lists.get(4).getTitle());
      
      String pageIndexList = paging.pageIndexList(currentPage, totalPage);
      
      //System.out.println("페이지인덱스" + pageIndexList);
      
      model.addAttribute("lists", lists);
      model.addAttribute("pageIndexList", pageIndexList);
      model.addAttribute("cid", cid);

      return "/WEB-INF/view/AjaxRecruitList.jsp";
   }

   @RequestMapping(value = "/recruitinsertform.action", method = RequestMethod.GET)
   public String showInsertForm(ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ----------------------------------------------------

      String cid = request.getParameter("cid");
      model.addAttribute("cid", cid);

      return "/WEB-INF/view/Recruit.jsp";

   }

   @RequestMapping(value = "/recruitinsert.action", method = RequestMethod.POST)
   public String addRecruit(Recruit r, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      String cid = request.getParameter("cid");
      String id = (String) session.getAttribute("id");

      String clubmem_id = dao.searchClubmemId(id, cid); 
      r.setClubmem_id(clubmem_id);
      //세션id(memberinfo주키) 와 cid를 통해 clubmem_id 찾아내서 Recruit dto에 set해줌 
      // => insert에 clubmem_id로 들어가야 해서 clubmem_id가 필요했기 때문 

      dao.add(r); //모집글 insert

      return "redirect:recruitlist.action?cid=" + cid;
   }

   @RequestMapping(value = "/recruitarticle.action", method = RequestMethod.GET)
   public String showRecruit(Recruit r,ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ----------------------------------------------------
      String id = (String) session.getAttribute("id");
      
      String pageNum = request.getParameter("pageNum");
      //System.out.println(pageNum);
      
      dao.updateCnt(r); // 조회수 증가 
      //System.out.println(r.getCid());
      //System.out.println(dao.positionCheck(id, r.getCid()));
      
      Recruit recruit = dao.showRecruit(r);
      int exeVoteCheck = -1;
      String pickNickname = "";
      String clubmem_id = dao.searchClubmemId(id, recruit.getCid());
      
      int day = recruit.getDay(); 
      if (day < 1) 
      {
         //* -> 운영진 투표발의check 및 insert, 여기서 말고 list에서 해야할듯
         
         //운영진 투표 여부 추가 
         exeVoteCheck = dao.exeVoteCheck(clubmem_id, recruit.getMotion_id());
         //System.out.println(exeVoteCheck);
      }
      //자신이 투표한 회원
      if(exeVoteCheck == 1)
      {
         String volunteer_id = dao.exeVoteVolunteerId(clubmem_id, recruit.getMotion_id());
         pickNickname = dao.exeVoteVolunteer(volunteer_id);

      }
      //투표 마감 후 당선자 선정
      Volunteer winner = new Volunteer();
      
      if(day <= -3 && recruit.getVolunteer_count() > 0) //투표 마감 + 신청자 있을 때
      {
         if(recruit.getVote_count() > 0) //투표자 있는경우
            winner = dao.selectWinner(recruit.getMotion_id());
         else // 없는 경우
            winner = dao.selectWinner2(recruit.getB_id());
      }
      
      
      model.addAttribute("showRecruit", recruit);
      model.addAttribute("positionCheck", dao.positionCheck(id, r.getCid())); //포지션 확인 추가 (신청하기 버튼 때문에)
      model.addAttribute("volunteerList", dao.volunteerList(r));//신청자 리스트 추가
      model.addAttribute("applyCheck", dao.applyCheck(r.getB_id(), id));//신청 여부 추가
      model.addAttribute("exeVoteCheck", exeVoteCheck); //투표 여부 추가 
      model.addAttribute("pickNickname", pickNickname); //선택한 신청자의 닉네임 
      model.addAttribute("winner", winner);
      //model.addAttribute("pageNum", pageNum);
      
      return "/WEB-INF/view/RecruitArticle.jsp";

   }
   
   @RequestMapping(value = "/recruitupdateform.action", method = RequestMethod.GET)
   public String recruitUpdateForm(Recruit r,ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ----------------------------------------------------
      
      model.addAttribute("recruit", dao.showRecruit(r));

      return "/WEB-INF/view/RecruitUpdateForm.jsp";

   }
   
   @RequestMapping(value = "/recruitupdate.action", method = RequestMethod.POST)
   public String modifyRecruit(Recruit r, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      
      dao.modify(r); //모집글 update

      return "redirect:recruitarticle.action?b_id=" + r.getB_id() + "&cid="+ r.getCid();
   }
   
   @RequestMapping(value = "/recruitdelete.action", method = RequestMethod.GET)
   public String deleteRecruit(Recruit r,ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      // ----------------------------------------------------
      
      dao.delete(r);

      return "redirect:recruitlist.action?cid=" + r.getCid();
   }
   
   @RequestMapping(value = "/recruitapply.action", method = RequestMethod.GET)
   public String apply(Volunteer v, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      String id = (String) session.getAttribute("id");
      String clubmem_id = dao.searchClubmemId(id, v.getCid());
      v.setClubmem_id(clubmem_id);
   
      dao.apply(v); //모집 지원하기 insert

      return "redirect:recruitarticle.action?b_id=" + v.getB_id() +"&cid=" + v.getCid();
   }
   
   @RequestMapping(value = "/recruitapplycancle.action", method = RequestMethod.GET)
   public String applyCancle(Volunteer v, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      String id = (String) session.getAttribute("id");
      String clubmem_id = dao.searchClubmemId(id, v.getCid());
      v.setClubmem_id(clubmem_id);
   
      dao.cancle(v); //모집지원 취소 delete

      return "redirect:recruitarticle.action?b_id=" + v.getB_id() +"&cid=" + v.getCid();
   }
   
   @RequestMapping(value = "/recruitvote.action", method = RequestMethod.GET)
   public String exeVote(String volunteer_id,String motion_id,Recruit r, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      String id = (String) session.getAttribute("id");
      String clubmem_id = dao.searchClubmemId(id, r.getCid());
      //System.out.println(clubmem_id);
   
      dao.exeVote(motion_id, volunteer_id, clubmem_id); //운영진 투표 insert

      return "redirect:recruitarticle.action?b_id=" + r.getB_id() +"&cid=" + r.getCid();
   }
   
   @RequestMapping(value = "/recruitvotecancle.action", method = RequestMethod.GET)
   public String exeVoteCancle(String motion_id,Recruit r, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      String id = (String) session.getAttribute("id");
      String clubmem_id = dao.searchClubmemId(id, r.getCid());
      //System.out.println(clubmem_id);
   
      dao.exeVoteCancle(clubmem_id, motion_id);//운영진 투표 delete

      return "redirect:recruitarticle.action?b_id=" + r.getB_id() +"&cid=" + r.getCid();
   }
   
   @RequestMapping(value = "/ajaxprofileinfo.action", method = RequestMethod.POST)
   public String showProfileInfo(String id, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      
      System.out.println(id);
      
      MemberInfo info = dao.profileInfo(id);
      
      Gson gson = new Gson();
        String result = gson.toJson(info);
      
        model.addAttribute("info", result);
        
      return "/WEB-INF/view/AjaxProfileInfo.jsp";
   }
   
   @RequestMapping(value = "/ajaxprofileclub.action", method = RequestMethod.POST)
   public String showProfileClub(String id, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      ArrayList<Club> clubList = dao.profileClub(id);
      
      Gson gson = new Gson();
        String result = gson.toJson(clubList);
      
        model.addAttribute("clubList", result);
        
      return "/WEB-INF/view/AjaxProfileClub.jsp";
   }
   
   @RequestMapping(value = "/ajaxprofileeval.action", method = RequestMethod.POST)
   public String showProfileEval(String id, ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      
      ArrayList<MemberEval> memberEval = dao.profileEval(id);
      
      Gson gson = new Gson();
        String result = gson.toJson(memberEval);
      
        model.addAttribute("memberEval", result);
        
      return "/WEB-INF/view/AjaxProfileEval.jsp";
   }
   
   @RequestMapping(value = "/positionupdate.action", method = RequestMethod.GET)
   public String positionUpdate(ModelMap model, HttpServletRequest request)
   {
      IRecruitDAO dao = sqlSession.getMapper(IRecruitDAO.class);

      // 세션처리 -----------------------------------------
      HttpSession session = request.getSession();
      if (session.getAttribute("id") == null) // -- 로그인이 되어 있지 않은 상황
      {
         return "redirect:loginpage.action";
      }
      //
      
      String clubmem_id = request.getParameter("clubmem_id");
      String position_id = request.getParameter("position_id");
      String cid = request.getParameter("cid");
      //System.out.println(clubmem_id + position_id + cid);
      
      dao.positionUpdate(clubmem_id, position_id);
      
      return "redirect:recruitlist.action?cid="+ cid;
   }
   

}