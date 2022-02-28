package com.bcle.mybatiscontroller;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bcle.DTO.Category;
import com.bcle.DTO.Club;
import com.bcle.DTO.ClubSearch;
import com.bcle.DTO.Region;

public interface IClubSearchDAO
{
	// 카테고리 대분류 이름
	public String cateLname(String category_l_id);

	// 카테고리 소분류 리스트
	public ArrayList<Category> cateS_List(String category_l_id);

	// 카테고리 대분류 리스트
	public ArrayList<Category> cateL_List();

	// 지역 시 리스트
	public ArrayList<Region> regionL_List();

	// 동아리 리스트
	public ArrayList<Club> clubList(ClubSearch search);

	// 동아리 갯수
	public int clubCount(ClubSearch search);

	// 개설예정 동아리 리스트
	public ArrayList<Club> preClubList(ClubSearch search);

	// 개설예정 동아리 갯수
	public int preClubCount(ClubSearch search);

	// 총무 수
	public int managerCnt(@Param("cid") String cid);

	// 스태프 수
	public int staffCnt(@Param("cid") String cid);

	public int delete(@Param("cid") String cid);

	public ArrayList<Club> clubSearchList(ClubSearch search);

	public int clubSearchCount(ClubSearch search);

}