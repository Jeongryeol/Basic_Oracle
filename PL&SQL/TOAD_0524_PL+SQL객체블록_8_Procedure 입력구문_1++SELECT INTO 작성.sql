CREATE OR REPLACE PROCEDURE proc_cursor_attribute(p_empno IN VARCHAR2)
IS
    t_emp emp%rowtype;
BEGIN
    SELECT empno, ename INTO t_emp.empno, t_emp.ename
      FROM emp
     WHERE empno = p_empno;
    IF sql%found THEN
        dbms_output.put_line('<<<조회결과있음>>>');
    END IF;
    IF sql%rowcount = 1 THEN
        dbms_output.put_line('<<<조회결과>>>');
        dbms_output.put_line('사번'||t_emp.empno);
        dbms_output.put_line('성명'||t_emp.ename);
    ELSIF sql%rowcount = 0 THEN
        dbms_output.put_line('<<<에러>>>');
        dbms_output.put_line('<<<조회된 데이터가 없습니다.>>>');
    ELSIF sql%rowcount > 1 THEN
        dbms_output.put_line('<<<에러>>>');
        dbms_output.put_line('<<<조회된 데이터가 너무 많습니다.>>>');
    END IF;
    EXCEPTION
        WHEN others THEN
        dbms_output.put_line('<<<ERROR>>>');
        dbms_output.put_line('에러코드:'||sqlcode);
        dbms_output.put_line('성명:'||t_emp.ename);
END;


exec proc_cursor_attribute(7566);--SELECT INTO 문이 성립되어서 IF문이 작동됨

exec proc_cursor_attribute(300);--SELECT INTO 문이 성립되지않아 바로 오류가 생김

exec proc_cursor_attribute(3000);

exec proc_cursor_attribute(7903);