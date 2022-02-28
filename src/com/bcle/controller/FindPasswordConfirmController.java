/*===============================
   FindPasswordConfirmController.java
   - 사용자 정의 컨트롤러
===============================*/

package com.bcle.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.bcle.DAO.IMemberInfoDAO;

public class FindPasswordConfirmController implements Controller
{
   private IMemberInfoDAO dao;
   
   public void setDao(IMemberInfoDAO dao)
   {
      this.dao = dao;
   }

   @Override
   public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
   {
      ModelAndView mav = new ModelAndView();
      
      String userId = request.getParameter("userId");
      String email = request.getParameter("email");
      
      String fail = null;
      
      // 회원가입 시 닉네임과 아이디를 받아오기 위함 
      int checkPassword = dao.findPwd(userId, email);
      
      if(checkPassword==1)
      {
         mav.addObject("userId", userId);
         mav.setViewName("/WEB-INF/view/FindPasswordConfirm.jsp");
      }
      else
      {
         fail = "존재";
         mav.addObject("fail", fail);
         mav.setViewName("/WEB-INF/view/FindingPassword.jsp");
      }
      return mav;
   }

}