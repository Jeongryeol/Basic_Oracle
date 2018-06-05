DECODE 활용을 위한 연습문제
--DECODE는 내부적으로 ELSE의 기능을 가지고 있으며, ELSE에 해당될 경우 NULL을 리턴함.

연습문제1
주당 강의시간(lec_time)과 학점(lec_point)이 같으면 '일반과목'을 돌려받는 sql문 작성하기

SELECT   
    LEC_ID
   ,DECODE(lec_time,lec_point,'일반과목')
    FROM LECTURE

------------------------[ 문제풀이 ]--------------------------------

DECODE ( 시간, 학점, '일반과목' ) FROM 집합

SELECT
    lec_id as "강좌아이디"
   ,DECODE(lec_time, lec_point, '일반과목', null)as "과목유형"
    FROM lecture

-----------------------------------------------------------------



연습문제2
주당 강의시간과 학점이 같은 수를 과목의 수를 알수있는 sql문 작성하기

SELECT count(*) as "'주당 강의시간=학점'과목의 수" FROM LECTURE
    WHERE DECODE(lec_time,lec_point,1)=1

또는

SELECT count(*) as "'주당 강의시간=학점'과목의 수" FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=0

------------------------[ 문제풀이 ]--------------------------------

--SELECT count(*), count(empno)m, count(comm) FROM emp

--SELECT count(*)
--    FROM lecture
--   WHERE lec_time = lec_point
   
--DECODE(lec_time, lec_point,1)

SELECT
        COUNT(DECODE(lec_time, lec_point,1,null)) as "강의시간과학점이같은강좌수  "
    FROM lecture

-----------------------------------------------------------------



연습문제3
lec_time이 lec_point보다 크면 '실험과목', lec_point가 크면 '기타과목',
둘이 같으면 '일반과목'으로 돌려받는 sql문 작성하기

SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),0,'일반과목') as "분류"FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=0
UNION ALL
SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),1,'실험과목') FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=1
UNION ALL
SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),-1,'기타과목') FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=-1
ORDER BY LEC_ID ASC;

-----------------------------------------------------------------

SELECT
    lec_id
   ,DECODE(SIGN(lec_time-lec_point),1,'실험과목',-1,'기타과목',0,'일반과목') as "분류"
    FROM lecture

------------------------[ 문제풀이 ]--------------------------------

lec_time-lec_point > 0 실험과목
lec_time-lec_point = 0 일반과목
lec_time-lec_point < 0 기타과목
>>>>> SIGN(???) !!!!

DECODE 는 심각한 장애가 있다 : 크다 혹은 작다 의 비교는 불가하다.
그러나
SIGN 을 이용하면 두 숫자의 차이의 값으로 크기비교가 가능하다 ( -1, 0, 1 )

DECODE( SIGN(lec_time-lec_point),1,'실험과목'
                                                ,0,'일반과목'
                                                ,-1,'기타과목')

SELECT
        lec_id as " 강좌아이디"
       ,DECODE( SIGN(lec_time-lec_point),1,'실험과목'
                                                ,0,'일반과목'
                                                ,-1,'기타과목') as "강좌유형"
    FROM lecture
 
-----------------------------------------------------------------

BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT lec_id into v_lec_id FROM LECTURE;
    IF (SIGN(lec_time-lec_point)=1) THEN
    DBMS_OUTPUT.PUT_LINE( ' 실험과목 ' );
    ELSIF (SIGN(lec_time-lec_point)=-1) THEN
    DBMS_OUTPUT.PUT_LINE( ' 기타과목 ' );
    ELSe (SIGN(lec_time-lec_point)=0) THEN
    DBMS_OUTPUT.PUT_LINE( ' 일반과목 ' );
    END IF;

---------------------------------------------------------------------------

---------------------------------------------------------------------------

문제1
영화 티켓을 받을 수 있는 사람의 명단과 현재 가지고 있는 포인트, 영화 티켓의 포인트
그리고 그 티켓을 사용한 후 남은 예상 포인트를 출력하시오.

SELECT
    NAME_VC as "고객이름"
   ,POINT_NU as "현재포인트"
   ,15000 as "영화티켓소모포인트"--GIFTPOINT 테이블에 있는 영화티켓의 POINT_NU의 값을 가져와서 각셀이 넣으려면??
   ,DECODE(SIGN(POINT_NU-15000),1,'교환가능','미해당') as "영화티켓"
   ,DECODE(SIGN(POINT_NU-15000),1,POINT_NU-15000) as "예상잔여포인트"
    FROM T_GIFTMEM

---------- 식별자를 이용해서 여러 집합에서 선택가능

SELECT
    a.NAME_VC as "고객이름"
   ,a.POINT_NU as "현재포인트"
   ,b.POINT_NU  as "영화티켓"
   ,a.POINT_NU-b.POINT_NU as "잔여포인트"
    FROM T_GIFTMEM a, T_GIFTPOINT b
    WHERE b.NAME_VC = '영화티켓' AND a.POINT_NU >= b.POINT_NU

--[문제풀이]---------------------------------------------------------------------------

edit t_giftmem

edit t_giftpoint

SELECT * FROM t_giftmem, t_giftpoint --아스터리스크(*)는 왠만하면 사용 하지 마세요.


SELECT * FROM t_giftmem mem, t_giftpoint point
WHERE mem.point_nu >= point.point_nu
      AND point.name_vc='영화티켓'
      
출력결과
보유포인트 mem.point_nu
사용포인트 point.point_nu
잔여포인트 mem.point_nu - point.point_nu

SELECT
        mem.name_vc as "회원이름"
       ,TO_CHAR(mem.point_nu,'999,999')||'점' as "보유포인트"
       ,TO_CHAR(point.point_nu,'999,999')||'점' as "사용포인트"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'점' as "잔여포인트"
    FROM t_giftmem mem, t_giftpoint point
    WHERE mem.point_nu >= point.point_nu
    AND point.name_vc='영화티켓'

블럭설정 -> Ctrl+E : 실행계획보기


개선코드? 일량을 줄이는 방법이 있지 않을까?

위 답안지 에서는 t_giftmem전체와 t_giftpoint 전체를 비교하고 있다.
그런데 업무담당자의 요구사항은 영화티켓에 대해서만 조회를 원하고 있다.
따라서 집합 전체를 비교하지 말고 t_giftpoint 집합에서 영화티켓만 1차 가공해서
비교하게되면 옵티마이저가 따져야 하는 경우의 수를 줄일 수 있다.

개선코드 1

SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
 WHERE name_vc='영화티켓'

SELECT /*+choose*/
        mem.name_vc as "회원이름"
       ,TO_CHAR(mem.point_nu,'999,999')||'점' as "보유포인트"
       ,TO_CHAR(point.point_nu,'999,999')||'점' as "사용포인트"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'점' as "잔여포인트"
    FROM t_giftmem mem, (SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
                          WHERE name_vc='영화티켓') point
    WHERE mem.point_nu >= point.point_nu -- 1:n으로 만들어주어 옵티마이저의 부하를 줄여주자.


SELECT /*+choose*/
        mem.name_vc as "회원이름"
       ,TO_CHAR(mem.point_nu,'999,999')||'점' as "보유포인트"
       ,TO_CHAR(point.point_nu,'999,999')||'점' as "사용포인트"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'점' as "잔여포인트"
    FROM t_giftmem mem, (SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
                          WHERE name_vc='영화티켓') point
    WHERE mem.point_nu >= point.point_nu -- 1:n으로 만들어주어 옵티마이저의 부하를 줄여주자.

옵티마이저의 작동모드 2가지
1)rule base optimizer - 15가지의  규칙 기준에 따라 실행계획을 세운다.
    수동카메라 - 개발자가 생각하는 실행계획으로 조회할 수 있다.
2)cost base optimizer - 비용을 계산해서 그 비용이 적은 쪽으로 실행계획을 세운다.
    자동카메라 - 개발자의 생각 반영
    단, 데이터의 분포도를 계산해야 정확도가 높아진다.
    

결론
두 개 이상의 집합을 연결해서 답을 구해야 할 경우에는
가능하면 원소 갯수를 먼저 줄이고 비교할 것


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
문제2
김유신씨가 보유하고 있는 마일리지 포인트로 얻을 수 있는 상품 중 가장 포인트가 높은 것은 무엇인가?

SELECT a.NAME_VC as "고객이름"
      ,a.POINT_NU as "보유포인트"
      ,b.NAME_VC as "구매가능상품"
      ,b.POINT_NU as "소요포인트"
    FROM  T_GIFTMEM a
        ,(SELECT NAME_VC, POINT_NU FROM T_GIFTPOINT
            ORDER BY POINT_NU desc) b
    WHERE a.NAME_VC='김유신'
        AND b.POINT_NU<=a.POINT_NU
        AND rownum = 1    

      
-----

SELECT * FROM T_GIFTPOINT
    ORDER BY POINT_NU DESC

SELECT
    a.NAME_VC as "고객이름"
   ,b.NAME_VC as "최고가상품"
   ,b.POINT_NU as "소요포인트"
    FROM T_GIFTMEM a
        ,T_GIFTPOINT b
   WHERE a.NAME_VC = '김유신'
     AND b.NAME_VC='구두상품권'      


--문제풀이----------------------------------------------------------------------

1) 김유신이 보유하고 있는 포인트를 찾는다.

SELECT point_nu FROM t_giftmem
 WHERE name_vc='김유신'

2) 1번에서 구한 포인트를 가지고 t_giftpoint에서 작거나 같은 것을 찾는다.

SELECT point_nu
  FROM t_giftpoint
 WHERE point_nu <= 50012
 
SELECT point_nu
  FROM t_giftpoint
 WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                     WHERE name_vc='김유신')
                     
3) 2번 결과 중에서 가장 큰 값을 찾는다. (max함수)

SELECT MAX(point_nu)
  FROM t_giftpoint
 WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                     WHERE name_vc='김유신')
                     
4) 3번에서 구한 값을 가지고 t_giftpoint에서 상품명을 출력한다.

SELECT
        name_vc as "세트명", point_nu as "최고가 선물가격"
  FROM t_giftpoint
 WHERE point_nu = (SELECT MAX(point_nu)
                    FROM t_giftpoint
                   WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                                       WHERE name_vc='김유신'))
                                       
----- T_GIFTPOINT 집합을 2번걸쳐서 실행되었는데..? 횟수를 줄일 수 있는 방법은 없을까?

--아래코드는 상품이름 중에 이름이 가장 큰값이 나오는 경우이므로 답이 아니다.
--상품이름과 상품포인트가 다르다.

SELECT MAX(poi.name_vc)
      ,MAX(poi.point_nu)
  FROM t_giftpoint poi, t_giftmem mem
 WHERE poi.point_nu <= mem.point_nu
   AND mem.name_vc='노정환'