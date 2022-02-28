/*==========================
 * SampleController.java
 * -  궗 슜 옄  젙 쓽 而⑦듃濡ㅻ윭
==========================*/

package com.bcle.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.bcle.DAO.ISummaryDAO;
import com.bcle.DTO.Summary;

public class MainPageAccountListController implements Controller
{
   
   private ISummaryDAO dao;
   

   public void setDao(ISummaryDAO dao)
   {
      this.dao = dao;
   }


   @Override
   public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
   {
      ModelAndView mav = new ModelAndView();
      
      String category_L_ID = request.getParameter("category_L_ID");
      
      int beecnt = 0;
      int newclubcnt = 0;
      int newbiecnt = 0;
      int totclubcnt = 0;
      int pertimememcnt = 0;
      ArrayList<Summary> summaryList = new ArrayList<Summary>();
      ArrayList<Summary> psummaryList = new ArrayList<Summary>();
      
      // 카테고리
      ArrayList<Summary> cateList = new ArrayList<Summary>();
      
      
      if(category_L_ID==null)
      {
         category_L_ID = "1";
      }
      
      int catenewbie = 0;
      int catemoney = 0;
      int cateclubcnt = 0;
      ArrayList<Summary> topList = new ArrayList<Summary>();
      ArrayList<Summary> catevariationList = new ArrayList<Summary>();
      
      try
      {
         
         newbiecnt = dao.calcNewbie();
         psummaryList = dao.p_list();
         summaryList = dao.list(); 
         beecnt = dao.calcBee();
         newclubcnt = dao.calcNewClub();
         totclubcnt = dao.calcTotClub();
         
         catenewbie = dao.cateNewbie(category_L_ID);
         catemoney = dao.cateMoney(category_L_ID);
         cateList = dao.catelist(category_L_ID);
         cateclubcnt = dao.cateClubCnt(category_L_ID);
         topList = dao.top_list(category_L_ID);
         //System.out.println(topList.size());
         for (int i=0; i<topList.size(); i++)
         {
            mav.addObject("topListCity" + i, topList.get(i).getCity());
            mav.addObject("topListCnt" + i, topList.get(i).getCnt());
         }
            
         catevariationList = dao.catevariation(category_L_ID);
         
         
         mav.addObject("totclubcnt", totclubcnt);
         mav.addObject("newbiecnt", newbiecnt);
         mav.addObject("newclubcnt", newclubcnt);
         mav.addObject("beecnt",beecnt);
         mav.addObject("pertimememcnt",pertimememcnt);
         mav.addObject("summaryList", summaryList);
         mav.addObject("psummaryList", psummaryList);
         mav.addObject("catenewbie",catenewbie);
         mav.addObject("catemoney", catemoney);
         mav.addObject("cateList", cateList);
         mav.addObject("cateclubcnt", cateclubcnt);
         mav.addObject("catevariationList", catevariationList);
         
         mav.setViewName("/WEB-INF/view/MainAccount.jsp");
         
         
      } catch (Exception e)
      {
         System.out.println(e.toString());
      }
      
      
      return mav;
   }
   
   
   
   
}
