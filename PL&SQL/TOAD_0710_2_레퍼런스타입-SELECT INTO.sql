DECLARE
    v_name VARCHAR2(20) := '�̼���';
    v_emp emp%rowtype;
BEGIN
    v_emp.ename:='������';
--  �ּ�����Ű : Ctrl+B / �ּ���Ҵ���Ű : Ctrl+shift+B  
--    dbms_output.put_line(v_name);
--    dbms_output.put_line(v_emp.ename);
    SELECT empno, job
      INTO v_emp.empno, v_emp.job
      FROM emp
     WHERE empno = 7566;
      dbms_output.put_line(v_emp.empno||','||v_emp.job);
    --1���� �ο츸�� ��� SELECT INTO�� �Ѱ谡 �ֱ⶧���� CURSOR�� ����� ���̴�
END;