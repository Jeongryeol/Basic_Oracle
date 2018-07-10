CREATE OR REPLACE PROCEDURE proc_empjoin(in_empno IN number
                                        ,msg OUT varchar2)
IS
    --�����
    v_emp emp%rowtype;
    v_dname VARCHAR2(20);
BEGIN
    --���๮
    SELECT empno, job, dname
      INTO v_emp.empno, v_emp.job, v_dname
      FROM v_emp
     WHERE empno = in_empno;
    msg:=v_emp.empno||','||v_emp.job||','||v_dname;
END;

