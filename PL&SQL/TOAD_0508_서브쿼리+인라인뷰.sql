--집합적 사고
--UNION, UNION ALL, MINUS, INTERSECT 는
--두 개 이상의 집합에서 사용하는 컬럼의 수가 일치해야하고, 그 타입도 일치해야 한다.

UNION을 이용해서 temp와 tcom의 자료 중 emp_id, salary, comm을 보여주는 SQL문을 작성하시오
이 때 salary와 comm이 모두 존재하는 사번은 두줄로 나와야 한다.

edit temp

edit tcom

SELECT emp_id, salary, 0 comm FROM temp
UNION
SELECT emp_id, 0 salary, comm FROM tcom

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp

SELECT deptno FROM dept
INTERSECT
SELECT deptno FROM emp

--컬럼수와 타입이 같아야 집합적연산이 가능하다.

--3장 001 table 추가하여 신입사원 데이터를 추가, 20명짜리 temp 테이블로 만들어줌.

SELECT * FROM temp

SELECT emp_name, hobby FROM temp
ORDER BY hobby ASC; --오름차순 : ㄱ부터 ㅎ까지 정리 후 NULL(모른다) 로 정리함.

SELECT emp_name, hobby FROM temp
ORDER BY hobby DESC; --내림차순 : NULL(모른다)이후 ㄱ부터 ㅎ까지 정리함. 왜?

NULL은 모른다 이므로 오름차순 정렬시 맨 뒤에 올 수 밖에 없다.
내림차순 정렬의 경우 오름차순의 반대이므로 취미가 NULL인 것들이 맨 앞에 오는 것임. (단순한 사실)

---------------------------------------------------------------------------------

--서브쿼리 기본꼴
SELECT
  FROM 집합
 WHERE 컬럼명 = (SELECT문) --서브쿼리

--인라인뷰 기본꼴
SELECT
  FROM (SELECT절) --인라인뷰

서브쿼리와 인라인뷰의 공통점 : SELECT문이 2개 이상이다.

연습문제1
SMITH사원보다 급여가 많은 사원들의 사원번호, 사원명, JOB를 출력하는 SQL문을 작성하시오.

SELECT empno as "사원번호", ename as "사원명", JOB FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH') 

SELECT empno as "사원번호", ename as "사원명", JOB FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename=:x)
 --단위테스트 처리방법 (변수자리에 오는 값이 메소드의 파라미터로 결정된다 ) 


연습문제2
temp에서 연봉이 가장 많은 직원의 row를 찾아서
이 금액과 동일한 금액을 받는 사원의 사번과 성명, 연봉을 출력하시오

SELECT emp_id as "사번", emp_name as "성명", salary as "연봉" FROM temp
 WHERE salary = (SELECT MAX(salary) FROM temp WHERE lev = '사원')

SELECT emp_id, emp_name, salary FROM temp
 WHERE 1=1 --SQL문 공격
   AND salary = (select max(salary) FROM temp)

SELECT mem_name FROM member
 WHERE mem_id='test1'
   AND mem_pw='1234'
    OR 1=1 --이런 어이없는 경우로 정보가 노출되는 위험이 초창기에 있었다.

연습문제3
temp의 자료를 이용하여 salary의 평균을 구하고
이보다 큰 금액을 salary로 받는 직원의 사번과 성명, 연봉을 보여주는 SQL문을 작성하시오.

SELECT emp_id as "사번", emp_name as "성명", salary as "연봉" FROM temp
 WHERE salary > (SELECT AVG(salary) FROM temp)

  
---------------------------------------------------------------------------------

실전문제1
temp의 직원 중 인천에 근무하는 직원의 사번과 성명을 읽어오는 SQL문을 작성하시오

SELECT te.emp_id as "사번", te.emp_name as "성명", td.area as "근무지역", td.dept_code as "부서코드"
  FROM temp te, tdept td
 WHERE td.area = '인천'
    AND te.dept_code = td.dept_code

--IN 구문을 알고있나요?
SELECT empno, ename FROM emp WHERE deptno IN(10,30)

--서브쿼리문에 사용될 SELECT문 작성해보기
SELECT dept_code FROM tdept WHERE area='인천'

--주쿼리에 사용될 SELECT문 작성해보기
SELECT emp_id, emp_name FROM temp

--모범답안
SELECT emp_id, emp_name
  FROM temp
 WHERE dept_code IN(SELECT dept_code FROM tdept WHERE area='인천')

--주의사항
--서브쿼리에서 사용된 컬럼명은 바깥쪽 주쿼리 SELECT문에서는 사용이 불가능함.
--FROM절에 사용한 테이블명은 사용할 수 있지만, 없는 컬럼명은 사용이 불가능하다.

--인라인뷰에서 사용하지 않은 컬럼과 서브쿼리에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다.
--또한, 테이블엔 존재하더라도 인라인뷰에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다.


실전문제2
tcom에 연봉 외에 커미션을 받는 직원의 사번이 보관되어 있다.
이 정보를 이용하여 부서명칭별로 커미션을 받는 인원수를 세는 문장을 완성해보시오.

SELECT dept_code, COUNT(tcom.comm) FROM tcom, temp
 WHERE temp.emp_id = tcom.emp_id
 GROUP BY dept_code

--커미션을 받는 직원의 사번 구하기
SELECT emp_id FROM tcom

SELECT COUNT(emp_id) FROM temp
 WHERE emp_id IN(SELECT emp_id FROM tcom)
 GROUP BY dept_code 

SELECT dept_name, count(emp_id)
  FROM temp, tdept
 WHERE temp.emp_id IN(SELECT emp_id FROM tcom)
   AND temp.dept_code = tdept.dept_code
 GROUP BY dept_name 

-------------------------------------------------------------------------------

도전문제1
tdept에서 부서코드와 boss_id를 읽어서 --부서장의 사원번호
이 두 개 컬럼이 temp의 부서코드와 사번에 일치하는 사람의
사번과 성명을 읽어오는 쿼리문을 작성하시오

SELECT emp_id as "사번", emp_name as "성명"
  FROM temp
 WHERE emp_id IN (SELECT boss_id FROM tdept)
   AND dept_code IN (SELECT dept_code FROM tdept)

--서브쿼리
SELECT dept_code, boss_id FROM tdept

--주쿼리
SELECT emp_id, emp_name FROM temp

--머지해보자
SELECT
       emp_id, emp_name
  FROM temp
 WHERE (dept_code, emp_id) IN (SELECT dept_code, boss_id FROM tdept) --일치하는! 이라고 했으므로 IN구문!!
 
 

도전문제2
temp에서 부서별 최고 연봉금액을 읽어서 --서브쿼리
해당 부서와 최고 연봉금액이 동시에 일치하는 --두 컬럼이 비교대상(서브쿼리와 주쿼리)
사원의 사번, 성명, 연봉을 --SELECT 대상
출력하는 쿼리문을 작성하시오

--서브쿼리 기본꼴
SELECT dept_code, max(salary)
  FROM temp -- temp에서!!
 GROUP BY dept_code --부서별!!

--주쿼리 기본꼴
SELECT emp_id as "사번", emp_name as "성명", salary as "연봉"
  FROM temp
 WHERE ( , ) IN ( 서브쿼리 )
 
--머지하자!!
SELECT emp_id as "사번", emp_name as "성명", salary as "연봉"
  FROM temp
 WHERE (dept_code, salary) IN ( SELECT dept_code, max(salary)
                                  FROM temp
                                 GROUP BY dept_code )
                                 



