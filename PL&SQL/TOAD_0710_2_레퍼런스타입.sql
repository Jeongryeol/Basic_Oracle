DECLARE
    v_name VARCHAR2(20) := '�̼���';
    v_emp emp%rowtype;
BEGIN
    v_emp.ename:='������';
    dbms_output.put_line(v_name);
    dbms_output.put_line(v_emp.ename);
END;