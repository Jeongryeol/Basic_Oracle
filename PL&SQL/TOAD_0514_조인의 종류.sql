�츮�� ���� ���̺��� �츮�� �����ȣ�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.

EDIT ZIPCODE_T

SELECT zipcode, address FROM ZIPCODE_T
 WHERE dong LIKE '%'||'����'||'%'
 
SELECT zipcode, address FROM ZIPCODE_T
 WHERE dong LIKE '%'||'���굿'||'%'
 
SELECT zipcode, address FROM ZIPCODE_T
 WHERE ZDO LIKE '%'||'����'||'%'
   AND dong LIKE '%'||'���ǵ�'||'%'
   


�뿩���� ȸ���� DVD����

SELECT
       ȸ����, �뿩.�뿩����, ��ȭ.����, ��ü.��ü��
  FROM �뿩(1000), ȸ��(300), DVD(20000), ��ȭ(2000), ��ü(105)
 WHERE ȸ��.ȸ����ȣ = �뿩.ȸ����ȣ
   AND DVD.��ȭ�ڵ� = ��ȭ.��ȭ�ڵ�
   AND �뿩.ȸ����ȣ = ��ü.ȸ����ȣ
   AND �뿩.DVD�ڵ� = ��ü.DVD�ڵ�


��������
4�� �뿩 ������ 1������ 10������ ����ϰ��� �Ѵ�.

��°��
���� ��ȭ���� �뿩Ƚ�� ���� �ֿ����

SELECT
       rownum ano as "����"
      ,��ȭ.��ȭ����
      ,COUNT (�뿩.�뿩����) as "�뿩Ƚ��"
      ,��ȭ.�����̸�
      ,��ȭ.�ֿ����
  FROM ��ȭ, DVD, �뿩
 WHERE rownum <= 10
   AND �뿩.�뿩���� BETWEEN '20180401' AND '20180430' -- ��������
 ORDER BY COUNT(�뿩.�뿩����) desc -- �뿩�� ���� ������� ��������
 GROUP BY ano, ��ȭ.��ȭ�̸�, ��ȭ.�ֿ����




JOIN�̶�,
�� ���̺��� ���ϴ� ����� ��� ��ȸ�� �� ���
���� ���̺� ����� �����͸� �� ���� ��ȸ�ϴ� ��츦 ����
 
1) īŸ�þ��� �� ( ������ ���� ) :: ( 14 * 4 = 56 )

SELECT a.name, b,dname
  FROM emp a, dept b

2) equal ���� -  NATURAL JOIN ( PK�� FK�� �����Ͽ� ����ϴ� ���� �Ϲ����� ���)
 
SELECT a.ename, b.name
  FROM emp a, dept b
 WHERE a.deptno = b.deptno

3) non-equal ����


 
4) outer ����
 


5) self  ����

