SELECT ename FROM emp WHERE empno='7566'--Oracle���� �ڵ�����ȯ ����

--�÷��� ���ο� �� �Է��ϱ�
--(JAVA �� ����Ŭ ��Ʈ���ϴ� ������ �����ϱ����� �����ϴ� ����)
INSERT INTO dept(deptno,dname,loc) VALUES(50,'�λ�','����');

--commit�Ǳ� ������ �ԷµǴ°��� �ƴ�. ����, PK������  ���Ἲ ������ �߻���

--����ó���ϸ� ��� �ǳ�? (����ڰ� �Է��ϴ� �ڸ��� ��)
INSERT INTO dept(deptno,dname,loc) VALUES(:x,:y,:z);



--JAVA���� �Է��ϵ��� �ϴ� �޼ҵ带 �ۼ��ϱ� ����, ��� ����Ǵ����� ����
--commit�����ʰ�, JAVA���� ������Ѽ� ���� �Է��غ��� ���� INSERT �������ؿ� SQL
INSERT INTO emp(empno,ename,job, mgr, hiredate, sal, comm, deptno)
       VALUES(9000,'�̼���','SALESMAN',7566,'2018-04-21',3300,0,50);

rollback;


--JAVA���� �Է��ϵ��� �ϴ� �޼ҵ带 �ۼ��ϱ� ����, ��� ����Ǵ����� ����
--commit�����ʰ�, JAVA���� ������Ѽ� ���� �Է��غ��� ���� UPDATE �������ؿ� SQL
UPDATE emp
   SET ename    = '������'
      ,job      = 'CLERK'
      ,hiredate = '2018-05-03'
 WHERE empno=9000
 
rollback;


--JAVA���� �Է��ϵ��� �ϴ� �޼ҵ带 �ۼ��ϱ� ����, ��� ����Ǵ����� ����
--commit�����ʰ�, JAVA���� ������Ѽ� ���� �Է��غ��� ���� DELETE �������ؿ� SQL
--DELETE�� rowlevel�� ����� ����� ( �ݵ�� WHERE���� �ʿ��� / �ƴϸ� �� ���̺� ��°�� ���ư� )
DELETE FROM emp
 WHERE empno=9000

rollback;


--JAVA���� �Է��ϵ��� �ϴ� �޼ҵ带 �ۼ��ϱ� ����, ��� ����Ǵ����� ����
-- JAVA���� ������Ѽ� ���� �Է��غ��� ���� SELECT �������ؿ� SQL
SELECT empno,ename,job,deptno FROM emp
 WHERE empno >=7700