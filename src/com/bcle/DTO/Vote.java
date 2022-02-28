package com.bcle.DTO;

public class Vote
{
   private String bid, title, nickname, suspect, bdate,cdate, type, content,percent,voter,name;
   private String ddate;
   private int num;
   
   public int getNum()
   {
      return num;
   }
   public void setNum(int num)
   {
      this.num = num;
   }
   public String getName()
   {
      return name;
   }
   public void setName(String name)
   {
      this.name = name;
   }
   public String getDdate()
   {
      return ddate;
   }
   public void setDdate(String ddate)
   {
      this.ddate = ddate;
   }
   public String getCdate()
   {
      return cdate;
   }
   public void setCdate(String cdate)
   {
      this.cdate = cdate;
   }
   public String getPercent()
   {
      return percent;
   }
   public String getVoter()
   {
      return voter;
   }
   public void setVoter(String voter)
   {
      this.voter = voter;
   }
   public void setPercent(String percent)
   {
      this.percent = percent;
   }
   public String getContent()
   {
      return content;
   }
   public void setContent(String content)
   {
      this.content = content;
   }
   public String getType()
   {
      return type;
   }
   public void setType(String type)
   {
      this.type = type;
   }
   private int cnt;
   
   public String getBdate()
   {
      return bdate;
   }
   public void setBdate(String bdate)
   {
      this.bdate = bdate;
   }
   public String getBid()
   {
      return bid;
   }
   public void setBid(String bid)
   {
      this.bid = bid;
   }
   public String getTitle()
   {
      return title;
   }
   public void setTitle(String title)
   {
      this.title = title;
   }
   public String getNickname()
   {
      return nickname;
   }
   public void setNickname(String nickname)
   {
      this.nickname = nickname;
   }
   public String getSuspect()
   {
      return suspect;
   }
   public void setSuspect(String suspect)
   {
      this.suspect = suspect;
   }
   public int getCnt()
   {
      return cnt;
   }
   public void setCnt(int cnt)
   {
      this.cnt = cnt;
   }
}