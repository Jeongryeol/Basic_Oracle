--------------------------------------------------------------------------------

�÷������� �ο췹������ ����ϱ�
�ο췹���� �ִ� �����͸� �÷������� ����ϱ�

--------------------------------------------------------------------------------
View(��)

CREATE VIEW v_dept(deptno,dname)
as
SELECT deptno,dname FROM dept
WHERE deptno >= 30

SELECT deptno,dname FROM dept 

--�߿��� �÷������� ���߾� �����ڿ��� ������ ���� �� �ִ�.
--ex. ����(����)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

���� : �������ڵ带 �����ϱ�

���̺� ����
E:\��¼�\39��_20180417\2. ����Ŭ����\����Ŭ�ǽ��ҽ�\8�� ���� �߰�

��°��
  ��¥        �����ݾ�(�޷�)        ȯ��          ��ȭ�ݾ�
----------------------------------------------------------
20010905          13200            1390        18,348,000
20010906          10800            1310        14,148,000


--[������ǥ]----------------------------------------------------------------------
���̺��� �������� �ʴ� �÷��� ����� �� ����.
�ذ��� : �ζ��κ並 ����ϸ� �ذ��� �� �ִ�.

SELECT rownum rno, dname, loc FROM dept

SELECT rownum rno, dname, loc FROM dept --dept�� ���� rno�� �÷����� ����� �� ����
 WHERE rno < 4
 
SELECT rno, dname, loc
  FROM (SELECT rownum rno, dname, loc FROM dept)
 WHERE rno < 3

���������� �����ͺ��̽��� ���̺��� ������ ��������.
--� ����̵� ���̺� ���� �״�� ����� �������� ���� ����.
  ����ڰ� ���ϴ� ��Ŀ� ���߾� ���̺��� ã�� �����ؾ��Ҷ�, �ζ��κ並 Ȱ���� �� �ִ�.


--[Ǯ��]--------------------------------------------------------------------------
--�⺻��
SELECT *
  FROM (�ζ��κ�1)a, (�ζ��κ�2)b
 WHERE a.ano = b.bno-1

--�ζ��κ�1 : a
SELECT rownum ano, crate FROM test02

--�ζ��κ�2 : b
SELECT rownum bno, cdate, amt FROM test02

--[������]
SELECT b.cdate as "��¥"
      ,'$'||TO_CHAR(b.amt,'999,999') as "�����ݾ�"
      ,a.crate as "ȯ��"
      ,TO_CHAR(a.crate*b.amt,'999,999,999')||'��' as "��ȭ�ݾ�"
  FROM (SELECT rownum ano, crate FROM test02) a
      ,(SELECT rownum bno, cdate, amt FROM test02) b
 WHERE a.ano = b.bno-1

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

�Լ� ������

����Ŭ���� �����Ǵ� �Լ�

SELECT TO_CHAR(sysdate,'yyyy-mm-dd') FROM dual


����� ���� �Լ� = ���ϴ� ���


�Ʒ�������ڡ����ǡ��Լ��¡��ش硡��¥�ǡ�ȯ�������˰��;��ϴ¡���������ڸ������ء�����ڰ��������ѡ��Լ��ӣ�
CREATE OR REPLACE FUNCTION func_yesterdaycrate(pdate vachar2)�����Ķ���ͷΡ���¥�����޾Ƽ���������Ÿ�����Ρ�����
return number��������ȯ���ǡ�Ÿ������
IS
tmpVar number;
BEGIN
    tmpVar :=0;
    SELECT MAX(crate) INTO tmpVar
      FROM test02
     WHERE cdate = (SELECT MAX(cdate) FROM test02 WHERE cdate < pdate);
    return tmpVar;
END��


SELECT func_yesterdaycrate('20010908')
      ,func_yesterdaycrate('20010903')
      ,func_yesterdaycrate('20010905')
  FROM dual
