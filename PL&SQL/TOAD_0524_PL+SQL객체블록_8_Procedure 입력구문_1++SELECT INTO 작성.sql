CREATE OR REPLACE PROCEDURE proc_cursor_attribute(p_empno IN VARCHAR2)
IS
    t_emp emp%rowtype;
BEGIN
    SELECT empno, ename INTO t_emp.empno, t_emp.ename
      FROM emp
     WHERE empno = p_empno;
    IF sql%found THEN
        dbms_output.put_line('<<<��ȸ�������>>>');
    END IF;
    IF sql%rowcount = 1 THEN
        dbms_output.put_line('<<<��ȸ���>>>');
        dbms_output.put_line('���'||t_emp.empno);
        dbms_output.put_line('����'||t_emp.ename);
    ELSIF sql%rowcount = 0 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �����ϴ�.>>>');
    ELSIF sql%rowcount > 1 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �ʹ� �����ϴ�.>>>');
    END IF;
    EXCEPTION
        WHEN others THEN
        dbms_output.put_line('<<<ERROR>>>');
        dbms_output.put_line('�����ڵ�:'||sqlcode);
        dbms_output.put_line('����:'||t_emp.ename);
END;


exec proc_cursor_attribute(7566);--SELECT INTO ���� �����Ǿ IF���� �۵���

exec proc_cursor_attribute(300);--SELECT INTO ���� ���������ʾ� �ٷ� ������ ����

exec proc_cursor_attribute(3000);

exec proc_cursor_attribute(7903);