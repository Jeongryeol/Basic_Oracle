CREATE OR REPLACE PROCEDURE proc_test3(tmp IN varchar2)
IS
    v_dept dept%rowtype; --v_dept ��� ������ ������ dept�÷������� ������ �� �ִ�.
BEGIN
    SELECT deptno, dname, loc INTO v_dept.deptno, v_dept.dname, v_dept.loc
      FROM dept --������� SELECT���� 1���ۿ� ��ȸ�� �� ���� ������
     WHERE deptno = 10; --������ �ɾ��־�� �Ѵ�.
   dbms_output.put_line(v_dept.deptno||','||v_dept.dname||','||v_dept.loc);
END;