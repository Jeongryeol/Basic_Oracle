--�츮ȸ�翡 �ٹ��ϴ� ����� �߿��� ����� 7499�� �����
--�ٹ��ϴ� �μ����� �˰� �ʹ�. �����?

--dname�� emp�� ���� �÷��̹Ƿ� ����� �� �����.
--dname�� dept�� �ִ� �÷��̹Ƿ� FK�� deptno�� ���� ã�����.

SELECT
        deptno as "�μ���ȣ"
   FROM emp
  WHERE empno = 7499

--ã�Ƴ� deptno�� �������� dept�� �ִ� dname �÷��� ã�����.

SELECT
        dname as "�μ���"
   FROM dept
  WHERE deptno = 30
 
-- :x �� �����صθ� ������ ��  ���ǰ��� �Է��� �� �ִ�. 
--�ѹ濡 ó���ϰ� �;��. ( �����ȹ�� �� ���� ����)

SELECT
        dept.deptno as "�μ���ȣ", dname as "�μ���",
   FROM emp. dept
  WHERE emp.empno = 7499
    AND dept.deptno = 30 
 

SELECT * FROM emp, dept

SELECT * FROM member

--14���� ��������� 4���� �μ��� ���� ����Ǿ� N ��N�� ���������� �Ͼ��, 14x4�� ����� 56���� ����
--�׷��� �츮�� �ʿ��� ������ 56���� �ƴ� Ư�� 1���� �����




--ȸ����ȣ�� 7500 �̻��� �е��� ���Ͻô� ������ ������ ã������.

SELECT
        emp. empno as "�����ȣ"
       ,emp. ename as "�����"
      ,dept. loc as "����"
   from emp, dept
  where empno >= 7500 