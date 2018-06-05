CREATE OR REPLACE PROCEDURE proc_cursor_attribute(p_empno IN VARCHAR2)
IS
    t_emp emp%rowtype;
    cursor c_emp--Ŀ���߰� �� SELECT���� ���� (INTO ���� ����)
    is
      SELECT empno, ename FROM emp WHERE empno >= p_empno;
BEGIN
    open c_emp;--Ŀ���߰� �� �����
    LOOP
        -- 1. �Ľ�  2. �����ȹ  3. ��Ƽ������ ����   4. ���� Ŀ����ġ  ��ġ(�޸𸮿� �÷���)
        fetch c_emp INTO t_emp.empno, t_emp.ename;
        exit when c_emp%notfound;
        dbms_output.put_line(t_emp.empno||', '||t_emp.ename);
    END LOOP;
    IF c_emp%found THEN
        dbms_output.put_line('<<<��ȸ�������>>>');
    END IF;
    IF c_emp%rowcount = 1 THEN
        dbms_output.put_line('<<<��ȸ���>>>');
        dbms_output.put_line('���'||t_emp.empno);
        dbms_output.put_line('����'||t_emp.ename);
    ELSIF c_emp%rowcount = 0 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �����ϴ�.>>>');
    ELSIF c_emp%rowcount > 1 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �ʹ� �����ϴ�.>>>');
    END IF;
    close c_emp;
    EXCEPTION
        WHEN others THEN
        dbms_output.put_line('<<<ERROR>>>');
        dbms_output.put_line('�����ڵ�:'||sqlcode);
        dbms_output.put_line('����:'||t_emp.ename);
END;


exec proc_cursor_attribute(7566);

exec proc_cursor_attribute(300);--SELECT INTO ���� ���������ʾ� �ٷ� ������ ����

exec proc_cursor_attribute(3000);

exec proc_cursor_attribute(7902);