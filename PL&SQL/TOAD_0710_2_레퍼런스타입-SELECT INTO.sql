DECLARE
    v_name VARCHAR2(20) := '이순신';
    v_emp emp%rowtype;
BEGIN
    v_emp.ename:='강감찬';
--  주석단축키 : Ctrl+B / 주석취소단축키 : Ctrl+shift+B  
--    dbms_output.put_line(v_name);
--    dbms_output.put_line(v_emp.ename);
    SELECT empno, job
      INTO v_emp.empno, v_emp.job
      FROM emp
     WHERE empno = 7566;
      dbms_output.put_line(v_emp.empno||','||v_emp.job);
    --1개의 로우만을 담는 SELECT INTO는 한계가 있기때문에 CURSOR를 사용할 것이다
END;