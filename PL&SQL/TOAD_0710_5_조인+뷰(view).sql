--프로시저로 VIEW 만들어 조인한 것을 보기
CREATE OR REPLACE VIEW v_emp
as
SELECT
    emp.empno, emp.job, dept.dname
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
 

--VIEW로 부여된 권한으로 조회하는 내용
SELECT * FROM v_emp