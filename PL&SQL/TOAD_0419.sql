--우리회사에 근무하는 사원들 중에서 사번이 7499인 사원이
--근무하는 부서명을 알고 싶다. 어떡하지?

--dname은 emp에 없는 컬럼이므로 사용할 수 없어요.
--dname은 dept에 있는 컬럼이므로 FK로 deptno를 먼저 찾아줘요.

SELECT
        deptno as "부서번호"
   FROM emp
  WHERE empno = 7499

--찾아낸 deptno를 기준으로 dept에 있는 dname 컬럼을 찾아줘요.

SELECT
        dname as "부서명"
   FROM dept
  WHERE deptno = 30
 
-- :x 를 지정해두면 실행한 뒤  조건값을 입력할 수 있다. 
--한방에 처리하고 싶어요. ( 실행계획을 더 높게 하자)

SELECT
        dept.deptno as "부서번호", dname as "부서명",
   FROM emp. dept
  WHERE emp.empno = 7499
    AND dept.deptno = 30 
 

SELECT * FROM emp, dept

SELECT * FROM member

--14명의 사원에대해 4개의 부서가 각각 연결되어 N 대N의 개별대응이 일어났고, 14x4의 결과로 56개가 나옴
--그러나 우리가 필요한 정보는 56개가 아닌 특정 1개의 결과임




--회원번호가 7500 이상인 분들이 일하시는 직장의 지역을 찾으세요.

SELECT
        emp. empno as "사원번호"
       ,emp. ename as "사원명"
      ,dept. loc as "지역"
   from emp, dept
  where empno >= 7500 