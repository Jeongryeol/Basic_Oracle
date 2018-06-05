--Procedure ���� ����
CREATE OR REPLACE PROCEDURE proc_test1
(v_name IN VARCHAR2, msg OUT VARCHAR2)
--msg OUT Ÿ��: Procedure ��ü������ ������� �ڹٿ��� �޴� �����
IS
BEGIN
    dbms_output.put_line('�̸�'||v_name);
    msg:='�����'||v_name;
END;

--------------------------------------------------------------------------------
--cmd ���� Procedure OUT Ȯ���ϱ�
--Toad ����
sqlpuls scott/tiger

SQL> variable msg varchar2(100);  --���� msg ����
SQL> exec proc_test1('������',:msg);--���� msg ȣ�� ( :�����̸� )

--PL/SQL ó���� ���������� �Ϸ�Ǿ����ϴ�.

SQL> print msg;                   --���� ��� ����

MSG
--------------------
����������

SQL>
--------------------------------------------------------------------------------


--�ǽ�����
CREATE OR REPLACE PROCEDURE proc_test1_p
(v_name IN VARCHAR2,v_date IN VARCHAR2
,msg OUT VARCHAR2,hiredate OUT VARCHAR2)
IS
BEGIN
    dbms_output.put_line('�̸� : '||v_name);
    msg:='����� : '||v_name;
    dbms_output.put_line('���� : '||v_date);
    hiredate:='������� : '||v_date;
END;




CREATE OR REPLACE PROCEDURE proc_test2
(pempno IN number, oename OUT varchar2)
IS
    v_ename varchar2(30);
BEGIN --BEGIN~END ������ SELECT ���� �ѹ��� �Ѱ��� ��ȸ���� / CURSOR?�� ����ؼ� ������ȸ �ؾ��Ѵٰ� ��.
    SELECT ename INTO v_ename --������ �����Ҷ� INTO ���
      FROM emp
     WHERE empno = pempno;
     oename := v_ename;
END;