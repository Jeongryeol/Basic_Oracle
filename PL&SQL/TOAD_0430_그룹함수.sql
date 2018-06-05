SELECT
        MAX(empno), MAX(sal), MAX(comm)
       ,MIN(empno), MIN(sal), MIN(comm)
    FROM emp
    
SELECT
        MAX(empno), MAX(sal), MAX(comm)
       ,MIN(empno), MIN(sal), MIN(comm)
       ,ename
    FROM emp



생각해보기
우리회사에 근무하는 사원들 중 금여액이 가장 많은 사원의 급여액을 출력하시오.

SELECT MAX(sal) FROM emp



우리회사에 근무하는 사원들에 대해 부서별 급여액이 가장 큰 금액을 출력하는 SQL문을 작성하시오.

SELECT distinct(deptno) FROM emp

SELECT ename FROM emp
GROUP BY ename --gruop  by 한 효과가 있다|없다. -> 없다

SELECT ename, COUNT(ename) FROM emp--group by가 있을때 사용할 수 있는 컬럼은 정해져있다.아니다
GROUP BY ename

SELECT deptno, COUNT(deptno), MAX(sal), MIN(sal), AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000

--에러발생함. 왜지?
SELECT ename,COUNT(ename) FROM emp--왜 group by한 효과가 없음에도 생략하면 에러가 발생하지?

SELECT deptno as "부서번호" ,MAX(sal) as "급여액"
    FROM emp
    GROUP BY deptno;


SELECT deptno, ename, avg(sal)
    FROM emp
    GROUP BY deptno
--에러를 해결함    
SELECT deptno, count(ename), avg(sal)
    FROM emp
    GROUP BY deptno
    
사원테이블에서 job이 CLERK인 사람의 급여의 합. SALESMAN인 사람의 급여의 합을 구하고,
나머지 job에 대해서는 기타 합으로 구하는 SQL문을 작성하시오.

SELECT distinct(job) FROM emp

SELECT
        SUM(DECODE(job,'CLERK',sal)) as "CLERK급여합"
       ,SUM(DECODE(job,'SALESMAN',sal)) as "SALESMAN급여합"
       ,SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "기타급여합"
    FROM emp
    
    GROUP BY jo

SELECT
        COUNT(DECODE(job,'CLERK',sal)) as "CLERK인원"
       ,SUM(DECODE(job,'CLERK',sal)) as "CLERK급여합"
       ,COUNT(DECODE(job,'SALESMAN',sal)) as "SALESMAN인원"
       ,SUM(DECODE(job,'SALESMAN',sal)) as "SALESMAN급여합"
       ,COUNT(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "기타인원"
       ,SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "기타급여합"
    FROM emp