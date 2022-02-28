package com.bcle.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.bcle.DTO.Summary;

public class SummaryDAO implements ISummaryDAO
{


   private DataSource dataSource;

   

   public void setDataSource(DataSource dataSource)
   {
      this.dataSource = dataSource;
   }

   // 총 동아리 수
   @Override
   public int calcTotClub() throws SQLException
   {
      int result = 0;
      Connection conn = dataSource.getConnection();
      String sql = "SELECT COUNT(*) AS COUNT FROM CLUB";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         result = rs.getInt("COUNT");
      }

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }

   
   // 당일 정모 수
   @Override
   public int calcBee() throws SQLException
   {
      int result = 0;
      Connection conn = dataSource.getConnection();
      String sql = "SELECT COUNT(*) AS COUNT " + "FROM CLUBBEEVIEW "
            + "WHERE MIN <= REQCNT AND TO_CHAR(BEETIME) = TO_CHAR(SYSDATE,'YYYY-MM-DD')";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         result = rs.getInt("COUNT");
      }

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }

   // 신규 가입자 수 (당일 기준)
   @Override
   public int calcNewbie() throws SQLException
   {
      int result = 0;
      Connection conn = dataSource.getConnection();
      String sql = "SELECT COUNT(*) AS COUNT FROM MEMBER WHERE TO_DATE(BDATE,'YYYY-MM-DD') = TO_DATE(SYSDATE,'YYYY-MM-DD')";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         result = rs.getInt("COUNT");
      }

      rs.close();
      pstmt.close();
      conn.close();
      
      return result;
      
   }

   // 신규 동아리 수
   @Override
   public int calcNewClub() throws SQLException
   {

      int result = 0;
      Connection conn = dataSource.getConnection();
      String sql = "SELECT COUNT(*) FROM CLUB WHERE TO_CHAR(BDATE) = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         result = rs.getInt(1);
      }

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }

   @Override
   public ArrayList<Summary> list() throws SQLException
   {
      ArrayList<Summary> result = new ArrayList<Summary>();
      Connection conn = dataSource.getConnection();
      String sql = "SELECT MONTH1, MONTH2, MONTH3, MONTH4, MONTH5, MONTH6 FROM MEM_TOT_CNT_VIEW";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         Summary dto = new Summary();

         dto.setPerTimeMemCnt1(rs.getInt("MONTH1"));
         dto.setPerTimeMemCnt2(rs.getInt("MONTH2"));
         dto.setPerTimeMemCnt3(rs.getInt("MONTH3"));
         dto.setPerTimeMemCnt4(rs.getInt("MONTH4"));
         dto.setPerTimeMemCnt5(rs.getInt("MONTH5"));
         dto.setPerTimeMemCnt6(rs.getInt("MONTH6"));

         result.add(dto);

      }

      rs.close();
      pstmt.close();
      conn.close();

      return result;

   }

   public ArrayList<Summary> p_list() throws SQLException
   {
      ArrayList<Summary> result = new ArrayList<Summary>();
      Connection conn = dataSource.getConnection();
      String sql = "SELECT MONTH1,MONTH2,MONTH3,MONTH4,MONTH5,MONTH6 FROM P_M_VIEW";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         Summary dto = new Summary();

         dto.setP_TimerMemCnt1(rs.getInt("MONTH1"));
         dto.setP_TimerMemCnt2(rs.getInt("MONTH2"));
         dto.setP_TimerMemCnt3(rs.getInt("MONTH3"));
         dto.setP_TimerMemCnt4(rs.getInt("MONTH4"));
         dto.setP_TimerMemCnt5(rs.getInt("MONTH5"));
         dto.setP_TimerMemCnt6(rs.getInt("MONTH6"));

         result.add(dto);

      }

      rs.close();
      pstmt.close();
      conn.close();

      return result;

   }

   // 카테고리별 동아리 가입자 수 (당일)
   @Override
   public int cateNewbie(String category_l_id) throws SQLException
   {
      
      int result = 0;
      
      Connection conn = dataSource.getConnection();
      
      String sql = "SELECT COUNT(*) AS CATCOUNT " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND TO_CHAR(BDATE) = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
      
      
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, category_l_id);
      ResultSet rs = pstmt.executeQuery();
      
      
      while (rs.next())
         result = rs.getInt("CATCOUNT");

      rs.close();
      pstmt.close();
      conn.close();
      return result;

   }

   //카테고리별 평균 정모 횟수
   public int cateMoney(String category_l_id) throws SQLException
   {
      int result = 0;
      
      Connection conn = dataSource.getConnection();
      
      String sql = "SELECT NVL(ROUND(SUM(FEE)/COUNT(*)),0) AS AVG_MONEY " + 
            "FROM BEEVIEW B LEFT JOIN CLUBMEMBERLIST L " + 
            "ON L.CLUBMEM_ID = B.CLUBMEM_ID " + 
            "LEFT JOIN JOIN_CLUB JC " + 
            "ON JC.JOIN_ID = L.JOIN_ID " + 
            "LEFT JOIN CLUB C " + 
            "ON C.CID = JC.CID " + 
            "LEFT JOIN CATEGORY_S CS " + 
            "ON CS.CATEGORY_S_ID = C.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL " + 
            "ON CS.CATEGORY_L_ID = CL.CATEGORY_L_ID " + 
            "WHERE (TO_DATE(B.BEETIME, 'YYYY-MM-DD HH24:MI:SS') < SYSDATE AND MIN < B.REQCNT) AND B.TYPE_ID = '1' AND CL.CATEGORY_L_ID = ? " + 
            "ORDER BY TO_NUMBER(B.BEE_ID) DESC";
      
      
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, category_l_id);
      ResultSet rs = pstmt.executeQuery();
      
      
      while (rs.next())
         result = rs.getInt("AVG_MONEY");

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }

   public ArrayList<Summary> catelist(String category_l_id) throws SQLException
   {
      
      ArrayList<Summary> result = new ArrayList<Summary>();
      
      Connection conn = dataSource.getConnection();
      String sql = "SELECT (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=30) AS MONTH1 " + 
            ", (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=60) AS MONTH2 " + 
            ", (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=90) AS MONTH3 " + 
            ", (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=120) AS MONTH4 " + 
            ", (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=150) AS MONTH5 " + 
            ", (SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CC ON J.CID=CC.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CC.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_L_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE)-TO_DATE(C.BDATE))<=180) AS MONTH6 " + 
            "FROM DUAL";
      
      PreparedStatement pstmt = conn.prepareStatement(sql);

      pstmt.setString(1, category_l_id);
      pstmt.setString(2, category_l_id);
      pstmt.setString(3, category_l_id);
      pstmt.setString(4, category_l_id);
      pstmt.setString(5, category_l_id);
      pstmt.setString(6, category_l_id);
      
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         Summary dto = new Summary();

         dto.setPerCateMemCnt1(rs.getInt("MONTH1"));
         dto.setPerCateMemCnt2(rs.getInt("MONTH2"));
         dto.setPerCateMemCnt3(rs.getInt("MONTH3"));
         dto.setPerCateMemCnt4(rs.getInt("MONTH4"));
         dto.setPerCateMemCnt5(rs.getInt("MONTH5"));
         dto.setPerCateMemCnt6(rs.getInt("MONTH6"));

         result.add(dto);

      }

      rs.close();
      pstmt.close();
      conn.close();
      
      return result;
   
   }
   
   // 카테고리별 당일 동아리 수 횟수
   public int cateClubCnt(String category_l_id) throws SQLException
   {
      int result=0;
      
      Connection conn = dataSource.getConnection();
      String sql = "SELECT COUNT(*) AS CATE_CLUBCNT " + 
            "FROM CLUB C " + 
            "LEFT JOIN CATEGORY_S CS ON C.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CS.CATEGORY_L_ID = CL.CATEGORY_L_ID " + 
            "WHERE TO_CHAR(BDATE) = TO_CHAR(SYSDATE, 'YYYY-MM-DD') AND CS.CATEGORY_L_ID = ?";
      
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, category_l_id);
      ResultSet rs = pstmt.executeQuery();
      
      while(rs.next())
         result = rs.getInt("CATE_CLUBCNT");
      
      rs.close();
      pstmt.close();
      conn.close();
      
      return result;
   }

   @Override
   public ArrayList<Summary> top_list(String category_l_id) throws SQLException
   {
      ArrayList<Summary> result = new ArrayList<Summary>();
      
      Connection conn = dataSource.getConnection();
      String sql = "SELECT ROWNUM, T.CITY AS CITY, T.CNT AS CNT " + 
            "FROM " + 
            "( " + 
            "SELECT CITY, COUNT(CITY) AS CNT " + 
            "FROM CLUB C " + 
            "LEFT JOIN REGION_S RS ON C.REGION_S_ID = RS.REGION_S_ID " + 
            "LEFT JOIN REGION_L RL ON RS.REGION_L_ID = RL.REGION_L_ID " + 
            "LEFT JOIN CATEGORY_S CS ON C.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CS.CATEGORY_L_ID = CL.CATEGORY_L_ID " + 
            "WHERE CS.CATEGORY_L_ID = ? " + 
            "GROUP BY CITY " + 
            "ORDER BY COUNT(CITY) DESC " + 
            ") T " + 
            "WHERE ROWNUM <=5";
      
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, category_l_id);
      ResultSet rs = pstmt.executeQuery();
      
      while(rs.next())
      {
         Summary dto = new Summary();
         
         dto.setCity(rs.getString("CITY"));
         dto.setCnt(rs.getInt("CNT"));
         
         result.add(dto);
         
      }
      rs.close();
      pstmt.close();
      conn.close();
      
      return result;
      
   }
   
   public ArrayList<Summary> catevariation(String category_l_id) throws SQLException
   {
      
      ArrayList<Summary> result = new ArrayList<Summary>();
      
      Connection conn = dataSource.getConnection();
      String sql = "SELECT FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND BDATE=SYSDATE),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=30)) AS MONTH1 " + 
            ",FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=30),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 30 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=60)) AS MONTH2 " + 
            ", FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 30 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=60),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 60 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=90)) AS MONTH3 " + 
            ", FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 60 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=90),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 90 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=120)) AS MONTH4 " + 
            ", FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 90 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=120),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 120 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=150)) AS MONTH5 " + 
            ", FN_MEMBER_PERCHAN((SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 120 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=150),(SELECT COUNT(*) " + 
            "FROM CLUBMEMBERLIST C " + 
            "LEFT JOIN JOIN_CLUB J ON C.JOIN_ID = J.JOIN_ID " + 
            "LEFT JOIN CLUB CL ON J.CID=CL.CID " + 
            "LEFT JOIN CATEGORY_S CS ON CL.CATEGORY_S_ID = CS.CATEGORY_S_ID " + 
            "LEFT JOIN CATEGORY_L CL ON CL.CATEGORY_L_ID = CS.CATEGORY_S_ID " + 
            "WHERE CL.CATEGORY_L_ID=? AND 150 < ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) AND ROUND(TO_DATE(SYSDATE) - TO_DATE(BDATE)) <=180)) AS MONTH6 " + 
            "FROM DUAL";
      
      PreparedStatement pstmt = conn.prepareStatement(sql);

      pstmt.setString(1, category_l_id);
      pstmt.setString(2, category_l_id);
      pstmt.setString(3, category_l_id);
      pstmt.setString(4, category_l_id);
      pstmt.setString(5, category_l_id);
      pstmt.setString(6, category_l_id);
      pstmt.setString(7, category_l_id);
      pstmt.setString(8, category_l_id);
      pstmt.setString(9, category_l_id);
      pstmt.setString(10, category_l_id);
      pstmt.setString(11, category_l_id);
      pstmt.setString(12, category_l_id);
      
      ResultSet rs = pstmt.executeQuery();

      while (rs.next())
      {
         Summary dto = new Summary();

         dto.setPerCateMemCnt1(rs.getInt("MONTH1"));
         dto.setPerCateMemCnt2(rs.getInt("MONTH2"));
         dto.setPerCateMemCnt3(rs.getInt("MONTH3"));
         dto.setPerCateMemCnt4(rs.getInt("MONTH4"));
         dto.setPerCateMemCnt5(rs.getInt("MONTH5"));
         dto.setPerCateMemCnt6(rs.getInt("MONTH6"));
         
         result.add(dto);
      
      }

      rs.close();
      pstmt.close();
      conn.close();
      
      return result;
   
   }
   
}