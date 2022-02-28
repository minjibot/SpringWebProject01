/*================================
 * IMemberEvalDAO.java
 * - 인터페이스
================================*/


package com.bcle.DAO;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bcle.DTO.BeeEval;
import com.bcle.DTO.MemberEval;

public interface IMemberEvalDAO
{
	// 개인 평가 추가
	public int add(MemberEval dto) throws SQLException;
	
	// 특정 모임에서 동아리원이 평가한 사람의 REQ_ID를 알기 위함
	public ArrayList<String> getReqId(String beeId, String clubmemId) throws SQLException;
}
