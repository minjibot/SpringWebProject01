package com.bcle.mybatiscontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bcle.DTO.MemberInfo;

public interface IMyAdminDAO
{
	// [회원]
	// 검색 옵션 선택
	public ArrayList<MemberInfo> searchMemberList(@Param ("select") String select, @Param ("inputValue") String inputValue, @Param ("start") int start, @Param ("end") int end) throws SQLException;

	// 검색 옵션 미선택
	public ArrayList<MemberInfo> memberList(@Param ("start") int start, @Param ("end") int end) throws SQLException;
	//public ArrayList<MemberInfo> memberList() throws SQLException;
	
	// 회원 수
	public int countMember() throws SQLException;

	// 검색된 회원 수
	public int countSearchMember(@Param ("select") String select, @Param ("inputValue") String inputValue) throws SQLException;
	
	// [동아리]
	// 동아리 수
	public int countClub() throws SQLException;
	
	// 정렬된 동아리 리스트
	public ArrayList<MemberInfo> sortClubList(@Param ("sort") String sort, @Param ("start") int start, @Param ("end") int end) throws SQLException;
}
