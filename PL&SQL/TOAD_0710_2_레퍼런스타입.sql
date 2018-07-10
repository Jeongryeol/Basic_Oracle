DECLARE
    v_name VARCHAR2(20) := '이순신';
    v_emp emp%rowtype;
BEGIN
    v_emp.ename:='강감찬';
    dbms_output.put_line(v_name);
    dbms_output.put_line(v_emp.ename);
END;