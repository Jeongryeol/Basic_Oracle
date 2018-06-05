SELECT 
        cdate as "날짜"
       ,TO_CHAR(amt,'999,999') as "달러금액"
       ,TO_CHAR(crate, '99,999') as " 환율 "
       ,TO_CHAR(LAG(crate,1) OVER(ORDER BY cdate),'99,999') as " D-1 "
       ,TO_CHAR(LAG(crate,2) OVER(ORDER BY cdate),'99,999') as " D-2 "
       ,TO_CHAR(LAG(crate,3) OVER(ORDER BY cdate),'99,999') as " D-3 "
       ,TO_CHAR(LAG(crate,4) OVER(ORDER BY cdate),'99,999') as " D-4 "
       ,TO_CHAR(LAG(crate,5) OVER(ORDER BY cdate),'99,999') as " D-5 "
  FROM test02
        
        
  
LAG함수가 없을 때, 결과를 나열하는 방법

--a
SELECT rownum rno, cdate,crate FROM test02

--b
SELECT rownum num, cdate,crate FROM test02

--복제본 간의 내용으로 조회하기
SELECT a.rno,a.cdate as "날짜",MIN(a.crate) as "환율"   
     ,(MAX(DECODE(rno-num,0,b.crate))) 환율1
     ,(MAX(DECODE(rno-num,1,b.crate))) 환율2
     ,(MAX(DECODE(rno-num,2,b.crate))) 환율3
     ,(MAX(DECODE(rno-num,3,b.crate))) 환율4
     ,(MAX(DECODE(rno-num,4,b.crate))) 환율5
     ,(MAX(DECODE(rno-num,5,b.crate))) 환율6 
                   FROM 
                    (SELECT rownum rno, cdate,crate FROM test02)a 
                   ,(SELECT rownum num, cdate,crate FROM test02)b  
                 WHERE a.cdate >= b.cdate
                 GROUP BY a.rno,a.cdate
                 ORDER BY a.cdate
