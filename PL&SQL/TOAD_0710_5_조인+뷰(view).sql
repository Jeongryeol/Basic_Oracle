--���ν����� VIEW ����� ������ ���� ����
CREATE OR REPLACE VIEW v_emp
as
SELECT
    emp.empno, emp.job, dept.dname
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
 

--VIEW�� �ο��� �������� ��ȸ�ϴ� ����
SELECT * FROM v_emp