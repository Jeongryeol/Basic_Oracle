SELECT ename as "�����"
      ,sal �޿�
      ,sal "�� ��"
--    ,sal ��     ��
  FROM EMP
  
�� AS�� �� �Ͱ� ���� ���� ���� ���� : �ζ��κ� ����, �÷��� ��밡�� ���ο� ���� ����


SELECT rownum rno FROM emp
 WHERE rno < 3 --�����߻�
 
SELECT rownum rno FROM emp
 WHERE rownum < 3 --�۵�
 
 --�ζ��κ�� ���������� ����� ��Ī��
 --������(���� ��µǾ� ������ SELECT)���� ����� �� �ִ�. 

SELECT rno,ename FROM (SELECT rownum rno,ename FROM emp)
 WHERE rno < 3

SELECT rno, �̸�  FROM (SELECT rownum rno,ename as "�̸�" FROM emp)
 WHERE �̸� = 'SMITH'
 
SELECT ename as "�̸�",  TO_CHAR(hiredate,'YYYY-MM-DD') as "�������"  FROM EMP
 WHERE ename = 'SMITH'




