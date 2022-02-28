package com.bcle.DTO;

public class Recruit
{
	// 주요 속성 구성
	private String b_id, clubmem_id, title, content, position_id, bdate;
	private int cnt;
	private String nickname, positionname;
	private String cid, id;
	private String rnum;
	private int day; // --모집 마감일까지의 d-day
	private String motion_id, motiondate; // 투표발의 코드,발의일
	private String votedday;// 투표마감일 추가
	private int volunteer_count, vote_count; // 신청자 수 , 투표 수 추가

	public String getVotedday()
	{
		return votedday;
	}

	public void setVotedday(String votedday)
	{
		this.votedday = votedday;
	}

	public int getVolunteer_count()
	{
		return volunteer_count;
	}

	public void setVolunteer_count(int volunteer_count)
	{
		this.volunteer_count = volunteer_count;
	}

	public int getVote_count()
	{
		return vote_count;
	}

	public void setVote_count(int vote_count)
	{
		this.vote_count = vote_count;
	}

	public String getMotiondate()
	{
		return motiondate;
	}

	public void setMotiondate(String motiondate)
	{
		this.motiondate = motiondate;
	}

	public String getMotion_id()
	{
		return motion_id;
	}

	public void setMotion_id(String motion_id)
	{
		this.motion_id = motion_id;
	}

	public int getDay()
	{
		return day;
	}

	public void setDay(int day)
	{
		this.day = day;
	}

	public String getRnum()
	{
		return rnum;
	}

	public void setRnum(String rnum)
	{
		this.rnum = rnum;
	}

	public String getB_id()
	{
		return b_id;
	}

	public void setB_id(String b_id)
	{
		this.b_id = b_id;
	}

	public String getClubmem_id()
	{
		return clubmem_id;
	}

	public void setClubmem_id(String clubmem_id)
	{
		this.clubmem_id = clubmem_id;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public String getPosition_id()
	{
		return position_id;
	}

	public void setPosition_id(String position_id)
	{
		this.position_id = position_id;
	}

	public String getBdate()
	{
		return bdate;
	}

	public void setBdate(String bdate)
	{
		this.bdate = bdate;
	}

	public int getCnt()
	{
		return cnt;
	}

	public void setCnt(int cnt)
	{
		this.cnt = cnt;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getPositionname()
	{
		return positionname;
	}

	public void setPositionname(String positionname)
	{
		this.positionname = positionname;
	}

	public String getCid()
	{
		return cid;
	}

	public void setCid(String cid)
	{
		this.cid = cid;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

}