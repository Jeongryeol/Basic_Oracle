우리가 만든 테이블에서 우리집 우편번호를 조회하는 SQL문을 작성하시오.

EDIT ZIPCODE_T

SELECT zipcode, address FROM ZIPCODE_T
 WHERE dong LIKE '%'||'가산'||'%'
 
SELECT zipcode, address FROM ZIPCODE_T
 WHERE dong LIKE '%'||'가산동'||'%'
 
SELECT zipcode, address FROM ZIPCODE_T
 WHERE ZDO LIKE '%'||'서울'||'%'
   AND dong LIKE '%'||'구의동'||'%'
   


대여일자 회원명 DVD제목

SELECT
       회원명, 대여.대여일자, 영화.제목, 연체.연체료
  FROM 대여(1000), 회원(300), DVD(20000), 영화(2000), 연체(105)
 WHERE 회원.회원번호 = 대여.회원번호
   AND DVD.영화코드 = 영화.영화코드
   AND 대여.회원번호 = 연체.회원번호
   AND 대여.DVD코드 = 연체.DVD코드


연습문제
4월 대여 순위를 1위부터 10위까지 출력하고자 한다.

출력결과
순위 영화제목 대여횟수 감독 주연배우

SELECT
       rownum ano as "순위"
      ,영화.영화제목
      ,COUNT (대여.대여일자) as "대여횟수"
      ,영화.감독이름
      ,영화.주연배우
  FROM 영화, DVD, 대여
 WHERE rownum <= 10
   AND 대여.대여일자 BETWEEN '20180401' AND '20180430' -- 구간조건
 ORDER BY COUNT(대여.대여일자) desc -- 대여가 많은 순서대로 정리해줌
 GROUP BY ano, 영화.영화이름, 영화.주연배우




JOIN이란,
한 테이블에서 원하는 결과를 모두 조회할 수 없어서
여러 테이블에 저장된 데이터를 한 번에 조회하는 경우를 말함
 
1) 카타시안의 곱 ( 묻지마 조인 ) :: ( 14 * 4 = 56 )

SELECT a.name, b,dname
  FROM emp a, dept b

2) equal 조인 -  NATURAL JOIN ( PK와 FK를 조인하여 사용하는 가장 일반적인 방법)
 
SELECT a.ename, b.name
  FROM emp a, dept b
 WHERE a.deptno = b.deptno

3) non-equal 조인


 
4) outer 조인
 


5) self  조인

