package com.bcle.mybatiscontroller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bcle.DTO.Vote;

public interface IVoteDAO
{
   // 동아리장이 아닌 회원 list
   public ArrayList<Vote> suspectList(@Param("cid") String cid) throws SQLException;
   
   // 스태프, 총무인 회원 list
   public ArrayList<Vote> devoterlist(@Param("cid") String cid) throws SQLException;
   
   public int checkvotebutton(@Param("cid") String cid, @Param("id") String id) throws SQLException;
   
   // 스태프, 총무 회원
   //public ArrayList<Vote> desuspectList() throws SQLException;
   
   // 투표 등록
   public int insertSuspectList(@Param("id") String id, @Param("cid") String cid, @Param("type") String type, @Param("title") String title, @Param("realsuspect") String realsuspect, @Param("content") String content) throws SQLException;
   
   // 투표 등록(탈퇴)
   public int insertSuspectList2(@Param("id") String id, @Param("cid") String cid, @Param("type") String type, @Param("title") String title, @Param("content") String content) throws SQLException;
   
   // 투표 동아리 회원
   public Vote suspecterInformation(@Param("cid") String cid, @Param("bid") String bid) throws SQLException;
   public ArrayList<Vote> voterlist(@Param("bid") String bid) throws SQLException;
   
   // 라인 32~36 게시판 페이지 처리 DAO
   
   // 페이징을 위한 전체 데이터 수
   public int votetotaldata(@Param("cid") String cid) throws SQLException;
   
   // 페이징을 위한 각각의 게시물 ArrayList
   public ArrayList<Vote> votepagelist(@Param("cid") String cid, @Param("start") int start, @Param("end") int end) throws SQLException;
  
   // 투표게시판 코드(bId)로 동아리 코드 가져오는 메소드 
   public String getCid(@Param("bId") String bId) throws SQLException;
   
   // 강퇴회원목록(BAN_MEM_LIST) INSERT
   public int insertBanMemList(@Param("clubmem_id") String clubmem_id) throws SQLException;
   
   // 강등 - 동아리회원목록 직위 UPDATE
   public int updatePosition(@Param("clubmem_id") String clubmem_id) throws SQLException;
   
   // 동아리 폐쇄 - 동아리 상태(CLUBSTATUS) INSERT
   public int insertClubStatus(@Param("cid") String cid) throws SQLException;
   
   // nickname랑 CID로 CLUBMEM_ID 얻어오기
   public String getClubMem_id(@Param("nickname") String nickname, @Param("cid") String cid) throws SQLException;
   
   // ID랑 CID로 CLUBMEM_ID 얻어오기
   public String getClubMem_id2(@Param("id") String id, @Param("cid") String cid) throws SQLException;
   
   // 종료 동아리인지 확인
   public int checkClosedClub(@Param("cid") String cid) throws SQLException;
   
   // 강등된 회원인지 확인
   public int checkPosition(@Param("nickname") String nickname, @Param("cid") String cid) throws SQLException;
   
   // 강등된 회원인지 확인
   public int checkEliminated(@Param("nickname") String nickname, @Param("cid") String cid) throws SQLException;
   
   // 찬성반대 insert
   public int insertPac(@Param("id") String id, @Param("cid") String cid, @Param("bid") String bid, @Param("pacId") String pacId) throws SQLException;
   
   // 찬성반대 DELETE
   public int deletePac(@Param("bid") String bid, @Param("clubmem_id") String clubmem_id) throws SQLException;
   
   // 투표 여부
   public int checkVote(@Param("bid") String bid, @Param("clubmem_id") String clubmem_id) throws SQLException;
   
}