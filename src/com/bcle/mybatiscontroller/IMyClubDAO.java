package com.bcle.mybatiscontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bcle.DTO.Bee;
import com.bcle.DTO.Category;
import com.bcle.DTO.Club;
import com.bcle.DTO.MemberInfo;
import com.bcle.DTO.Region;
import com.webjjang.util.PageObject;

public interface IMyClubDAO
{
	// 활동중인 동아리
	public ArrayList<Club> myClubActive(String id) throws SQLException;
	
	// 종료된 동아리
	public ArrayList<Club> myClubClosed(String id) throws SQLException;
	
	// 가입 신청 동아리
	public ArrayList<Club> getClubJoin(String id) throws SQLException;
	
	// 개설 예정 동아리
	public ArrayList<Club> getClubPreOpen(String id) throws SQLException;
	
	// 활동중 동아리 캘린더
	public ArrayList<Bee> getMyPageCal(@Param("cid") String cid,@Param("year") String year,@Param("month") String month,@Param("id") String id) throws SQLException;
	
	public ArrayList<Bee> getMyPageTotalCal(@Param("year") String year,@Param("month") String month,@Param("id") String id) throws SQLException;
	
	// 활동 종료 동아리 캘린더
	public ArrayList<Bee> getMyPageCalClosed(@Param("cid") String cid,@Param("year") String year,@Param("month") String month,@Param("id") String id) throws SQLException;
	
	public ArrayList<Bee> getMyPageTotalCalClosed(@Param("year") String year,@Param("month") String month,@Param("id") String id) throws SQLException;
}
