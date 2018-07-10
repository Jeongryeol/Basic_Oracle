CREATE OR REPLACE PROCEDURE proc_emptest(p_empno IN number
                                        ,msg OUT varchar2)
IS
    --�����
    v_name VARCHAR2(20) := '�̼���';
    v_emp emp%rowtype;
BEGIN
    --���๮
    SELECT empno, job, ename
      INTO v_emp.empno, v_emp.job, v_emp.ename
      FROM emp
     WHERE empno = p_empno;
    msg:=v_emp.ename||','||v_emp.job;
END;

