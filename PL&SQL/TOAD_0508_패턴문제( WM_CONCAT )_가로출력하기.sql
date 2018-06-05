--------------------------------------------------------------------------------                                 

패턴문제

SELECT name_vc, MIN(quantity_nu)||','||MAX(quantity_nu) as "value"
  FROM t_giftorder WHERE MOD(num_nu,2)=1 GROUP BY name_vc
UNION all
SELECT name_vc, MIN(quantity_nu)||','||MAX(quantity_nu) as "value"
  FROM t_giftorder WHERE MOD(num_nu,2)=0 GROUP BY name_vc

--------------------------------------------------------------------------------

select NAME_VC,WM_CONCAT(QUANTITY_NU)as "VALUE"
  from T_GIFTORDER
  group by NAME_VC

Oracle 10g에서는 문자정렬이 가능하지않음
http://denodo1.tistory.com/266


--[문제풀이]----------------------------------------------------------------------

SELECT * FROM t_giftorder

--기존에 있는 테이블 구조를 변경시도
--순서가 정해져 있도록 붙여서 출력하고
--수량을 참조 하기 위해 수량1과 수량2를 두고 정렬한다.
SELECT name_vc, quantity_nu q1, quantity_nu q2 FROM t_giftorder
 ORDER BY name_vc --건담끼리 마크로스끼리 모아서 정리함

--위 SQL문을 인라인뷰로 두고 밖(출력을 하는,주쿼리)에서 rownum을 정한 뒤에 2로 나누어서 값이 0과 1이 출력되도록
DECODE()
MOD(rownum,2),0일때 q1을 출력할지,  1일때 q2를 출력할지...
DECODE사이에서 ||','||

SELECT
    name_vc
   ,DECODE ( MOD(rownum,2),1,q1 )--
   ,DECODE ( MOD(rownum,2),0,q2 )
   ,DECODE ( MOD(rownum,2),1,q1 )||','||DECODE ( MOD(rownum,2),0,q2 )
   --rownum으로 row에 번호를 부여하고, 그 번호를 MOD하여 DECODE로 결과를 구분함 
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--인라인뷰
  
--같은 것들을 하나로 정리하기 : GROUP BY
--그러나, 그룹함수와 함께 일반함수를 사용할 수 없기때문에, DECODE로 인해 문법에러발생
SELECT
    name_vc
   ,DECODE ( MOD(rownum,2),1,q1 )||','||DECODE ( MOD(rownum,2),0,q2 )
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--인라인뷰
 GROUP BY name_vc
 
--어차피 값이 들어있고, 다시 NULL인 것만 반복되는 DECODE 조건식의 결과를 반영하여 집합함수 MIN()을 적용해도 무방하다.
--이때, 짝수와 홀수 순서가 맞았기 때문에 적용가능했던 것임.
SELECT
    name_vc
   ,MIN ( DECODE ( MOD(rownum,2),1,q1 ) )||','||MIN ( DECODE ( MOD(rownum,2),0,q2 ) ) as "VALUE"
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--인라인뷰
 GROUP BY name_vc
 
 select * from tdept
 select * from temp
 
 select  from tdept b inner join temp a on b.DEPT_CODE = a.DEPT_CODE