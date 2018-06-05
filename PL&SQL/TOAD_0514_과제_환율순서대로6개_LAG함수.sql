test02 테이블의 자료를 이용해 해당일자보다 적거나 같은날의 환율을
순서대로 6개까지 보여주는 쿼리문을 작성해 보세요.

요구사항
LAG함수를 사용하지 말고 처리해 보세요.
--https://m.blog.naver.com/PostView.nhn?blogId=acatholic&logNo=90148808397&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F

CDATE : 년월일 날짜 9월1일 ~9월 11일
AMT : 일자별 환전 금액
CRATE : 당일 마감 환률 

EDIT test02

SELECT
       SUM(rf1.cdate) as "대상일자"
      ,rf2.cdate as "비교일자"
      ,rf1.crate as "마감환율"
  FROM TEST02 rf1, TEST02 rf2
 WHERE rf1.cdate >= rf2.cdate
   AND rf1.cdate - rf2.cdate <= 6
 GROUP BY rf1.cdate, rf2.cdate, rf1.crate
 ORDER By rf1.cdate