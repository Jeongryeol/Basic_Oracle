edit temp

edit EMP_LEVEL 

SELECT
    TEMP.EMP_ID
   ,TEMP.EMP_NAME
   ,temp.lev
   , to_char(temp.salary/10000,'999,999')||'연봉' salary
  FROM temp, emp_level
  WHERE emp_level lev = '과장' 
  and TEMP.SALARY BETWEEN EMP_level, FROM_SAL 
  AND TO_SAL  order by temp, salary desc

select SALARY from temp where lev = "과장"

select FROM_SAL, to_age from EMP_LEVEL 

select * from temp
where salary

(select FROM_SAL, to_age from EMP_LEVEL) where lev = "과장"

select 
    TEMP.EMP_ID as "번호"
   ,TEMP.EMP_NAME as " 이름"
   ,to_char(temp.salary/10000, '999,999,999')||'만원' as "연봉"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'만원'as "상한연봉"
   ,to_char(emp_level.from_sal/10000, '999,999')||'만원'as "하한연봉"
    from temp, emp_level
    where TEMP.lev = emp_level.lev(+) 
    
select 
    TEMP.EMP_ID as "번호"
   ,TEMP.EMP_NAME as " 이름"
   ,to_char(temp.salary/10000, '999,999,999')||'만원' as "연봉"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'만원'as "상한연봉"
   ,to_char(emp_level.from_sal/10000, '999,999')||'만원'as "하한연봉"
    from temp LEFT OUTER JOIN emp_level
    ON TEMP.lev = emp_level.lev
    
    
select 
    TEMP.EMP_ID as "번호"
   ,TEMP.EMP_NAME as " 이름"
   ,to_char(temp.salary/10000, '999,999,999')||'만원' as "연봉"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'만원'as "상한연봉"
   ,to_char(emp_level.from_sal/10000, '999,999')||'만원'as "하한연봉"
    from temp RIGHT OUTER JOIN emp_level
    ON TEMP.lev = emp_level.lev                                 
    
    --left outer join의 방식 왼쪽의 주체를 기준으로 오른쪽의 테이블을 대입하여 값이 맞다면 출력이 되도록 아니라면 왼쪽만 출력이 되도록
    --right outer join의 방식 오른쪽의 주체를 기준으로 왼쪽의 테이블을 대입하여 값이 맞다면 출력이 되도록 아니라면 오른쪽만 출력이 되도록
    --inner join 이콜조인 = 양쪽이 다 주체 양쪽이 겹치는 것만
    --all outer join 이콜조인 = 양쪽이 다 주체 양쪽의 전부가 출력

SELF join
대체로 조인이라고 하면 어떤 테이블과 또 다른 테이블간의 특정 컬럼으로 연결하는 경우를 말한다.
tdept테이블에 자신의 상위 부서 정보를 관리하고 있다.
이 테이블을 이용하여 부서코드, 부서명, 상위부서코드, 상위부서명을 익어 오는 sql문을 만들어보시오.

edit tdept


SELECT 
     A.DEPT_CODE AS "부서코드"
    ,A.DEPT_NAME AS "부서명"
    ,A.PARENT_DEPT AS "상위부서코드"
    ,B.DEPT_NAME AS "상위부서명"
    FROM TDEPT A, TDEPT B
     WHERE A.PARENT_DEPT = B.DEPT_CODE
 
 상위부서가 ca0001인 부서에 소속된 직원을 1,사번 ,2성명, 3, 부서코드, 4,부서명, 5,상위부서코드
6,상위부서명, 7,상위부서장코드, 8,상위부서장성명 순서로 출력하세요.


edit tdept

edit temp

SELECT
     AA.DEPT_CODE "사번"
    ,AA.EMP_NAME "성명"
    ,AB.DEPT_NAME "부서코드"
    ,AB.PARENT_DEPT "부서명"
    ,AC.DEPT_NAME "상위부서명"
    ,AC.BOSS_ID "상위부서장코드"
    ,AC.DEPT_NAME "상위부서명"
    ,AA.EMP_NAME "상위부서장성명"
    FROM TEMP AA,TDEPT AB , TDEPT AC 
    WHERE AA.DEPT_CODE = AB.PARENT_DEPT
    AND AB.DEPT_CODE = 'CA0001'
    AND AB.PARENT_DEPT = AA.DEPT_CODE
    ORDER BY AC.BOSS_ID DESC
     
    AND AC.BOSS_ID = AA.EMP_NAME 
    
    ORDER BY AC.BOSS_ID DESC
    
 
select
        a.dept_code "부서코드"
       ,A.DEPT_NAME "부서명"
       ,b.dept_code  "상위부서코드"
       ,b.dept_name "상위부서명"
from tdept a, tdept b   
 where a. parent_dept = b.dept_code
    
 
 2) 1번 결과에 1번 (사번)과 2번(성명)을 추가해 보세요.
 
 SELECT
        C. EMP_ID "사원번호"
       ,C. EMP_NAME "사원명"
       ,A.DEPT_CODE "부서코드"
       ,A.DEPT_NAME "부서명"
       ,B.DEPT_CODE  "상위부서코드"
       ,B.DEPT_NAME "상위부서명"
       ,D. EMP_ID "상위부서장코드"
       ,D. EMP_NAME "상위부서장명"
FROM TDEPT A, TDEPT B, TEMP C, temp D
 WHERE A. PARENT_DEPT = B.DEPT_CODE
    AND A.DEPT_CODE = C.DEPT_CODE
    and d.emp_id = B.boss_id
    and b.dept_code ='CA0001'
    
다음 t_orderbasket 테이블에서 분석용 함수를 사용하지 않고 각 날짜별로
총 몇개의 물건이 얼마만큼 팔렸으며 매출액은 어떻게 되는지 알고 싶다.
어떻게 소계와 합계를 구할 것인가?    


 edit T_ORDERBASKET
 
 날짜를 구함.
 select INdate_vc from T_ORDERBASKET
   group by INdate_vc
   
 갯수의 총합을 구하고, 그 매출액을 합계를 구했다.
 select INdate_vc, sum(QTY_NU),SUM(QTY_NU*PRICE_NU) from T_ORDERBASKET
   group by INdate_vc
   
   
 