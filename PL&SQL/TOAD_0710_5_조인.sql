--�⺻���α���
SELECT
    emp.empno, emp.job, dept.dname --�μ���ȣ�� �ƴ϶� �μ����� ���̹Ƿ� ������ (��������� ��ȣ)
  FROM emp, dept
 WHERE emp.deptno = dept.deptno --equal join : ���ʿ� ���� ���� ������ ��ȸ�Ǵ� ����