--������ ���
--UNION, UNION ALL, MINUS, INTERSECT ��
--�� �� �̻��� ���տ��� ����ϴ� �÷��� ���� ��ġ�ؾ��ϰ�, �� Ÿ�Ե� ��ġ�ؾ� �Ѵ�.

UNION�� �̿��ؼ� temp�� tcom�� �ڷ� �� emp_id, salary, comm�� �����ִ� SQL���� �ۼ��Ͻÿ�
�� �� salary�� comm�� ��� �����ϴ� ����� ���ٷ� ���;� �Ѵ�.

edit temp

edit tcom

SELECT emp_id, salary, 0 comm FROM temp
UNION
SELECT emp_id, 0 salary, comm FROM tcom

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp

SELECT deptno FROM dept
INTERSECT
SELECT deptno FROM emp

--�÷����� Ÿ���� ���ƾ� ������������ �����ϴ�.

--3�� 001 table �߰��Ͽ� ���Ի�� �����͸� �߰�, 20��¥�� temp ���̺�� �������.

SELECT * FROM temp

SELECT emp_name, hobby FROM temp
ORDER BY hobby ASC; --�������� : ������ ������ ���� �� NULL(�𸥴�) �� ������.

SELECT emp_name, hobby FROM temp
ORDER BY hobby DESC; --�������� : NULL(�𸥴�)���� ������ ������ ������. ��?

NULL�� �𸥴� �̹Ƿ� �������� ���Ľ� �� �ڿ� �� �� �ۿ� ����.
�������� ������ ��� ���������� �ݴ��̹Ƿ� ��̰� NULL�� �͵��� �� �տ� ���� ����. (�ܼ��� ���)

---------------------------------------------------------------------------------

--�������� �⺻��
SELECT
  FROM ����
 WHERE �÷��� = (SELECT��) --��������

--�ζ��κ� �⺻��
SELECT
  FROM (SELECT��) --�ζ��κ�

���������� �ζ��κ��� ������ : SELECT���� 2�� �̻��̴�.

��������1
SMITH������� �޿��� ���� ������� �����ȣ, �����, JOB�� ����ϴ� SQL���� �ۼ��Ͻÿ�.

SELECT empno as "�����ȣ", ename as "�����", JOB FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH') 

SELECT empno as "�����ȣ", ename as "�����", JOB FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename=:x)
 --�����׽�Ʈ ó����� (�����ڸ��� ���� ���� �޼ҵ��� �Ķ���ͷ� �����ȴ� ) 


��������2
temp���� ������ ���� ���� ������ row�� ã�Ƽ�
�� �ݾװ� ������ �ݾ��� �޴� ����� ����� ����, ������ ����Ͻÿ�

SELECT emp_id as "���", emp_name as "����", salary as "����" FROM temp
 WHERE salary = (SELECT MAX(salary) FROM temp WHERE lev = '���')

SELECT emp_id, emp_name, salary FROM temp
 WHERE 1=1 --SQL�� ����
   AND salary = (select max(salary) FROM temp)

SELECT mem_name FROM member
 WHERE mem_id='test1'
   AND mem_pw='1234'
    OR 1=1 --�̷� ���̾��� ���� ������ ����Ǵ� ������ ��â�⿡ �־���.

��������3
temp�� �ڷḦ �̿��Ͽ� salary�� ����� ���ϰ�
�̺��� ū �ݾ��� salary�� �޴� ������ ����� ����, ������ �����ִ� SQL���� �ۼ��Ͻÿ�.

SELECT emp_id as "���", emp_name as "����", salary as "����" FROM temp
 WHERE salary > (SELECT AVG(salary) FROM temp)

  
---------------------------------------------------------------------------------

��������1
temp�� ���� �� ��õ�� �ٹ��ϴ� ������ ����� ������ �о���� SQL���� �ۼ��Ͻÿ�

SELECT te.emp_id as "���", te.emp_name as "����", td.area as "�ٹ�����", td.dept_code as "�μ��ڵ�"
  FROM temp te, tdept td
 WHERE td.area = '��õ'
    AND te.dept_code = td.dept_code

--IN ������ �˰��ֳ���?
SELECT empno, ename FROM emp WHERE deptno IN(10,30)

--������������ ���� SELECT�� �ۼ��غ���
SELECT dept_code FROM tdept WHERE area='��õ'

--�������� ���� SELECT�� �ۼ��غ���
SELECT emp_id, emp_name FROM temp

--������
SELECT emp_id, emp_name
  FROM temp
 WHERE dept_code IN(SELECT dept_code FROM tdept WHERE area='��õ')

--���ǻ���
--������������ ���� �÷����� �ٱ��� ������ SELECT�������� ����� �Ұ�����.
--FROM���� ����� ���̺���� ����� �� ������, ���� �÷����� ����� �Ұ����ϴ�.

--�ζ��κ信�� ������� ���� �÷��� ������������ ������� ���� �÷��� ���������� ����� �� ����.
--����, ���̺� �����ϴ��� �ζ��κ信�� ������� ���� �÷��� ���������� ����� �� ����.


��������2
tcom�� ���� �ܿ� Ŀ�̼��� �޴� ������ ����� �����Ǿ� �ִ�.
�� ������ �̿��Ͽ� �μ���Ī���� Ŀ�̼��� �޴� �ο����� ���� ������ �ϼ��غ��ÿ�.

SELECT dept_code, COUNT(tcom.comm) FROM tcom, temp
 WHERE temp.emp_id = tcom.emp_id
 GROUP BY dept_code

--Ŀ�̼��� �޴� ������ ��� ���ϱ�
SELECT emp_id FROM tcom

SELECT COUNT(emp_id) FROM temp
 WHERE emp_id IN(SELECT emp_id FROM tcom)
 GROUP BY dept_code 

SELECT dept_name, count(emp_id)
  FROM temp, tdept
 WHERE temp.emp_id IN(SELECT emp_id FROM tcom)
   AND temp.dept_code = tdept.dept_code
 GROUP BY dept_name 

-------------------------------------------------------------------------------

��������1
tdept���� �μ��ڵ�� boss_id�� �о --�μ����� �����ȣ
�� �� �� �÷��� temp�� �μ��ڵ�� ����� ��ġ�ϴ� �����
����� ������ �о���� �������� �ۼ��Ͻÿ�

SELECT emp_id as "���", emp_name as "����"
  FROM temp
 WHERE emp_id IN (SELECT boss_id FROM tdept)
   AND dept_code IN (SELECT dept_code FROM tdept)

--��������
SELECT dept_code, boss_id FROM tdept

--������
SELECT emp_id, emp_name FROM temp

--�����غ���
SELECT
       emp_id, emp_name
  FROM temp
 WHERE (dept_code, emp_id) IN (SELECT dept_code, boss_id FROM tdept) --��ġ�ϴ�! �̶�� �����Ƿ� IN����!!
 
 

��������2
temp���� �μ��� �ְ� �����ݾ��� �о --��������
�ش� �μ��� �ְ� �����ݾ��� ���ÿ� ��ġ�ϴ� --�� �÷��� �񱳴��(���������� ������)
����� ���, ����, ������ --SELECT ���
����ϴ� �������� �ۼ��Ͻÿ�

--�������� �⺻��
SELECT dept_code, max(salary)
  FROM temp -- temp����!!
 GROUP BY dept_code --�μ���!!

--������ �⺻��
SELECT emp_id as "���", emp_name as "����", salary as "����"
  FROM temp
 WHERE ( , ) IN ( �������� )
 
--��������!!
SELECT emp_id as "���", emp_name as "����", salary as "����"
  FROM temp
 WHERE (dept_code, salary) IN ( SELECT dept_code, max(salary)
                                  FROM temp
                                 GROUP BY dept_code )
                                 



