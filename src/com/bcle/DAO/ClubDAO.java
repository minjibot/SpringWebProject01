package com.bcle.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.bcle.DTO.Category;
import com.bcle.DTO.Club;
import com.bcle.DTO.MemberInfo;
import com.bcle.DTO.Region;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;
import com.webjjang.util.PageObject;

public class ClubDAO implements IClubDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	@Override
	public ArrayList<Club> myList(String id) throws SQLException
	{
		ArrayList<Club> result = new ArrayList<Club>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT DISTINCT CID, MAX, BDATE, CONTENT"
				+ ", CATEGORY_S_ID, S_CAT, REGION_S_ID, LOCAL"
				+ ", MID, URL, TITLE, PREOPENDATE"
				+ ", AGELIMIT_ID, LIMIT_ID"
				+ " FROM CLUBVIEW"
				+ " WHERE ID = ? AND BDATE IS NOT NULL AND CLUBMEM_ID IS NOT NULL"
				+ " AND CLUBMEM_ID NOT IN (SELECT CLUBMEM_ID FROM BAN_MEM_LIST)"
				+ " AND CLUBMEM_ID NOT IN (SELECT CLUBMEM_ID FROM DROP_CLUB)"
				+ " AND CID NOT IN (SELECT CID FROM CLUBSTATUS WHERE STATUS_ID IN ('3', '4'))"
				+ " ORDER BY BDATE";
		
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Club club = new Club();
			
			club.setCid(rs.getString("CID"));
			club.setMax(rs.getInt("MAX"));
			club.setBdate(rs.getString("BDATE"));
			club.setContent(rs.getString("CONTENT"));
			club.setCategory_s_id(rs.getString("CATEGORY_S_ID"));
			club.setS_cat(rs.getString("S_CAT"));
			club.setRegion_s_id(rs.getString("REGION_S_ID"));
			club.setLocal(rs.getString("LOCAL"));
			club.setMid(rs.getString("MID"));
			club.setUrl(rs.getString("URL"));
			club.setTitle(rs.getString("TITLE"));
			club.setPreopendate(rs.getString("PREOPENDATE"));
			club.setAgelimit_id(rs.getString("AGELIMIT_ID"));
			club.setLimit_id(rs.getString("LIMIT_ID"));
			
			result.add(club);
		}
		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}
	
	@Override
	public ArrayList<Club> preOpenRandomList() throws SQLException
	{
		ArrayList<Club> result = new ArrayList<Club>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ROWNUM, T.CID, T.TITLE, T.URL"
				+ " FROM(SELECT  CID, TITLE, URL FROM CLUB_VIEW WHERE BDATE IS NULL ORDER BY DBMS_RANDOM.RANDOM) T"
				+ " WHERE ROWNUM<4";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Club club = new Club();
			
			club.setCid(rs.getString("CID"));
			club.setUrl(rs.getString("URL"));
			club.setTitle(rs.getString("TITLE"));
			
			result.add(club);
		}
		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}
	
	// ??????????????? ????????? ????????? ?????? ??????
	@Override
	public Club showClub(String cid) throws SQLException
	{
		
		Club result = new Club();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CID, MAX, BDATE, CONTENT"
				+ ", CATEGORY_L_ID, L_CAT, CATEGORY_S_ID, S_CAT"
				+ ", REGION_L_ID, CITY, REGION_S_ID, LOCAL"
				+ ", MID, URL, TITLE, PREOPENDATE, AGELIMIT_ID, LIMIT_ID"
				+ " FROM CLUBVIEW5"
				+ " WHERE CID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cid);		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setCid(rs.getString("CID"));
			result.setMax(rs.getInt("MAX"));
			result.setBdate(rs.getString("BDATE"));
			result.setContent(rs.getString("CONTENT"));
			result.setCategory_l_id(rs.getString("CATEGORY_L_ID"));
			result.setL_cat(rs.getString("L_CAT"));
			result.setCategory_s_id(rs.getString("CATEGORY_S_ID"));
			result.setS_cat(rs.getString("S_CAT"));
			result.setRegion_l_id(rs.getString("REGION_L_ID"));
			result.setCity(rs.getString("CITY"));
			result.setRegion_s_id(rs.getString("REGION_S_ID"));
			result.setLocal(rs.getString("LOCAL"));
			result.setMid(rs.getString("MID"));
			result.setUrl(rs.getString("URL"));
			result.setTitle(rs.getString("TITLE"));
			result.setPreopendate(rs.getString("PREOPENDATE"));
			result.setAgelimit_id(rs.getString("AGELIMIT_ID"));
			result.setLimit_id(rs.getString("LIMIT_ID"));

		}
		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}

	
	
	
	@Override
	public int countMember(String cid) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM CLUBMEM_CID_VIEW WHERE CID=? AND CLUBMEM_ID IS NOT NULL";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cid);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	

	@Override
	public ArrayList<MemberInfo> searchClubmem(String cid) throws SQLException
	{
		ArrayList<MemberInfo> result = new ArrayList<MemberInfo>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CLUBMEM_ID, NICKNAME, URL"
				+ " FROM CLUBMEM_CID_VIEW"
				+ " WHERE CID=? AND CLUBMEM_ID IS NOT NULL"
				+ " AND CLUBMEM_ID NOT IN (SELECT CLUBMEM_ID FROM BAN_MEM_LIST)"
				+ " AND CLUBMEM_ID NOT IN (SELECT CLUBMEM_ID FROM DROP_CLUB)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cid);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			MemberInfo dto = new MemberInfo();
			
			dto.setClubmemId(rs.getString("CLUBMEM_ID"));
			dto.setNickname(rs.getString("NICKNAME"));
			dto.setUrl(rs.getString("URL"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	@Override
	public int checkClubMember(String id, String cid) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM CLUBMEM_CID_VIEW WHERE NICKNAME = (SELECT NICKNAME FROM MEMBERINFO WHERE ID = ?) AND CID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);		
		pstmt.setString(2, cid);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result = rs.getInt("COUNT");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	@Override
	public int checkClubJoin(String id, String cid) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM GETJOINCLUBVIEW2 WHERE ID = ? AND CID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);		
		pstmt.setString(2, cid);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result = rs.getInt("COUNT");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int checkClubCap(String id, String cid) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT"
				+ " FROM CLUBMEMBER_SHOW_ENG_VIEW"
				+ " WHERE CID = ? AND CLUBMEM_ID = FN_ID_TO_CLUBMEMBER_ID(?, ?) AND POSITION_ID = '4'";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cid);		
		pstmt.setString(2, id);		
		pstmt.setString(3, cid);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result = rs.getInt("COUNT");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// ?????? ????????? ??????(???) ---city
    @Override
    public ArrayList<Region> regionLList() throws SQLException
    {
       ArrayList<Region> result = new ArrayList<Region>();
       
       Connection conn = dataSource.getConnection();
       
       String sql = "SELECT REGION_L_ID, CITY FROM REGION_L";

       PreparedStatement pstmt =  conn.prepareStatement(sql);
       ResultSet rs = pstmt.executeQuery();
       
       while(rs.next())
       {
          Region dto = new Region();
          
          dto.setRegion_l_id(rs.getString("REGION_L_ID"));
          dto.setCity(rs.getString("CITY"));
          
          result.add(dto);
       }
       
       rs.close();
       pstmt.close();
       conn.close();
       
       return result;
    }
    
	  // ???/??? 
	 @Override
	 public ArrayList<Region> regionSList(String region_l_id) throws SQLException
	 {
	     ArrayList<Region> result = new ArrayList<Region>();
	       
	       Connection conn = dataSource.getConnection();
	       
	       String sql = "SELECT REGION_S_ID,REGION_L_ID,LOCAL FROM REGION_S WHERE REGION_L_ID=?";
	
	       PreparedStatement pstmt =  conn.prepareStatement(sql);
	       pstmt.setString(1, region_l_id);
	       ResultSet rs = pstmt.executeQuery();
	
	       
	       while(rs.next())
	       {
	          Region dto = new Region();
	          
	          dto.setRegion_l_id(rs.getString("REGION_L_ID"));
	         dto.setRegion_s_id(rs.getString("REGION_S_ID"));
	         dto.setLocal(rs.getString("LOCAL")); 
	          
	          result.add(dto);
	       }
	       
	       rs.close();
	       pstmt.close();
	       conn.close();
	       
	       return result;
	
	 }
	
	 @Override
	 public ArrayList<Category> categoryLList() throws SQLException
	 {
	    ArrayList<Category> result = new ArrayList<Category>();
	       
	       Connection conn = dataSource.getConnection();
	       
	       String sql = "SELECT CATEGORY_L_ID,L_CAT FROM CATEGORY_L";
	
	       PreparedStatement pstmt =  conn.prepareStatement(sql);
	       ResultSet rs = pstmt.executeQuery();
	       
	       while(rs.next())
	       {
	          Category dto = new Category();
	          
	          dto.setCategory_l_id(rs.getString("CATEGORY_L_ID"));
	          dto.setL_cat(rs.getString("L_CAT"));
	        
	          
	          result.add(dto);
	       }
	       
	       rs.close();
	       pstmt.close();
	       conn.close();
	       
	       return result;
	
	 }
	
	 @Override
	 public ArrayList<Category> categorySList(String category_l_id) throws SQLException
	 {
	     ArrayList<Category> result = new ArrayList<Category>();
	       
	       Connection conn = dataSource.getConnection();
	       
	       String sql = "SELECT CATEGORY_L_ID, CATEGORY_S_ID, S_CAT"
	             + " FROM CATEGORY_S WHERE CATEGORY_L_ID = ?";
	
	       PreparedStatement pstmt =  conn.prepareStatement(sql);
	       pstmt.setString(1, category_l_id);
	       ResultSet rs = pstmt.executeQuery();
	       
	       while(rs.next())
	       {
	          Category dto = new Category();
	          
	          dto.setCategory_s_id(rs.getString("CATEGORY_S_ID"));
	          dto.setCategory_l_id(rs.getString("CATEGORY_L_ID"));
	          dto.setS_cat(rs.getString("S_CAT"));
	          
	          result.add(dto);
	       }
	       
	       rs.close();
	       pstmt.close();
	       conn.close();
	       
	       return result;
	
	 }
	 
		@Override
		// ?????? ?????? ????????? ?????????(ClubBeforeOpenedContents.jsp)??? ????????? ?????????
		// + ?????? ?????? ????????? ?????? ????????? ????????? ????????? 
		//cid ?????? 
		public Club showPreOpenClub(String cid) throws SQLException 
		{
			Club result = new Club();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT TITLE,CONTENT,NICKNAME,PREOPENDATE,MID,CID"
					+ ",CATEGORY_S_ID,CATEGORY_L_ID,REGION_S_ID,REGION_L_ID"
					+ ",L_CAT,S_CAT,CITY,LOCAL"
					+ ",MAX,LIMIT_ID,AGELIMIT_ID,MIN_AGE,MAX_AGE,DAY "
					+ "FROM CLUB_VIEW "
					+ "WHERE CID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				result.setTitle(rs.getString("TITLE"));
				result.setContent(rs.getString("CONTENT"));
				result.setNickname(rs.getString("NICKNAME"));
				result.setPreopendate(rs.getString("PREOPENDATE"));
				result.setMid(rs.getString("MID"));
				result.setCid(rs.getString("CID"));
				result.setCategory_s_id(rs.getString("CATEGORY_S_ID"));
				result.setCategory_l_id(rs.getString("CATEGORY_L_ID"));
				result.setRegion_s_id(rs.getString("REGION_S_ID"));
				result.setRegion_l_id(rs.getString("REGION_L_ID"));
				result.setL_cat(rs.getString("L_CAT"));
				result.setS_cat(rs.getString("S_CAT"));
				result.setCity(rs.getString("CITY"));
				result.setLocal(rs.getString("LOCAL"));
				result.setMax(Integer.parseInt(rs.getString("MAX")));
				result.setLimit_id(rs.getString("LIMIT_ID"));
				result.setAgelimit_id(rs.getString("AGELIMIT_ID"));
				result.setMin_age(Integer.parseInt(rs.getString("MIN_AGE")));
				result.setMax_age(Integer.parseInt(rs.getString("MAX_AGE")));
				result.setDay(Integer.parseInt(rs.getString("DAY")));

			}
			
			rs.close();
			pstmt.close();
			conn.close();
			return result;
		
		}
		
	    // ?????? ?????? ????????? ????????? (ClubBeforeOpenedList.jsp)   --??????
		//??? ????????? ????????? ?????? ????????????
		public ArrayList<Club> preopenList(PageObject pageObject,String searchKey
				,String searchValue,String orderKey) throws SQLException 
		{
			//1??? ????????? 1~10
			//2??? ????????? 11~20
			ArrayList<Club> result = new ArrayList<Club>();
			Connection conn = dataSource.getConnection();
			
			searchValue = "%" + searchValue + "%"; //??????
			
			String sql = "SELECT CID,TITLE,DAY,URL FROM "
					+ "(SELECT ROWNUM RNUM, CLUB.* FROM"
					+ "(SELECT * FROM CLUB_VIEW WHERE BDATE IS NULL " + searchKey
					+ " AND TITLE LIKE ? ORDER BY "+ orderKey + ") CLUB)"
					+ " WHERE RNUM >=?  AND RNUM <=?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setLong(2, pageObject.getStartRow());
			pstmt.setLong(3, pageObject.getEndRow());
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				Club dto = new Club();
				      
			    dto.setTitle(rs.getString("TITLE"));
			    dto.setCid(rs.getString("CID"));
			    dto.setDay(Integer.parseInt(rs.getString("DAY")));
			    dto.setUrl(rs.getString("URL"));
			    

			    result.add(dto);
			}
		      rs.close();
		      pstmt.close();
		      conn.close();
		      
		      return result;
		   }
		
		   //??? ?????? ?????? ????????? ??????( DB ???????????? ????????? ???????????? ????????? ??????)
		   // ?????? ?????? ???????????? ???????????? ??? ????????? 
		  public int preCount(String searchKey,String searchValue) throws SQLException 
		  {
			int result = 0;
			Connection conn = dataSource.getConnection();
			
			searchValue = "%" + searchValue + "%"; //??????
			
			String sql = "SELECT COUNT(*) AS COUNT"
					+ " FROM CLUB_VIEW"
					+ " WHERE BDATE IS NULL " + searchKey
					+ " AND TITLE LIKE ?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
				result = rs.getInt("COUNT");
		      rs.close();
		      pstmt.close();
		      conn.close();
		      
		      return result;
		   } 
		  
		 
		
		// ????????? insert ????????? 
		@Override
		public int insert(Club club) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			
			String sql = "{ call PRC_CLUB_INSERT(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(sql);
			cstmt.setString(1, club.getTitle());
			cstmt.setString(2, club.getId());
			cstmt.setInt(3, club.getMax());
			cstmt.setString(4, club.getContent());
			cstmt.setString(5, club.getCategory_s_id());
			cstmt.setString(6, club.getRegion_s_id());
			cstmt.setString(7, club.getUrl());
			cstmt.setString(8, club.getLimit_id());
			cstmt.setString(9, club.getAgelimit_id());
			
		
			result = cstmt.executeUpdate();
		      
		    cstmt.close();
		    conn.close();
		      
		    return result;
		}
		
		// ????????? modify ?????????

		@Override
		public int modify(Club club) throws SQLException
		{
			int result = 0;

			Connection conn = dataSource.getConnection();

			String sql = "UPDATE CLUB SET TITLE=?" + ", MAX=?, CONTENT=?, CATEGORY_S_ID=?, REGION_S_ID=?, URL=?"
					+ ", LIMIT_ID=?, AGELIMIT_ID=?" + " WHERE CID=?";

			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, club.getTitle());
			pstmt.setInt(2, club.getMax());
			pstmt.setString(3, club.getContent());
			pstmt.setString(4, club.getCategory_s_id());
			pstmt.setString(5, club.getRegion_s_id());
			pstmt.setString(6, club.getUrl());
			pstmt.setString(7, club.getLimit_id());
			pstmt.setString(8, club.getAgelimit_id());
			pstmt.setString(9, club.getCid());

			result = pstmt.executeUpdate();

			pstmt.close();
			conn.close();

			return result;
		}
		
		//????????? delete ?????????
		//???????????????????????? ???????????? ????????? ??? ?????? ?????????
		public int clubDelete(String cid) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM CLUB WHERE CID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
	    
	    //????????? ?????? ????????????
		@Override
		public int checkTitle(String title) throws SQLException
		{
			int result = 0;

			Connection conn = dataSource.getConnection();

			String sql = "SELECT * FROM CLUB_VIEW WHERE TITLE = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next() || title.equals(""))
				result = 0;
			else
				result = 1;

			rs.close();
			pstmt.close();
			conn.close();

			return result;
		}
		
		//??????(session)??? id??? ?????? MID??? ???????????? ????????? 
		// MEMBERINFO??? ID(session)??? MID ?????? ????????? 
		public String searchMid(String id) throws SQLException
		{
			String result="";
			Connection conn = dataSource.getConnection();

			String sql = "SELECT MID FROM MEMBERINFO WHERE ID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
				result = rs.getString("MID");
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		//????????? ???????????? ???????????? 
		//?????? ??????????????? ????????????????????? ??????
		//?????? ?????? ????????? ?????????,?????? ???????????? ?????? 
		public String searchJoin(String mid,String cid) throws SQLException
		{
			String result = "";
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT POSITION_ID FROM JOIN_CLUB WHERE CID = ? AND MID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.setString(2, mid);
		
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) //????????? ?????? ??????
				result = rs.getString("POSITION_ID");
			else //?????? ?????? ?????? ?????????
				result = "-1";
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		//????????? ???????????? ????????? (insert)
		public int joinClub(String cid,String mid,String position_id) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			String sql = "INSERT INTO JOIN_CLUB(JOIN_ID, CID, MID, BDATE,POSITION_ID) " + 
					"VALUES('JC'||JOIN_CLUBSEQ.NEXTVAL,?,?,SYSDATE,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.setString(2, mid);
			pstmt.setString(3, position_id);
			
			result=pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		//????????? ???????????? ????????? (insert)
		public int joinClub(String cid,String id) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			String sql = "INSERT INTO JOIN_CLUB(JOIN_ID, CID, MID, BDATE,POSITION_ID) VALUES('JC'||JOIN_CLUBSEQ.NEXTVAL, ? , (SELECT MID FROM MEMBERINFO WHERE ID = ?), SYSDATE, '1')";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.setString(2, id);
			
			result=pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		@Override
		public ArrayList<MemberInfo> joinClubmemList(String cid) throws SQLException
		{
			ArrayList<MemberInfo> result = new ArrayList<MemberInfo>();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT G.ID AS ID, (SELECT NICKNAME FROM MEMBERINFO WHERE ID = G.ID) AS NICKNAME, JOIN_ID AS JOINID"
					+ " FROM GETJOINCLUBVIEW2 G WHERE CID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberInfo m = new MemberInfo();
				
				m.setId(rs.getString("ID"));
				m.setNickname(rs.getString("NICKNAME"));
				m.setJoinId(rs.getString("JOINID"));
				
				result.add(m);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}

		//???????????? ????????? ?????????, ?????? ???????????? ??????
		public int joinClubDelete(String cid, String mid) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM JOIN_CLUB WHERE CID = ? AND MID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.setString(2, mid);
			
			result=pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		//???????????? ????????? ?????????, ?????? ???????????? ??????
		public int joinClubDelete2(String cid, String id) throws SQLException
		{
			int result = 0;
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM JOIN_CLUB WHERE CID = ? AND MID = (SELECT MID FROM MEMBERINFO WHERE ID = ?) AND JOIN_ID NOT IN (SELECT JOIN_ID FROM JOIN_CLUB_RETURN)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.setString(2, id);
			
			result=pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
		
		//???????????? ???????????? ?????? ???????????? 
		public ArrayList<MemberInfo> applyManagerList(String cid) throws SQLException
		{
			ArrayList<MemberInfo> result = new ArrayList<MemberInfo>();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT NICKNAME, URL, M.MID AS MID, M.ID AS ID "
					+ "FROM JOIN_CLUB J LEFT JOIN MEMBERINFO_VIEW2 M "
					+ "ON J.MID = M.MID WHERE POSITION_ID=2 "
					+ "AND CID=? ORDER BY BDATE";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberInfo m = new MemberInfo();
				
				m.setNickname(rs.getString("NICKNAME"));
				m.setUrl(rs.getString("URL"));
				m.setMid(rs.getString("MID"));
				m.setId(rs.getString("ID"));
				
				result.add(m);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		//???????????? ???????????? ????????? ???????????? 
		public ArrayList<MemberInfo> applyStaffList(String cid) throws SQLException
		{
			ArrayList<MemberInfo> result = new ArrayList<MemberInfo>();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT NICKNAME, URL, M.MID AS MID, M.ID AS ID "
					+ "FROM JOIN_CLUB J LEFT JOIN MEMBERINFO_VIEW2 M "
					+ "ON J.MID = M.MID WHERE POSITION_ID=3 "
					+ "AND CID=? ORDER BY BDATE";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberInfo m = new MemberInfo();
				
				m.setNickname(rs.getString("NICKNAME"));
				m.setUrl(rs.getString("URL"));
				m.setMid(rs.getString("MID"));
				m.setId(rs.getString("ID"));
				
				result.add(m);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		//?????? ????????? ???????????? ????????? ?????????
		//????????? ?????? ??????
		public MemberInfo memberProfile(String mid) throws SQLException 
		{
			MemberInfo result = new MemberInfo();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT URL,NICKNAME, AGE,"
					+ " REGIONNAME, REGIONNAME2, REGIONNAME3 "
					+ "FROM MEMBERINFO_VIEW2 WHERE MID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				result.setUrl(rs.getString("URL"));
				result.setNickname(rs.getString("NICKNAME"));
				result.setAge(rs.getInt("AGE"));
				result.setRegionName(rs.getString("REGIONNAME"));
				result.setRegionName2(rs.getString("REGIONNAME2"));
				result.setRegionName3(rs.getString("REGIONNAME3"));
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			return result;
		
		}
		//?????? ????????? ???????????? ????????? ?????????2
		//????????? ????????? ?????????(?????? ????????? ????????????) 
		//++ ????????? ??????????????? ?????????????????? ?????????????????? ??????????????????
		public ArrayList<Club> memberClubList(String mid) throws SQLException
		{
			ArrayList<Club> result = new ArrayList<Club>();
			Connection conn = dataSource.getConnection();
			String sql = "SELECT S_CAT,TITLE, CID "
					+ "FROM CLUB_VIEW WHERE BDATE IS NOT NULL AND MID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				Club dto = new Club();
				
				dto.setS_cat(rs.getString("S_CAT"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setCid(rs.getString("CID"));
				
				result.add(dto);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			return result;
		}
	
		
		//?????????, ?????? ?????? insert ?????????
	      public int choiceMember(String cid,String mid) throws SQLException
	      {
	         int result = 0;
	         Connection conn = dataSource.getConnection();
	         
	         String sql = "{ call PRC_CLUBMEM_INSERT(?,?)}";
	         CallableStatement cstmt = conn.prepareCall(sql);
	         cstmt.setString(1, cid);
	         cstmt.setString(2, mid);
	         
	         result = cstmt.executeUpdate();
	            
	          cstmt.close();
	          conn.close();
	            
	         return result;
	      }
	      
	      //???????????? ??? ?????? ?????????
	      //???????????? ?????????- ????????? ?????????????????? 
	      //???????????? ????????? ???????????? ?????? ?????? 
	      //????????? ?????? ???????????? ????????? 
	      public int staffCnt(String cid) throws SQLException
	      {
	         int result = 0;
	         Connection conn = dataSource.getConnection();
	         
	         String sql = "SELECT COUNT(*) AS COUNT "
	               + "FROM CLUBMEMBERLIST C LEFT JOIN JOIN_CLUB J "
	               + "ON C.JOIN_ID = J.JOIN_ID "
	               + "WHERE CID=? AND C.POSITION_ID=3";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cid);
	      
	         ResultSet rs = pstmt.executeQuery();
	         
	         if(rs.next()) //????????? ?????? ??????
	            result = rs.getInt("COUNT");
	         
	         rs.close();
	         pstmt.close();
	         conn.close();
	         
	         return result;
	      }
	      
	      //?????? ?????? ???????????? ????????? 
	      public int managerCnt(String cid) throws SQLException
	      {
	         int result = 0;
	         Connection conn = dataSource.getConnection();
	         
	         String sql = "SELECT COUNT(*) AS COUNT "
	               + "FROM CLUBMEMBERLIST C LEFT JOIN JOIN_CLUB J "
	               + "ON C.JOIN_ID = J.JOIN_ID "
	               + "WHERE CID=? AND C.POSITION_ID=2";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cid);
	      
	         ResultSet rs = pstmt.executeQuery();
	         
	         if(rs.next()) //????????? ?????? ??????
	            result = rs.getInt("COUNT");
	         
	         rs.close();
	         pstmt.close();
	         conn.close();
	         
	         return result;
	      }
	      
	      // ?????? ???????????? ??????
	      public int clubOpen(String cid) throws SQLException
	      {
	         int result = 0;
	         Connection conn = dataSource.getConnection();
	         
	         String sql = "UPDATE CLUB SET BDATE = SYSDATE WHERE CID = ?";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cid);
	         
	         result = pstmt.executeUpdate();
	         
	         pstmt.close();
	         conn.close();
	         
	         return result;
	      }

}




