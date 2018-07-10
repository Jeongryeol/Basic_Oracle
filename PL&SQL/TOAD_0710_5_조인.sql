--기본조인구문
SELECT
    emp.empno, emp.job, dept.dname --부서번호가 아니라 부서명이 보이므로 직관적 (업무담당자 기호)
  FROM emp, dept
 WHERE emp.deptno = dept.deptno --equal join : 양쪽에 같은 것이 있을때 조회되는 조인