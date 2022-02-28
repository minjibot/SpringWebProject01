package com.bcle.DTO;

public class MemberEval
{
	private String memEvalId, bdate, evalId, writerId, reqId;
	
	//추가
	private String content;// 평가내용
	private int count; // 각 항목 갯수 

	public String getMemEvalId()
	{
		return memEvalId;
	}

	public void setMemEvalId(String memEvalId)
	{
		this.memEvalId = memEvalId;
	}

	public String getBdate()
	{
		return bdate;
	}

	public void setBdate(String bdate)
	{
		this.bdate = bdate;
	}

	public String getEvalId()
	{
		return evalId;
	}

	public void setEvalId(String evalId)
	{
		this.evalId = evalId;
	}

	public String getWriterId()
	{
		return writerId;
	}

	public void setWriterId(String writerId)
	{
		this.writerId = writerId;
	}

	public String getReqId()
	{
		return reqId;
	}

	public void setReqId(String reqId)
	{
		this.reqId = reqId;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}
	
	
}
