[ 총계 문제 2탄 ]

소계와 총계 1탄 문제에서는 어떤 물품이 얼만큼 판매 되었는지 알수가 없어서 판매된 물품에 대한 
주문을 할 수 없다.
따라서 오늘은 날짜별 판매금액과 총계가 아닌 물품에 대한 판매 현황 자료를 같이 볼 수 있도록 
물품구분별로 집계현황을 같이 볼 수 있도록 sql문을 작성하시오.

Edit t_orderbasket

SELECT
        indate_vc   as "판매일자"
       ,gubun_vc     as "물품명"
       ,qty_nu      as "판매수량"
       ,price_nu    as "단가"
       ,(qty_nu*price_nu) as "매출액"
  FROM T_ORDERBASKET
 ORDER BY indate_vc
 
 
SELECT
        oda.indate_vc   as "판매일자"
       ,oda.gubun_vc     as "구분명"
       ,oda.name_vc      as "물품명"
       ,SUM(oda.qty_nu) as "판매수량"
       ,odb.price_nu    as "단가"
       ,SUM(oda.qty_nu*odb.price_nu) as "매출액"
  FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
      ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
 WHERE  ano = bno
 GROUP BY oda.indate_vc, oda.gubun_vc, name_vc, odb.price_nu, oda.qty_nu 
 ORDER BY oda.indate_vc
 
SELECT
    판매일자, 구분명, 물품명, SUM(판매수량) as "총 판매수량", 단가, SUM(매출액) as "매출액"
  FROM(SELECT
        oda.indate_vc   as "판매일자"
       ,oda.gubun_vc     as "구분명"
       ,oda.name_vc      as "물품명"
       ,SUM(oda.qty_nu) as "판매수량"
       ,odb.price_nu    as "단가"
       ,SUM(oda.qty_nu*odb.price_nu) as "매출액"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
      WHERE  ano = bno
     GROUP BY oda.indate_vc, oda.gubun_vc, oda.name_vc, odb.price_nu, oda.qty_nu 
     ORDER BY oda.indate_vc)
 GROUP BY 판매일자, 구분명, 물품명, 단가 
 ORDER BY 판매일자     

--날짜별 및 물품별 판매소계 및 물품별 소계 작성
SELECT
    판매일자, 구분명, SUM(판매수량) as "총 판매수량", 단가, SUM(매출액) as "매출액"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'소계')   as "판매일자"
       ,oda.gubun_vc     as "구분명"
       ,oda.name_vc      as "물품명"
       ,SUM(oda.qty_nu) as "판매수량"
       ,oda.price_nu    as "단가"
       ,SUM(oda.qty_nu*oda.price_nu) as "매출액"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'), oda.gubun_vc, oda.name_vc, oda.price_nu, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'))
 GROUP BY 판매일자, 구분명, 물품명, 단가 
 ORDER BY 판매일자

--전체합계 조회
SELECT
      DECODE(dno,1,'전체합계') as "판매일자"
     ,null as "물품명"
     ,SUM(qty_nu) as "총 판매수량"
     ,null as "단가"
     ,SUM(qty_nu*price_nu) as "매출액"
  FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'전체합계')
 
 
--union
SELECT
    판매일자, 물품명, SUM(판매수량) as "총 판매수량", 단가, SUM(매출액) as "매출액"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'소계')   as "판매일자"
       ,oda.name_vc     as "물품명"
       ,SUM(oda.qty_nu) as "판매수량"
       ,odb.price_nu    as "단가"
       ,SUM(oda.qty_nu*odb.price_nu) as "매출액"
       FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
      WHERE  ano = bno
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'), oda.name_vc, odb.price_nu, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'))
 GROUP BY 판매일자, 물품명, 단가 
union
SELECT
      DECODE(dno,1,'전체합계') as "판매일자"
     ,null as "물품명"
     ,SUM(qty_nu) as "총 판매수량"
     ,null as "단가"
     ,SUM(qty_nu*price_nu) as "매출액"
  FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'전체합계')
ORDER BY 판매일자 
 
 
--구분으로만 모두 묶어서 낸 새로운 답안
SELECT
    판매일자, 구분명, SUM(판매수량) as "총 판매수량", SUM(매출액) as "매출액"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'소계')   as "판매일자"
       ,oda.gubun_vc     as "구분명"
       ,SUM(oda.qty_nu) as "판매수량"
       ,SUM(oda.qty_nu*oda.price_nu) as "매출액"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, qty_nu,price_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'), oda.gubun_vc, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'소계'))
 GROUP BY 판매일자, 구분명
union
SELECT
      DECODE(dno,1,'전체합계') as "판매일자"
     ,null as "구분명"
     ,SUM(qty_nu) as "총 판매수량"
     ,SUM(qty_nu*price_nu) as "매출액"
  FROM (SELECT rownum ano, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'전체합계')
ORDER BY 판매일자




--진혁씨 답안
SELECT 
    DECODE(back.rno,1,front.indate_vc,2,'소계',3,'총계') AS "판매날짜"
   ,DECODE(back.rno,1,front.gubun_vc,2,'계-'||front.gubun_vc,3,'') AS "물품구분"
   ,SUM(DECODE(front.gubun_vc,'빙과류',qty_nu,'과자류',qty_nu
                             ,'청과류',qty_nu,'담배',qty_nu
                             ,'음료',qty_nu))||'개' AS "판매개수"
   ,SUM(DECODE(front.gubun_vc,'빙과류',price_nu*qty_nu,'과자류',price_nu*qty_nu
                             ,'청과류',price_nu*qty_nu,'담배',price_nu*qty_nu
                             ,'음료',price_nu*qty_nu))||'원'AS "판매가격"
  FROM T_ORDERBASKET front
      ,(SELECT rownum rno FROM T_ORDERBASKET WHERE rownum < 4) back
 GROUP BY DECODE(back.rno,1,front.indate_vc,2,'소계',3,'총계')
         ,DECODE(back.rno,1,front.gubun_vc,2,'계-'||front.gubun_vc,3,'')
 ORDER BY "판매날짜" ASC
 
 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------     모      범       담       안      -------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

날짜별.... 소계,,,,, 총계,,,,,

1) 데이터를 3배수로 복제하기 - 카타시안의 곱

SELECT
    *
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
--162개 컬럼 조회
      

2)조건값에 대해 반환값을 설정하여 날짜와 소계, 총계를 보이도록 조회대상을 가공함

SELECT
    DECODE(b.rno,1,a.indate_vc,2,'소계',3,'총계')
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
      

3)물품별로 소계가 나와야하고, 각 소계와 총계들이 한번씩만 나오게하자 - GROUP BY

SELECT
    DECODE(b.rno,1,a.indate_vc,2,'소계',3,'총계') AS "판매날짜"
   ,DECODE(b.rno,1,a.gubun_vc,2,a.gubun_vc||'-계') AS "구분"
   ,DECODE(b.rno,1,name_vc) AS "물품명"
   ,SUM(qty_nu)||' 개' AS "판매개수"
   ,SUM(a.qty_nu*a.price_nu)||' 원' AS "판매가격"
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
 GROUP BY DECODE(b.rno,1,a.indate_vc,2,'소계',3,'총계')
      ,DECODE(b.rno,1,a.gubun_vc,2,a.gubun_vc||'-계') --GROUP함수가 아닌 모든 컬럼명을 기록해야 함
      ,DECODE(b.rno,1,name_vc)
 ORDER BY "판매날짜"
 
 
 
SELECT indate_vc AS "판매날짜"
     , gubun_vc AS "구분"
     , sum(qty_nu*price_nu) "판매금액"
  FROM t_orderbasket
GROUP BY ROLLUP(indate_vc,gubun_vc)