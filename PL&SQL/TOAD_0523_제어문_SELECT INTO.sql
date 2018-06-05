CREATE OR REPLACE PROCEDURE SCOTT.proc_test6(p_deptno IN number)
IS
   v_name varchar2(30);
   v_deptno number(10);
BEGIN
    SELECT deptno, dname INTO v_deptno, v_name
      FROM dept
     WHERE deptno = p_deptno;
    dbms_output.put_line(v_deptno||','||v_name);
    EXCEPTION
        WHEN others THEN
        dbms_output.put_line('에러코드'||sqlcode);
        dbms_output.put_line('에러내용'||sqlerrm);
END;


exec SCOTT.proc_test6('10');