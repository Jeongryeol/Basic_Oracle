CREATE OR REPLACE PROCEDURE proc_emptest(p_empno IN number
                                        ,msg OUT varchar2)
IS
    --선언부
    v_name VARCHAR2(20) := '이순신';
    v_emp emp%rowtype;
BEGIN
    --실행문
    SELECT empno, job, ename
      INTO v_emp.empno, v_emp.job, v_emp.ename
      FROM emp
     WHERE empno = p_empno;
    msg:=v_emp.ename||','||v_emp.job;
END;

