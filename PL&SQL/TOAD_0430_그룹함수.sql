SELECT
        MAX(empno), MAX(sal), MAX(comm)
       ,MIN(empno), MIN(sal), MIN(comm)
    FROM emp
    
SELECT
        MAX(empno), MAX(sal), MAX(comm)
       ,MIN(empno), MIN(sal), MIN(comm)
       ,ename
    FROM emp



�����غ���
�츮ȸ�翡 �ٹ��ϴ� ����� �� �ݿ����� ���� ���� ����� �޿����� ����Ͻÿ�.

SELECT MAX(sal) FROM emp



�츮ȸ�翡 �ٹ��ϴ� ����鿡 ���� �μ��� �޿����� ���� ū �ݾ��� ����ϴ� SQL���� �ۼ��Ͻÿ�.

SELECT distinct(deptno) FROM emp

SELECT ename FROM emp
GROUP BY ename --gruop  by �� ȿ���� �ִ�|����. -> ����

SELECT ename, COUNT(ename) FROM emp--group by�� ������ ����� �� �ִ� �÷��� �������ִ�.�ƴϴ�
GROUP BY ename

SELECT deptno, COUNT(deptno), MAX(sal), MIN(sal), AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000

--�����߻���. ����?
SELECT ename,COUNT(ename) FROM emp--�� group by�� ȿ���� �������� �����ϸ� ������ �߻�����?

SELECT deptno as "�μ���ȣ" ,MAX(sal) as "�޿���"
    FROM emp
    GROUP BY deptno;


SELECT deptno, ename, avg(sal)
    FROM emp
    GROUP BY deptno
--������ �ذ���    
SELECT deptno, count(ename), avg(sal)
    FROM emp
    GROUP BY deptno
    
������̺��� job�� CLERK�� ����� �޿��� ��. SALESMAN�� ����� �޿��� ���� ���ϰ�,
������ job�� ���ؼ��� ��Ÿ ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.

SELECT distinct(job) FROM emp

SELECT
        SUM(DECODE(job,'CLERK',sal)) as "CLERK�޿���"
       ,SUM(DECODE(job,'SALESMAN',sal)) as "SALESMAN�޿���"
       ,SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "��Ÿ�޿���"
    FROM emp
    
    GROUP BY jo

SELECT
        COUNT(DECODE(job,'CLERK',sal)) as "CLERK�ο�"
       ,SUM(DECODE(job,'CLERK',sal)) as "CLERK�޿���"
       ,COUNT(DECODE(job,'SALESMAN',sal)) as "SALESMAN�ο�"
       ,SUM(DECODE(job,'SALESMAN',sal)) as "SALESMAN�޿���"
       ,COUNT(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "��Ÿ�ο�"
       ,SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal))as "��Ÿ�޿���"
    FROM emp