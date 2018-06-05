1.월 급여는 연봉을 18로 나누어 홀수 달에는 연봉의 1/18이 지급되고, 짝수달에는 연봉의
2/18가 지급된다고 가정했을 때 홀수 달과 짝수 달에 받을 금액을 나타내시오.

SELECT
    EMP_NAME as "성명"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18,-4),'99,999,999,999') as "홀수달"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18*2,-4),'99,999,999,999') as "짝수달" 
     FROM temp 



2.위에서 구한 월 급여에 교통비가 10만원씩 지급된다면(짝수달은 20만원)위의 문장이 
어떻게 바뀔지 작성해 보시오.

SELECT
    EMP_NAME as "성명"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18+100000,-4), '99,999,999,999') as "홀수달"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18*2+200000,-4),'99,999,999,999') as "짝수달" 
     FROM temp 



3.TEMP 테이블에서 취미가 NULL 이 아닌 사람의 성명을 읽어오시오.

SELECT
    EMP_NAME
   ,HOBBY
    FROM TEMP
   WHERE HOBBY IS NULL

 

4.TEMP 테이블에서 취미가 NULL인 사람은 모두 HOBBY를 “없음”이라고 값을 치환하여 
가져오고 나머지는 그대로 값을 읽어오시오.

SELECT
    EMP_NAME
   ,NVL(HOBBY,'없음')
    FROM TEMP
       
    
  
5.TEMP의 자료 중 HOBBY의 값이 NULL인 사원을 ‘등산’으로 치환했을 때 HOBBY가 ‘등산인
사람의 성명을 가져오는 문장을 작성하시오.

SELECT
    EMP_NAME
   ,NVL(HOBBY,'등산')
    FROM TEMP
   WHERE NVL(HOBBY,'등산') ='등산'
    

 
6.TEMP의 자료 중 EMP_ID와 EMP_NAME을 각각 ‘사번’,’성명’으로 표시되어 DISPLAY되도록
COLUMN ALLIAS를 부여하여 SELECT 하시오.

SELECT
    EMP_ID as "사번"
   ,EMP_NAME as "성명"
    FROM TEMP

  
7.성명과 생년월일을 작은따옴표로 묶어서 하나의 문자열로 보여주는 문장을 만들어 보시오.

SELECT
    EMP_NAME||' '||BIRTH_DATE as "'성명과 생년월일'"
    FROM TEMP
 


8.TEMP의 자료를 직급 명(LEV)에 ASCENDING하면서 결과내에서 다시 사번 순으로 
DESCENDING하게 하는 ORDER BY하는 문장을 만들어 보시오.

SELECT
    EMP_NAME as "성명"
   ,/*+index_asc(TEMP pk_EMP_ID)*/LEV as "직급"
   ,EMP_ID as "사번"
    FROM TEMP
    ORDER BY EMP_ID DESC
--TEMP 폴더에 UNIQUE PRIMARY KEY가 없어서 사용할 수 없음

SELECT
    EMP_NAME as "성명"
   ,LEV as "직급"
   ,EMP_ID as "사번"
    FROM (SELECT * FROM TEMP ORDER BY LEV ASC)
    ORDER BY EMP_ID DESC
    
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



SELECT * FROM temp

SELECT emp_name, salary FROM temp

SELECT 1 as "홀수급여", 2 as "짝수급여" FROM dual

SELECT emp_name as "이름", salary/18||'원' as "홀수급여", salary/9||'원' as "짝수급여" FROM temp

SELECT TO_CHAR(555555555555,'999,999,999,999') FROM dual

SELECT
    emp_name as "이름"
   ,TO_CHAR(salary/18,'999,999,999,999')||'원' as "홀수급여"
   ,TO_CHAR(salary/9,'999,999,999,999')||'원' as "짝수급여"
    FROM temp
    
SELECT ROUND(123.4567,1), ROUND(123.4567,2), ROUND(123.4567,-2) FROM dual


--**[1번문제 모범답안]*********************************************************

SELECT
    emp_name as "이름"
   ,TO_CHAR(ROUND(salary/18,-3),'999,999,999,999')||'원' as "홀수급여"
   ,TO_CHAR(ROUND(salary/9,-3),'999,999,999,999')||'원' as "짝수급여"
    FROM temp

--***********************************************************************


--**[8번문제 모범답안]*********************************************************

SELECT
    emp_name as "이름"
   ,lev as "직급"
   ,emp_id as "사원번호"
    FROM temp
   ORDER BY pos desc, emp_id asc

--***********************************************************************


--SELECT와 FROM 절 사이에 컬럼이나 상수를 추가하면
--로우가 늘어난다? \ 컬럼이 늘어난다?

SELECT 1,2,3 FROM dual

SELECT empno, ename, sal FROM emp


--만일 로우를 증가시키고 싶다면 어떡하지?

--UNION : 중복을 제거하고 정렬시켜 조회한다 (검색속도 저하)

--UNION ALL : 그대로 합친다.


SELECT empno, ename, deptno
  FROM emp
 WHERE deptno
    IN(10,30);
UNION ALL

SELECT empno, ename, deptno
  FROM emp
 WHERE deptno
 IN(20,30);
 
 조건 종류
 1)점조건 : =, IN
 2)선분조건 : BETWEEN a AND b
            WHERE sal >= 800 AND sal < 3000
            
SELECT empno, ename FROM emp WHERE ename LIKE 'S'||'%' --선분조건의 예시

SELECT empno, ename FROM emp WHERE ename LIKE '%'||'S'||'%' --선분조건의 예시



SELECT seq_vc, words_vc FROM t_letitbe
ORDER BY LPAD(seq_vc,2,0) ASC

SELECT seq_vc, words_vc FROM t_letitbe
ORDER BY RPAD(seq_vc,2,0) ASC

http://ghostwil-program.blogspot.com/2015/12/lpad-rpad.html

SELECT rownum empno, ename FROM emp --유니크하게 만들어줌

SELECT empno, ename FROM emp