/*  [������Ȳ]
    �츮 ȸ�翡�� �ٹ��ϴ� ����� �߿���
    �μ�Ƽ�긦 �޴� ������� �����ȣ, �����, �μ�Ƽ��ݾ���
    �μ�Ƽ��ݾ� ���� ������������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.
*/

--SQL�� �����ۼ�
SELECT empno AS "�����ȣ",ename AS "�����",LPAD(comm||' $',12) AS "�μ�Ƽ��ݾ�"
  FROM emp WHERE comm > 0 ORDER BY comm desc;
 
--���ν��� �⺻�� �ۼ�
CREATE OR REPLACE PROCEDURE proc_empList(p_text IN VARCHAR2)
IS
    --�����
    v_emp emp%rowtype;--���̺��� ��ȸ����� ���� �ڸ� ���� (���� ����)
    --Ŀ�������ϱ�
    CURSOR cur_emp IS
        SELECT empno,ename,comm--���ν����� �˸��ƽ����� ����ϸ� �ν����� ���ϴ±���...
          FROM emp WHERE comm > 0 ORDER BY comm desc;
BEGIN
    --�����
    dbms_output.put_line('���   �̸�    �μ�Ƽ��');
    dbms_output.put_line('--------------------');
    OPEN cur_emp;
    LOOP
        FETCH cur_emp INTO v_emp.empno, v_emp.ename, v_emp.comm;
        EXIT WHEN cur_emp%NOTFOUND;--��� �������� ����
        dbms_output.put_line(v_emp.empno||', '||v_emp.ename||', '||v_emp.comm);
    END LOOP;
    CLOSE cur_emp;
END;

--���ν��� �׽�Ʈ
exec proc_empList('test');


--������
CREATE OR REPLACE PROCEDURE proc_empList2(temp IN VARCHAR2)
IS
    v_emp emp%rowtype;--���̺��� ��ȸ����� ���� �ڸ� ���� (���� ����)
    CURSOR cur_emp IS--Ŀ������
    SELECT empno, ename, comm FROM emp
     WHERE comm IS NOT NULL AND comm > 0
     ORDER BY comm desc;--Ŀ���� ���� ����
BEGIN
    dbms_output.put_Line('���     �̸�     �μ�Ƽ��');
    dbms_output.put_Line('------------------');
    --�ڵ����� Ŀ���� ���� �ݴ� ��� ����FOR��
    --FOR ���� IN Ŀ�� LOOP (�ݱ����ǹ�;�ݺ����๮;) END LOOP;
    FOR v_emp IN cur_emp LOOP
        dbms_output.put_Line(v_emp.empno||'  '||v_emp.ename||'   '||v_emp.comm);
    END LOOP;
END;

--������ ���ν��� �׽�Ʈ
exec proc_empList2('test');