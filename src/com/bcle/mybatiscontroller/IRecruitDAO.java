package com.bcle.mybatiscontroller;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bcle.DTO.Club;
import com.bcle.DTO.MemberEval;
import com.bcle.DTO.MemberInfo;
import com.bcle.DTO.Recruit;
import com.bcle.DTO.Volunteer;

public interface IRecruitDAO
{
   //모집 리스트 출력 메소드 (페이징 처리 시 변경필요)
   //public ArrayList<Recruit> list(String cid);
   public ArrayList<Recruit> list(Recruit r);
   
   public ArrayList<Recruit> lists(@Param("cid") String cid, @Param("start") int start
         , @Param("end") int end, @Param("sortOrder") String sortOrder);
   
   //게시글 갯수
   public int listCount(@Param("cid") String cid,@Param("sortOrder") String sortOrder);
   
   //직위 체크 메소드
   public String positionCheck(@Param("id") String id,@Param("cid") String cid);
   
   //CLUBMEM_ID 확인 메소드
   public String searchClubmemId(@Param("id") String id,@Param("cid") String cid);
   
   //모집글 등록 메소드
   public int add(Recruit r);
   
   //아티클 메소드
   public Recruit showRecruit(Recruit r);
   
   //조회수 증가
   public int updateCnt(Recruit r);
   
   //모집 수정
   public int modify(Recruit r);
   
   //모집 삭제
   public int delete(Recruit r);
   
   //모집 신청자 리스트
   public ArrayList<Volunteer> volunteerList(Recruit r);
   
   //모집 신청하기 insert 
   public int apply(Volunteer v);
   
   //모집 신청 취소 delete
   public int cancle(Volunteer v);
   
   //모집 신청 CHECK
   public int applyCheck(@Param("b_id") String b_id,@Param("id") String id);
   
   //운영진 투표발의 CHECK
   public int motionVoteCheck(Recruit r);
   
   //운영진 투표발의 insert 
   public int motionVoteInsert(Recruit r);
   
   //신청자 운영진 투표 insert
   public int exeVote(@Param("motion_id") String motion_id,@Param("volunteer_id") String volunteer_id,
                  @Param("clubmem_id") String clubmem_id);
   
   //운영진이 투표 했는지 안 했는지 체크 
   public int exeVoteCheck(@Param("clubmem_id") String clubmem_id, @Param("motion_id") String motion_id);
   
   //자신이 투표한 회원 volunteer_id
   public String exeVoteVolunteerId(@Param("clubmem_id") String clubmem_id, @Param("motion_id") String motion_id);
   
   //자신이 투표한 회원 닉네임 
   public String exeVoteVolunteer(@Param("volunteer_id") String volunteer_id);
   
   //운영진 투표 취소 
   public int exeVoteCancle(@Param("clubmem_id") String clubmem_id, @Param("motion_id") String motion_id);
   
   //선정된 신청자 (투표자 있는경우)
   public Volunteer selectWinner(@Param("motion_id") String motion_id);
   
   //선정된 신청자 (투표자 없는 경우)
   public Volunteer selectWinner2(@Param("b_id") String b_id);
   
   //프로필 기본정보
   public MemberInfo profileInfo(@Param("id") String id);
   
   //프로필 동아리 개설 정보
   public ArrayList<Club> profileClub(@Param("id") String id);
   
   //프로필 평가정보 
   public ArrayList<MemberEval> profileEval(@Param("id") String id);
   
   //선정자 직위 변경
   public int positionUpdate(@Param("clubmem_id") String clubmem_id, @Param("position_id") String position_id);
}