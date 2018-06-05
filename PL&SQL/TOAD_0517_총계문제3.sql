--테이블 상태 확인
EDIT T_ORDERBASKET

--SQL문 골자작성------------------------------------------------------------------
SELECT
    판매날짜(계,소계,전체합계)
   ,물품구분,물품명
   ,판매개수( 개),판매가격( 원)
  FROM t_orderbasket front
      ,(SELECT rownum rno FROM t_orderbasket WHERE rownum<4) back
 GROUP BY 판매날짜(계,소계,전체합계),물품구분,물품명
 ORDER BY 판매날짜(계,소계,전체합계),물품구분,물품명
--------------------------------------------------------------------------------
 
--판매날짜(계,소계,전체합계)
DECODE(back.bno,1,indate_vc,2,indate_vc||' 계',3,'소계',4,'전체합계') AS "판매날짜"

--물품구분
DECODE(back.bno,1,gubun_vc,2,gubun_vc||' 계') AS "물품구분"

--물품명
DECODE(back.bno,1,name_vc,null) AS "물품명"

--판매개수( 개)
--NUMBER타입을 모두 계산하는 DECODE를 작성하고, 그룹함수인 SUM을 적용한 뒤 단위를 부착한다.
SUM(DECODE(back.bno,1,qty_nu,3,qty_nu,4,qty_nu))||' 개' AS "판매개수"

--판매가격( 원)
--NUMBER타입을 모두 계산하는 DECODE를 작성하고, 그룹함수인 SUM을 적용한 뒤 단위를 부착한다.
SUM(DECODE(back.bno,1,qty_nu*price_nu,2,qty_nu*price_nu
                   ,3,qty_nu*price_nu,4,qty_nu*price_nu))||' 원' AS "판매가격"
      
--------------------------------------------------------------------------------

--SQL문 취합 후 조회
SELECT
    DECODE(back.bno,1,front.indate_vc,2,front.indate_vc||' 계',3,'전체합계') AS "판매날짜"
   ,DECODE(back.bno,1,front.gubun_vc,2,front.gubun_vc||' 계') AS "물품구분"
   ,DECODE(back.bno,1,front.name_vc) AS "물품이름"
   ,SUM(DECODE(back.bno,1,qty_nu,2,qty_nu,3,qty_nu))||' 개' AS "판매개수"
   ,SUM(DECODE(back.bno,1,qty_nu*price_nu,2,qty_nu*price_nu
                       ,3,qty_nu*price_nu))||' 원' AS "판매가격"
  FROM t_orderbasket front
      ,(SELECT rownum bno FROM t_orderbasket WHERE rownum<4) back
 GROUP BY DECODE(back.bno,1,front.indate_vc,2,front.indate_vc||' 계',3,'전체합계')
         ,DECODE(back.bno,1,front.gubun_vc,2,front.gubun_vc||' 계')
         ,DECODE(back.bno,1,front.name_vc)
 ORDER BY "판매날짜","물품구분","물품이름"