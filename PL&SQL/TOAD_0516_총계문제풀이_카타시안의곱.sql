[ 총계 문제 1탄 ]

다음 t_orderbasket 테이블에서 분석용 함수를 사용하지 않고
각 날짜별로 총 몇 개의 물건이 얼마만큼 팔렸으며 매출액은 어떻게 되는지 알고 싶다.
어떻게 소계와 합계를 구할 것인가?

SELECT
        *
  FROM T_ORDERBASKET



2배수복제 - 카타시안의 곱 - 소계를 구하거나 총계를 구할때
ㄴ 만약 제공함수가 있으면 필요없다.


--1
SELECT indate_vc, qty_nu, price_nu FROM T_ORDERBASKET


--2
SELECT indate_vc, qty_nu, price_nu
  FROM T_ORDERBASKET
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 )

      
--3
SELECT DECODE(tmp.rno,1,bas.indate_vc,2,'총계')
  FROM T_ORDERBASKET bas
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 ) tmp
 GROUP BY DECODE(tmp.rno,1,bas.indate_vc,2,'총계')
--COUNT함수는 로우의 개수이기때문에, 컬럼내 변수같은 DATA가 더해져야하므로 SUM함수를 써야한다.
--GROUP함수는 상수와 함께 사용할 수 있지만, 단일함수와는 함께 사용할 수 없다. 그룹함수를 씌워주어야 한다.
 

--4
SELECT DECODE(tmp.rno,1,bas.indate_vc,2,'총계') as "판매일자"
      ,SUM(qty_nu) as "판매개수"
      ,SUM(qty_nu*price_nu) as "판매액"
  FROM T_ORDERBASKET bas
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 ) tmp
 GROUP BY DECODE(tmp.rno,1,bas.indate_vc,2,'총계')
 ORDER BY DECODE(tmp.rno,1,bas.indate_vc,2,'총계')
--GROUP BY 와 ORDER BY 의 용도 복습
--카타시안의 곱이 활용될 수 있는 경우
--decode는 from절만 제외하고 모두 사용할 수 있다.