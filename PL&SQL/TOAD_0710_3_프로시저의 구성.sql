--���ν����� ������Ʈ�� �Ǳ⶧���� ����� ȣ���� ����������, ���뼺���� �̾����� ����ȿ���� ��������.
--@name   proc_ : procedure
--@param  p_ : parameter�� ����
CREATE OR REPLACE PROCEDURE proc_emptest(p_empno IN number)
IS
    --�����
    v_name VARCHAR2(20) := '�̼���';
    v_emp emp%rowtype;
BEGIN
    --���๮
    SELECT empno, job
      INTO v_emp.empno, v_emp.job
      FROM emp
     WHERE empno = p_empno;
      dbms_output.put_line(v_emp.empno||','||v_emp.job);
END;

--�����ϴ� ��� 1 : �⺻
exec proc_emptest(7566)

--�����ϴ� ��� 2 : ����ϴ� ���� (������ ���ν����� �� ���ν����� �ִ°��� �ȵ�����..)
begin
proc_emptest(7369);
end;

