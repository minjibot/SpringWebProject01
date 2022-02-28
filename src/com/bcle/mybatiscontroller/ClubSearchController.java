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

import com.bcle.DAO.IClubDAO;
import com.bcle.DTO.Category;
import com.bcle.DTO.Club;
import com.bcle.DTO.ClubSearch;
import com.bcle.DTO.Recruit;
import com.bcle.controller.ClubPaging;
import com.bcle.controller.Paging;

@Controller
public class ClubSearchController
{
   @Autowired
   private SqlSession sqlSession;
   
   @RequestMapping(value="/catclublist.action", method = RequestMethod.GET)
   public String clubList(String category_l_id, ModelMap model)
   {
      IClubSearchDAO dao = sqlSession.getMapper(IClubSearchDAO.class);
      
      model.addAttribute("category_l_id", category_l_id);
      model.addAttribute("cateLname", dao.cateLname(category_l_id));
      model.addAttribute("cateS", dao.cateS_List(category_l_id));
      model.addAttribute("regionL", dao.regionL_List());
      
      return "/WEB-INF/view/CategoryPage.jsp";
   }
   
   @RequestMapping(value = "/ajaxcatclublist.action", method = RequestMethod.POST)
   public String ajaxClubList(ClubSearch c,ModelMap model, HttpServletRequest request)
   {

      IClubSearchDAO dao = sqlSession.getMapper(IClubSearchDAO.class);
      
      /*
       * // 세션처리 ----------------------------------------- HttpSession session =
       * request.getSession(); if (session.getAttribute("id") == null) // -- 로그인이 되어
       * 있지 않은 상황 { return "redirect:loginpage.action"; } //
       * ------------------------------------------------- 세션 처리
       */
      // 페이징
      ClubPaging paging = new ClubPaging();
      
      // 넘어온(요청된) 페이지 번호 확인
      //String pageNum = request.getParameter("pageNum");
      
      // 현재 표시되어야 하는 페이지
      int currentPage = 1;
      
      //System.out.println("확인");
      //System.out.println(c.getCategory_l_id()+c.getPageNum()+c.getSortOrder());
      
      if(c.getPageNum() != 0)
         currentPage = c.getPageNum();
      
      //System.out.println(currentPage);
      
      /*
      //넘어온 값 수신 
      String cid = request.getParameter("cid");
      String sortOrder = request.getParameter("sortOrder");
      */
       //System.out.println(sortOrder + "입니다");
      
      // 전체 동아리 갯수 구하기
      int dataCount = dao.clubCount(c);
      
      //System.out.println(dataCount);
      
      // 전체 페이지를 기준으로 총 페이지 수 계산
      int numPerPage = 4;      //-- 한 페이지에 표시할 데이터 갯수
      int totalPage = paging.getPageCount(numPerPage, dataCount);
      
      //System.out.println(totalPage);
      
      // 전체 페이지 수 보다 표시할 페이지가 큰 경우
      // 표시할 페이지를 전체 페이지로 처리
      if (currentPage > totalPage)
         currentPage = totalPage;
      
      int start = (currentPage-1) * numPerPage + 1;
      int end = (currentPage * numPerPage);
      
      c.setStart(start);
      c.setEnd(end);
      
      //실제 동아리 리스트 가져오기
      ArrayList<Club> lists = dao.clubList(c);
      
      //System.out.println(lists.get(4).getTitle());
      
      String pageIndexList = paging.pageIndexList(currentPage, totalPage);
      
      //System.out.println("페이지인덱스" + pageIndexList);
      
      model.addAttribute("lists", lists);
      model.addAttribute("pageIndexList", pageIndexList);

      return "/WEB-INF/view/AjaxCatClubList.jsp";
   }
   
   @RequestMapping(value = "/ajaxpreclublist.action", method = RequestMethod.POST)
   public String ajaxPreClubList(ClubSearch c,ModelMap model, HttpServletRequest request)
   {

      IClubSearchDAO dao = sqlSession.getMapper(IClubSearchDAO.class);
      
      /*
       * // 세션처리 ----------------------------------------- HttpSession session =
       * request.getSession(); if (session.getAttribute("id") == null) // -- 로그인이 되어
       * 있지 않은 상황 { return "redirect:loginpage.action"; } //
       * ------------------------------------------------- 세션 처리
       */
      // 페이징
      ClubPaging paging = new ClubPaging();
      
      // 현재 표시되어야 하는 페이지
      int currentPage = 1;
      
      if(c.getPageNum() != 0)
         currentPage = c.getPageNum();
      
      // 전체 동아리 갯수 구하기
      int dataCount = dao.preClubCount(c);
      
      
      // 전체 페이지를 기준으로 총 페이지 수 계산
      int numPerPage = 9;      //-- 한 페이지에 표시할 데이터 갯수
      int totalPage = paging.getPageCount(numPerPage, dataCount);
      
      //System.out.println(totalPage);
      
      if (currentPage > totalPage)
         currentPage = totalPage;
      
      int start = (currentPage-1) * numPerPage + 1;
      int end = (currentPage * numPerPage);
      
      c.setStart(start);
      c.setEnd(end);
      
      //실제 동아리 리스트 가져오기
      ArrayList<Club> lists = dao.preClubList(c);
      
      //30일 지났는데 총무, 스태프 없으면 삭제 
      for (Club club : lists)
      {
         if(club.getDay() <1 && (dao.managerCnt(club.getCid()) < 1 || dao.staffCnt(club.getCid()) <1) )
         {
            dao.delete(club.getCid());
         }
      }
      
      ArrayList<Club> lists2 = dao.preClubList(c);
      
      
      String pageIndexList = paging.pageIndexList(currentPage, totalPage);
      
      
      model.addAttribute("lists", lists2);
      model.addAttribute("pageIndexList", pageIndexList);

      return "/WEB-INF/view/AjaxPreClubList.jsp";
   }
   
   @RequestMapping(value="/clubsearch.action", method = RequestMethod.GET)
   public String mainClubSearch(String keyword, ModelMap model)
   {
      IClubSearchDAO dao = sqlSession.getMapper(IClubSearchDAO.class);
      
      model.addAttribute("keyword", keyword);
      model.addAttribute("cateL", dao.cateL_List());
      model.addAttribute("regionL", dao.regionL_List());
      
      return "/WEB-INF/view/MainClubSearch.jsp";
   }
   
   @RequestMapping(value = "/ajaxclubsearchlist.action", method = RequestMethod.POST)
   public String ajaxClubSearchList(ClubSearch c,ModelMap model, HttpServletRequest request)
   {

      IClubSearchDAO dao = sqlSession.getMapper(IClubSearchDAO.class);
      
      /*
       * // 세션처리 ----------------------------------------- HttpSession session =
       * request.getSession(); if (session.getAttribute("id") == null) // -- 로그인이 되어
       * 있지 않은 상황 { return "redirect:loginpage.action"; } //
       * ------------------------------------------------- 세션 처리
       */
      // 페이징
      ClubPaging paging = new ClubPaging();
      
      int currentPage = 1;
      
      if(c.getPageNum() != 0)
         currentPage = c.getPageNum();
      
      // 전체 동아리 갯수 구하기
      int dataCount = dao.clubSearchCount(c);
      
      int numPerPage = 4;   
      int totalPage = paging.getPageCount(numPerPage, dataCount);
      
      if (currentPage > totalPage)
         currentPage = totalPage;
      
      int start = (currentPage-1) * numPerPage + 1;
      int end = (currentPage * numPerPage);
      
      c.setStart(start);
      c.setEnd(end);
      
      //실제 동아리 리스트 가져오기
      ArrayList<Club> lists = dao.clubSearchList(c);
      
      String pageIndexList = paging.pageIndexList(currentPage, totalPage);
      
      model.addAttribute("lists", lists);
      model.addAttribute("pageIndexList", pageIndexList);

      return "/WEB-INF/view/AjaxCatClubList.jsp";
   }
}