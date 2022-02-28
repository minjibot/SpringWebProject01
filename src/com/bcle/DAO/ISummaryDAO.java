/*================================
 * ISummaryDAO.java
 * - 메인 결산 인터페이스
================================*/

package com.bcle.DAO;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bcle.DTO.Summary;

public interface ISummaryDAO
{
   // 총 동아리 수
   public int calcTotClub() throws SQLException;
   
   // 정모 수(당일)
   public int calcBee() throws SQLException;
   
   // 신규 가입자 수(당일)
   public int calcNewbie() throws SQLException;
   
   // 신규 동아리 수(당일)
   public int calcNewClub() throws SQLException;
   
   public ArrayList<Summary> list() throws SQLException;

   public ArrayList<Summary> p_list() throws SQLException;

   //------------------ 카테고리별 결산------------------
   
   // 카테고리별 신규(당일 가입자 수)
   public int cateNewbie(String category_l_id) throws SQLException;
   
   // 카테고리별 정모 평균 회비
   public int cateMoney(String category_l_id) throws SQLException;
   
   public ArrayList<Summary> catelist(String category_l_id) throws SQLException;
   
   // 카테고리별 당일 동아리 수
   public int cateClubCnt(String category_l_id) throws SQLException;
   
   public ArrayList<Summary> top_list(String category_l_id) throws SQLException;
   
   public ArrayList<Summary> catevariation(String category_l_id) throws SQLException;
   
}