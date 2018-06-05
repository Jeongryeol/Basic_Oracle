연습문제 2회차

월요일엔 해당일자에 01를 붙여서 4자리 암호를 만들고
화요일엔 11, 수요일엔 21, 목요일엔 31, 금요일엔 41, 토요일엔 51, 일요일엔 61를 붙여서
4자리 암호를 만든다고 할 때 암호를 구하는 SQL문을 작성하시오.

힌트

SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH:MI:SS AM')
     ,TO_CHAR(sysdate,'day')
     ,TO_CHAR(sysdate,'DD')
    FROM dual

SELECT
        TO_CHAR(sysdate,'DD') || DECODE(TO_CHAR(sysdate,'day'),'월요일',01
                                                                                         ,'화요일',11
                                                                                         ,'수요일',21
                                                                                         ,'목요일',31
                                                                                         ,'금요일',41
                                                                                         ,'토요일',51
                                                                                         ,'일요일',61) as "4자리 암호"
    FROM dual

--------------------------------------------------------------------------------------------------------------------
    
IF TO_CHAR(sysdate,'day')='월요일' THEN
        return '01';
ELSIF TO_CHAR(sysdate,'day')='화요일' THEN
        return '11';
ELSIF TO_CHAR(sysdate,'day')='수요일' THEN
        return '21';
ELSIF TO_CHAR(sysdate,'day')='목요일' THEN
        return '31';
ELSIF TO_CHAR(sysdate,'day')='금요일' THEN
        return '41';
ELSIF TO_CHAR(sysdate,'day')='토요일' THEN
        return '51';
ELSIF TO_CHAR(sysdate,'day')='일요일' THEN
        return '61';    
END IF;


--------------------------------------------------------------------------------------------------------------------
실전문제

사원테이블에서 job이 CLERK인 사람의 급여의 합. SALESMAN인 사람의 급여의 합을 구하고 
나머지 job에 대해서는 기타합으로 구하는 SQL문을 작성하시오.

CLERK_합    SALESMAN_합   기타_합
------------------------------------
     ?                     ?                  ?
     

SELECT
        '$'||TO_CHAR(SUM(DECODE(job,'CLERK',sal)), '9,999') as "CLERK_합계"
       ,'$'||TO_CHAR(SUM(DECODE(job,'SALESMAN',sal)), '9,999') as "SALEMAN_합계"
       ,'$'||TO_CHAR(SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal)), '99,999') as "기타_합계"
    FROM emp
    


------------------------------------------------------------------
실전문제
t_worktime 테이블에는 작업코드별로 작업시간이 저장되어 있다.
이들 데이터의 작업시간이 짧게 걸리는 시간 순서대로 1부터 15까지의 순위를 
매겨서 출력하시오.
(단 rank()함수를 사용하지 말고 꼭 해보세요)
만일 rank함수를 사용했을 경우에는 반드시 문제풀이를 2가지 올려주세요^^

COUNT 함수를 이용하여 RANK매기기

SELECT
    seq_vc, COUNT(seq_vc) as "작업우선순위"
    FROM(SELECT
                        a.seq_vc
                    FROM t_worktime a, t_worktime b
                    WHERE a.time_nu>= b.time_nu)
    GROUP BY seq_vc
    ORDER BY COUNT(seq_vc) 

--[문제풀이] 구상하고 도식하기---------------------------------------

1) 가상의 3개짜리 결과값이 있는 테이블을 합집합으로 구성함

SELECT 1.15 w_t FROM dual
UNION ALL
SELECT 0.4 w_t FROM dual
UNION ALL
SELECT 2.4 w_t FROM dual

2) 위 집합을 2개로 복제해서 a1과 a2로 구분하여, 9가지 경우의 수가 나오는 것을 확인함 ( 3 X 3 )

SELECT
        *
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
      
3) a1의 값이 a2의 값보다 큰 경우의 수만 골라보자

SELECT
        *
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
 WHERE a1.w_t >= a2.w_t

4) COUNT함수를 이용해서 각 경우의 수의 개수를 새어보면, 그 개수가 a1의 값이 a2의 값보다 크다는 경우이므로, 더 빠른 시간인 것이 그만큼 더 많다는 의미이다.
곧, COUNT의 숫자가 순위가 된다.

SELECT
        COUNT(a1.w_t)
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
 WHERE a1.w_t >= a2.w_t
GROUP BY a1.w_t
ORDER BY count(a2.w_t) asc;

-------------------------------------------------------------------------------

SELECT
        RANK() OVER (PARTITION BY workcd_vc ORDER BY TIME_NU) as 순위
       ,workcd_vc
       ,time_nu
  FROM t_worktime