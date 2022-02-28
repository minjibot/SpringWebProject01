package com.bcle.DTO;

public class ClubSearch
{
   private String category_l_id, category_s_id,region_l_id,region_s_id,
         sortOrder, keyword;
   private int start, end,pageNum;
   
   
   public int getPageNum()
   {
      return pageNum;
   }
   public void setPageNum(int pageNum)
   {
      this.pageNum = pageNum;
   }
   public String getCategory_l_id()
   {
      return category_l_id;
   }
   public void setCategory_l_id(String category_l_id)
   {
      this.category_l_id = category_l_id;
   }
   public String getCategory_s_id()
   {
      return category_s_id;
   }
   public void setCategory_s_id(String category_s_id)
   {
      this.category_s_id = category_s_id;
   }
   public String getRegion_l_id()
   {
      return region_l_id;
   }
   public void setRegion_l_id(String region_l_id)
   {
      this.region_l_id = region_l_id;
   }
   public String getRegion_s_id()
   {
      return region_s_id;
   }
   public void setRegion_s_id(String region_s_id)
   {
      this.region_s_id = region_s_id;
   }
   public String getSortOrder()
   {
      return sortOrder;
   }
   public void setSortOrder(String sortOrder)
   {
      this.sortOrder = sortOrder;
   }
   public String getKeyword()
   {
      return keyword;
   }
   public void setKeyword(String keyword)
   {
      this.keyword = keyword;
   }
   public int getStart()
   {
      return start;
   }
   public void setStart(int start)
   {
      this.start = start;
   }
   public int getEnd()
   {
      return end;
   }
   public void setEnd(int end)
   {
      this.end = end;
   }
   
   
}