package com.bcle.DTO;

import java.util.ArrayList;

public class Summary
{
   private int beeCnt, totClubCnt, newbieCnt, newClubCnt;
         //정모수 //전체동아리수, 새로운가입자수, 당일새로운동아리수
   private int perTimeMemCnt1,perTimeMemCnt2,perTimeMemCnt3,perTimeMemCnt4,perTimeMemCnt5,perTimeMemCnt6;
             //누적 시간별 회원수
   
   private int p_TimerMemCnt1 ,p_TimerMemCnt2 ,p_TimerMemCnt3 ,p_TimerMemCnt4 ,p_TimerMemCnt5 ,p_TimerMemCnt6;
            //월 별 회원 수
   
   private int cateNewBie;
            
   private int perCateMemCnt1,perCateMemCnt2,perCateMemCnt3,perCateMemCnt4,perCateMemCnt5, perCateMemCnt6;
   // 카테고리별 
   // 카테고리별 만남Top5
   
   private int cnt;
   private String city;


   public int getCnt()
   {
      return cnt;
   }

   public void setCnt(int cnt)
   {
      this.cnt = cnt;
   }

   public String getCity()
   {
      return city;
   }

   public void setCity(String city)
   {
      this.city = city;
   }

   public int getPerCateMemCnt1()
   {
      return perCateMemCnt1;
   }

   public void setPerCateMemCnt1(int perCateMemCnt1)
   {
      this.perCateMemCnt1 = perCateMemCnt1;
   }

   public int getPerCateMemCnt2()
   {
      return perCateMemCnt2;
   }

   public void setPerCateMemCnt2(int perCateMemCnt2)
   {
      this.perCateMemCnt2 = perCateMemCnt2;
   }

   public int getPerCateMemCnt3()
   {
      return perCateMemCnt3;
   }

   public void setPerCateMemCnt3(int perCateMemCnt3)
   {
      this.perCateMemCnt3 = perCateMemCnt3;
   }

   public int getPerCateMemCnt4()
   {
      return perCateMemCnt4;
   }

   public void setPerCateMemCnt4(int perCateMemCnt4)
   {
      this.perCateMemCnt4 = perCateMemCnt4;
   }

   public int getPerCateMemCnt5()
   {
      return perCateMemCnt5;
   }

   public void setPerCateMemCnt5(int perCateMemCnt5)
   {
      this.perCateMemCnt5 = perCateMemCnt5;
   }

   public int getPerCateMemCnt6()
   {
      return perCateMemCnt6;
   }

   public void setPerCateMemCnt6(int perCateMemCnt6)
   {
      this.perCateMemCnt6 = perCateMemCnt6;
   }

   public int getCateNewBie()
   {
      return cateNewBie;
   }

   public void setCateNewBie(int cateNewBie)
   {
      this.cateNewBie = cateNewBie;
   }

   public int getBeeCnt()
   {
      return beeCnt;
   }

   public int getP_TimerMemCnt1() {
      return p_TimerMemCnt1;
   }

   public void setP_TimerMemCnt1(int p_TimerMemCnt1) {
      this.p_TimerMemCnt1 = p_TimerMemCnt1;
   }

   public int getP_TimerMemCnt2() {
      return p_TimerMemCnt2;
   }

   public void setP_TimerMemCnt2(int p_TimerMemCnt2) {
      this.p_TimerMemCnt2 = p_TimerMemCnt2;
   }

   public int getP_TimerMemCnt3() {
      return p_TimerMemCnt3;
   }

   public void setP_TimerMemCnt3(int p_TimerMemCnt3) {
      this.p_TimerMemCnt3 = p_TimerMemCnt3;
   }

   public int getP_TimerMemCnt4() {
      return p_TimerMemCnt4;
   }

   public void setP_TimerMemCnt4(int p_TimerMemCnt4) {
      this.p_TimerMemCnt4 = p_TimerMemCnt4;
   }

   public int getP_TimerMemCnt5() {
      return p_TimerMemCnt5;
   }

   public void setP_TimerMemCnt5(int p_TimerMemCnt5) {
      this.p_TimerMemCnt5 = p_TimerMemCnt5;
   }

   public int getP_TimerMemCnt6() {
      return p_TimerMemCnt6;
   }

   public void setP_TimerMemCnt6(int p_TimerMemCnt6) {
      this.p_TimerMemCnt6 = p_TimerMemCnt6;
   }

   public int getPerTimeMemCnt1() {
      return perTimeMemCnt1;
   }

   public void setPerTimeMemCnt1(int perTimeMemCnt1) {
      this.perTimeMemCnt1 = perTimeMemCnt1;
   }

   public int getPerTimeMemCnt2() {
      return perTimeMemCnt2;
   }

   public void setPerTimeMemCnt2(int perTimeMemCnt2) {
      this.perTimeMemCnt2 = perTimeMemCnt2;
   }

   public int getPerTimeMemCnt3() {
      return perTimeMemCnt3;
   }

   public void setPerTimeMemCnt3(int perTimeMemCnt3) {
      this.perTimeMemCnt3 = perTimeMemCnt3;
   }

   public int getPerTimeMemCnt4() {
      return perTimeMemCnt4;
   }

   public void setPerTimeMemCnt4(int perTimeMemCnt4) {
      this.perTimeMemCnt4 = perTimeMemCnt4;
   }

   public int getPerTimeMemCnt5() {
      return perTimeMemCnt5;
   }

   public void setPerTimeMemCnt5(int perTimeMemCnt5) {
      this.perTimeMemCnt5 = perTimeMemCnt5;
   }

   public int getPerTimeMemCnt6() {
      return perTimeMemCnt6;
   }

   public void setPerTimeMemCnt6(int perTimeMemCnt6) {
      this.perTimeMemCnt6 = perTimeMemCnt6;
   }


   public void setBeeCnt(int beeCnt)
   {
      this.beeCnt = beeCnt;
   }

   public int getTotClubCnt()
   {
      return totClubCnt;
   }

   public void setTotClubCnt(int totClubCnt)
   {
      this.totClubCnt = totClubCnt;
   }

   public int getNewbieCnt()
   {
      return newbieCnt;
   }

   public void setNewbieCnt(int newbieCnt)
   {
      this.newbieCnt = newbieCnt;
   }

   public int getNewClubCnt()
   {
      return newClubCnt;
   }

   public void setNewClubCnt(int newClubCnt)
   {
      this.newClubCnt = newClubCnt;
   }
   
   
   
}