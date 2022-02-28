/*==========================
 * SampleController.java
 * - 사용자 정의 컨트롤러
==========================*/

package com.bcle.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.bcle.DAO.IMemberInfoDAO;

public class ResetPasswordConfirmController implements Controller
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
      
      int check=0;
      
      String userId = request.getParameter("userId");
      String pwd = request.getParameter("pwd2");

      check = dao.resetPwd(userId, pwd);

      mav.addObject("userId", userId);
      mav.setViewName("/WEB-INF/view/ResetConfirm.jsp");
      
      
      return mav;
   }

}