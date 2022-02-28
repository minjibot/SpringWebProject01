package com.bcle.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.bcle.DTO.MemberEval;

public class MemberEvalDAO implements IMemberEvalDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	@Override
	public int add(MemberEval dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "INSERT INTO MEMBER_EVAL(MEM_EVAL_ID, BDATE, EVAL_ID, WRITER_ID, REQ_ID)"
				+ " VALUES (MEMBER_EVALSEQ.NEXTVAL, SYSDATE, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getEvalId());
		pstmt.setString(2, dto.getWriterId());
		pstmt.setString(3, dto.getReqId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public ArrayList<String> getReqId(String beeId, String clubmemId) throws SQLException
	{
		ArrayList<String> result = new ArrayList<String>();
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT DISTINCT MEMBER_EVAL.BDATE, MEMBER_EVAL.WRITER_ID, MEMBER_EVAL.REQ_ID"
				+ ", BEE_REQ.CLUBMEM_ID, BEE_REQ.BDATE, BEE_REQ.BEE_ID"
				+ " FROM MEMBER_EVAL LEFT JOIN BEE_REQ"
				+ " ON MEMBER_EVAL.WRITER_ID = BEE_REQ.REQ_ID"
				+ " WHERE BEE_REQ.BEE_ID = ? AND BEE_REQ.CLUBMEM_ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, beeId);
		pstmt.setString(2, clubmemId);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result.add(rs.getString("REQ_ID"));
		}
		
		return result;
	}

	
}
