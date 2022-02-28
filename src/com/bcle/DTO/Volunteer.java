package com.bcle.DTO;

public class Volunteer
{
	private String volunteer_id, b_id, clubmem_id, bdate, nickname, id, url;
	private String cid; // --추가
	private String mid; // 추가

	public String getMid()
	{
		return mid;
	}

	public void setMid(String mid)
	{
		this.mid = mid;
	}

	public String getCid()
	{
		return cid;
	}

	public void setCid(String cid)
	{
		this.cid = cid;
	}

	public String getVolunteer_id()
	{
		return volunteer_id;
	}

	public void setVolunteer_id(String volunteer_id)
	{
		this.volunteer_id = volunteer_id;
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

	public String getBdate()
	{
		return bdate;
	}

	public void setBdate(String bdate)
	{
		this.bdate = bdate;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

}