package com.bcle.mybatiscontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSessionException;

import com.bcle.DTO.Category;
import com.bcle.DTO.MemberInfo;
import com.bcle.DTO.Region;

public interface IMyInfoDAO
{
	// 내 정보 출력
	public MemberInfo showMyInfo(String id) throws SQLException;
	
	// 받은 평가 수
	public int countEval(@Param("id") String id, @Param("evalId") String evalId) throws SQLException;
	
	// 비밀번호 확인
	public int checkPwd(@Param("id") String id, @Param("pwd") String pwd) throws SQLException;

	public ArrayList<Region> regionLList() throws SQLException;
	public ArrayList<Region> regionSList(@Param("region_l_id") String region_l_id) throws SQLException;
	public ArrayList<Category> categoryLList() throws SQLException;
	public ArrayList<Category> categorySList(@Param("category_l_id")String category_l_id) throws SQLException;
	
	// 내 정보 수정
	public int updateMemberInfo(MemberInfo dto) throws SQLException;
	public int updateMember(MemberInfo dto) throws SQLException;
	public int deleteAddRegion(@Param("id") String id) throws SQLException;
	public int deleteAddCategory(@Param("id") String id) throws SQLException;
	public int insertAddRegion(@Param("id") String id, @Param("region_s_id") String region_s_id) throws SQLException;
	public int insertAddCategory(@Param("id") String id, @Param("category_S_Id") String category_s_id) throws SQLException;

}

