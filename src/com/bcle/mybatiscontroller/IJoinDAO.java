package com.bcle.mybatiscontroller;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Param;

public interface IJoinDAO
{
	public int clubmemInsert(@Param("joinId") String joinId) throws SQLException;
	public int joinClubReturnInsert(@Param("joinId") String joinId) throws SQLException;
	
	// 동아리 최대 회원 수 구하기
	public int cntMaxClubMem(@Param("cid") String cid) throws SQLException;
	
	// 동아리 회원 수 구하기
	public int cntClubMem(@Param("cid") String cid) throws SQLException;
}

