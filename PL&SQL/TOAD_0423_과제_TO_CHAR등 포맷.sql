1.�� �޿��� ������ 18�� ������ Ȧ�� �޿��� ������ 1/18�� ���޵ǰ�, ¦���޿��� ������
2/18�� ���޵ȴٰ� �������� �� Ȧ�� �ް� ¦�� �޿� ���� �ݾ��� ��Ÿ���ÿ�.

SELECT
    EMP_NAME as "����"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18,-4),'99,999,999,999') as "Ȧ����"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18*2,-4),'99,999,999,999') as "¦����" 
     FROM temp 



2.������ ���� �� �޿��� ����� 10������ ���޵ȴٸ�(¦������ 20����)���� ������ 
��� �ٲ��� �ۼ��� ���ÿ�.

SELECT
    EMP_NAME as "����"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18+100000,-4), '99,999,999,999') as "Ȧ����"
   ,'\ '||TO_CHAR(TRUNC(SALARY/18*2+200000,-4),'99,999,999,999') as "¦����" 
     FROM temp 



3.TEMP ���̺��� ��̰� NULL �� �ƴ� ����� ������ �о���ÿ�.

SELECT
    EMP_NAME
   ,HOBBY
    FROM TEMP
   WHERE HOBBY IS NULL

 

4.TEMP ���̺��� ��̰� NULL�� ����� ��� HOBBY�� ���������̶�� ���� ġȯ�Ͽ� 
�������� �������� �״�� ���� �о���ÿ�.

SELECT
    EMP_NAME
   ,NVL(HOBBY,'����')
    FROM TEMP
       
    
  
5.TEMP�� �ڷ� �� HOBBY�� ���� NULL�� ����� ����ꡯ���� ġȯ���� �� HOBBY�� �������
����� ������ �������� ������ �ۼ��Ͻÿ�.

SELECT
    EMP_NAME
   ,NVL(HOBBY,'���')
    FROM TEMP
   WHERE NVL(HOBBY,'���') ='���'
    

 
6.TEMP�� �ڷ� �� EMP_ID�� EMP_NAME�� ���� �������,���������� ǥ�õǾ� DISPLAY�ǵ���
COLUMN ALLIAS�� �ο��Ͽ� SELECT �Ͻÿ�.

SELECT
    EMP_ID as "���"
   ,EMP_NAME as "����"
    FROM TEMP

  
7.����� ��������� ��������ǥ�� ��� �ϳ��� ���ڿ��� �����ִ� ������ ����� ���ÿ�.

SELECT
    EMP_NAME||' '||BIRTH_DATE as "'����� �������'"
    FROM TEMP
 


8.TEMP�� �ڷḦ ���� ��(LEV)�� ASCENDING�ϸ鼭 ��������� �ٽ� ��� ������ 
DESCENDING�ϰ� �ϴ� ORDER BY�ϴ� ������ ����� ���ÿ�.

SELECT
    EMP_NAME as "����"
   ,/*+index_asc(TEMP pk_EMP_ID)*/LEV as "����"
   ,EMP_ID as "���"
    FROM TEMP
    ORDER BY EMP_ID DESC
--TEMP ������ UNIQUE PRIMARY KEY�� ��� ����� �� ����

SELECT
    EMP_NAME as "����"
   ,LEV as "����"
   ,EMP_ID as "���"
    FROM (SELECT * FROM TEMP ORDER BY LEV ASC)
    ORDER BY EMP_ID DESC
    
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



SELECT * FROM temp

SELECT emp_name, salary FROM temp

SELECT 1 as "Ȧ���޿�", 2 as "¦���޿�" FROM dual

SELECT emp_name as "�̸�", salary/18||'��' as "Ȧ���޿�", salary/9||'��' as "¦���޿�" FROM temp

SELECT TO_CHAR(555555555555,'999,999,999,999') FROM dual

SELECT
    emp_name as "�̸�"
   ,TO_CHAR(salary/18,'999,999,999,999')||'��' as "Ȧ���޿�"
   ,TO_CHAR(salary/9,'999,999,999,999')||'��' as "¦���޿�"
    FROM temp
    
SELECT ROUND(123.4567,1), ROUND(123.4567,2), ROUND(123.4567,-2) FROM dual


--**[1������ ������]*********************************************************

SELECT
    emp_name as "�̸�"
   ,TO_CHAR(ROUND(salary/18,-3),'999,999,999,999')||'��' as "Ȧ���޿�"
   ,TO_CHAR(ROUND(salary/9,-3),'999,999,999,999')||'��' as "¦���޿�"
    FROM temp

--***********************************************************************


--**[8������ ������]*********************************************************

SELECT
    emp_name as "�̸�"
   ,lev as "����"
   ,emp_id as "�����ȣ"
    FROM temp
   ORDER BY pos desc, emp_id asc

--***********************************************************************


--SELECT�� FROM �� ���̿� �÷��̳� ����� �߰��ϸ�
--�ο찡 �þ��? \ �÷��� �þ��?

SELECT 1,2,3 FROM dual

SELECT empno, ename, sal FROM emp


--���� �ο츦 ������Ű�� �ʹٸ� �����?

--UNION : �ߺ��� �����ϰ� ���Ľ��� ��ȸ�Ѵ� (�˻��ӵ� ����)

--UNION ALL : �״�� ��ģ��.


SELECT empno, ename, deptno
  FROM emp
 WHERE deptno
    IN(10,30);
UNION ALL

SELECT empno, ename, deptno
  FROM emp
 WHERE deptno
 IN(20,30);
 
 ���� ����
 1)������ : =, IN
 2)�������� : BETWEEN a AND b
            WHERE sal >= 800 AND sal < 3000
            
SELECT empno, ename FROM emp WHERE ename LIKE 'S'||'%' --���������� ����

SELECT empno, ename FROM emp WHERE ename LIKE '%'||'S'||'%' --���������� ����



SELECT seq_vc, words_vc FROM t_letitbe
ORDER BY LPAD(seq_vc,2,0) ASC

SELECT seq_vc, words_vc FROM t_letitbe
ORDER BY RPAD(seq_vc,2,0) ASC

http://ghostwil-program.blogspot.com/2015/12/lpad-rpad.html

SELECT rownum empno, ename FROM emp --����ũ�ϰ� �������

SELECT empno, ename FROM emp