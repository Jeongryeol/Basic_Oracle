[ �Ѱ� ���� 2ź ]

�Ұ�� �Ѱ� 1ź ���������� � ��ǰ�� ��ŭ �Ǹ� �Ǿ����� �˼��� ��� �Ǹŵ� ��ǰ�� ���� 
�ֹ��� �� �� ����.
���� ������ ��¥�� �Ǹűݾװ� �Ѱ谡 �ƴ� ��ǰ�� ���� �Ǹ� ��Ȳ �ڷḦ ���� �� �� �ֵ��� 
��ǰ���к��� ������Ȳ�� ���� �� �� �ֵ��� sql���� �ۼ��Ͻÿ�.

Edit t_orderbasket

SELECT
        indate_vc   as "�Ǹ�����"
       ,gubun_vc     as "��ǰ��"
       ,qty_nu      as "�Ǹż���"
       ,price_nu    as "�ܰ�"
       ,(qty_nu*price_nu) as "�����"
  FROM T_ORDERBASKET
 ORDER BY indate_vc
 
 
SELECT
        oda.indate_vc   as "�Ǹ�����"
       ,oda.gubun_vc     as "���и�"
       ,oda.name_vc      as "��ǰ��"
       ,SUM(oda.qty_nu) as "�Ǹż���"
       ,odb.price_nu    as "�ܰ�"
       ,SUM(oda.qty_nu*odb.price_nu) as "�����"
  FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
      ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
 WHERE  ano = bno
 GROUP BY oda.indate_vc, oda.gubun_vc, name_vc, odb.price_nu, oda.qty_nu 
 ORDER BY oda.indate_vc
 
SELECT
    �Ǹ�����, ���и�, ��ǰ��, SUM(�Ǹż���) as "�� �Ǹż���", �ܰ�, SUM(�����) as "�����"
  FROM(SELECT
        oda.indate_vc   as "�Ǹ�����"
       ,oda.gubun_vc     as "���и�"
       ,oda.name_vc      as "��ǰ��"
       ,SUM(oda.qty_nu) as "�Ǹż���"
       ,odb.price_nu    as "�ܰ�"
       ,SUM(oda.qty_nu*odb.price_nu) as "�����"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
      WHERE  ano = bno
     GROUP BY oda.indate_vc, oda.gubun_vc, oda.name_vc, odb.price_nu, oda.qty_nu 
     ORDER BY oda.indate_vc)
 GROUP BY �Ǹ�����, ���и�, ��ǰ��, �ܰ� 
 ORDER BY �Ǹ�����     

--��¥�� �� ��ǰ�� �ǸżҰ� �� ��ǰ�� �Ұ� �ۼ�
SELECT
    �Ǹ�����, ���и�, SUM(�Ǹż���) as "�� �Ǹż���", �ܰ�, SUM(�����) as "�����"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�')   as "�Ǹ�����"
       ,oda.gubun_vc     as "���и�"
       ,oda.name_vc      as "��ǰ��"
       ,SUM(oda.qty_nu) as "�Ǹż���"
       ,oda.price_nu    as "�ܰ�"
       ,SUM(oda.qty_nu*oda.price_nu) as "�����"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'), oda.gubun_vc, oda.name_vc, oda.price_nu, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'))
 GROUP BY �Ǹ�����, ���и�, ��ǰ��, �ܰ� 
 ORDER BY �Ǹ�����

--��ü�հ� ��ȸ
SELECT
      DECODE(dno,1,'��ü�հ�') as "�Ǹ�����"
     ,null as "��ǰ��"
     ,SUM(qty_nu) as "�� �Ǹż���"
     ,null as "�ܰ�"
     ,SUM(qty_nu*price_nu) as "�����"
  FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'��ü�հ�')
 
 
--union
SELECT
    �Ǹ�����, ��ǰ��, SUM(�Ǹż���) as "�� �Ǹż���", �ܰ�, SUM(�����) as "�����"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�')   as "�Ǹ�����"
       ,oda.name_vc     as "��ǰ��"
       ,SUM(oda.qty_nu) as "�Ǹż���"
       ,odb.price_nu    as "�ܰ�"
       ,SUM(oda.qty_nu*odb.price_nu) as "�����"
       FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum bno, price_nu FROM T_ORDERBASKET) odb
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
      WHERE  ano = bno
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'), oda.name_vc, odb.price_nu, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'))
 GROUP BY �Ǹ�����, ��ǰ��, �ܰ� 
union
SELECT
      DECODE(dno,1,'��ü�հ�') as "�Ǹ�����"
     ,null as "��ǰ��"
     ,SUM(qty_nu) as "�� �Ǹż���"
     ,null as "�ܰ�"
     ,SUM(qty_nu*price_nu) as "�����"
  FROM (SELECT rownum ano, indate_vc, name_vc, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'��ü�հ�')
ORDER BY �Ǹ����� 
 
 
--�������θ� ��� ��� �� ���ο� ���
SELECT
    �Ǹ�����, ���и�, SUM(�Ǹż���) as "�� �Ǹż���", SUM(�����) as "�����"
  FROM(SELECT
        DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�')   as "�Ǹ�����"
       ,oda.gubun_vc     as "���и�"
       ,SUM(oda.qty_nu) as "�Ǹż���"
       ,SUM(oda.qty_nu*oda.price_nu) as "�����"
       FROM (SELECT rownum ano, indate_vc, gubun_vc, qty_nu,price_nu FROM T_ORDERBASKET) oda
           ,(SELECT rownum cno FROM dept WHERE rownum < 3) odc
     GROUP BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'), oda.gubun_vc, oda.qty_nu 
     ORDER BY DECODE(odc.cno,1,oda.indate_vc,2,'�Ұ�'))
 GROUP BY �Ǹ�����, ���и�
union
SELECT
      DECODE(dno,1,'��ü�հ�') as "�Ǹ�����"
     ,null as "���и�"
     ,SUM(qty_nu) as "�� �Ǹż���"
     ,SUM(qty_nu*price_nu) as "�����"
  FROM (SELECT rownum ano, qty_nu, price_nu FROM T_ORDERBASKET)
      ,(SELECT rownum dno FROM dept WHERE rownum < 2)
 GROUP BY DECODE(dno,1,'��ü�հ�')
ORDER BY �Ǹ�����




--������ ���
SELECT 
    DECODE(back.rno,1,front.indate_vc,2,'�Ұ�',3,'�Ѱ�') AS "�Ǹų�¥"
   ,DECODE(back.rno,1,front.gubun_vc,2,'��-'||front.gubun_vc,3,'') AS "��ǰ����"
   ,SUM(DECODE(front.gubun_vc,'������',qty_nu,'���ڷ�',qty_nu
                             ,'û����',qty_nu,'���',qty_nu
                             ,'����',qty_nu))||'��' AS "�ǸŰ���"
   ,SUM(DECODE(front.gubun_vc,'������',price_nu*qty_nu,'���ڷ�',price_nu*qty_nu
                             ,'û����',price_nu*qty_nu,'���',price_nu*qty_nu
                             ,'����',price_nu*qty_nu))||'��'AS "�ǸŰ���"
  FROM T_ORDERBASKET front
      ,(SELECT rownum rno FROM T_ORDERBASKET WHERE rownum < 4) back
 GROUP BY DECODE(back.rno,1,front.indate_vc,2,'�Ұ�',3,'�Ѱ�')
         ,DECODE(back.rno,1,front.gubun_vc,2,'��-'||front.gubun_vc,3,'')
 ORDER BY "�Ǹų�¥" ASC
 
 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------     ��      ��       ��       ��      -------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

��¥��.... �Ұ�,,,,, �Ѱ�,,,,,

1) �����͸� 3����� �����ϱ� - īŸ�þ��� ��

SELECT
    *
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
--162�� �÷� ��ȸ
      

2)���ǰ��� ���� ��ȯ���� �����Ͽ� ��¥�� �Ұ�, �Ѱ踦 ���̵��� ��ȸ����� ������

SELECT
    DECODE(b.rno,1,a.indate_vc,2,'�Ұ�',3,'�Ѱ�')
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
      

3)��ǰ���� �Ұ谡 ���;��ϰ�, �� �Ұ�� �Ѱ���� �ѹ����� ���������� - GROUP BY

SELECT
    DECODE(b.rno,1,a.indate_vc,2,'�Ұ�',3,'�Ѱ�') AS "�Ǹų�¥"
   ,DECODE(b.rno,1,a.gubun_vc,2,a.gubun_vc||'-��') AS "����"
   ,DECODE(b.rno,1,name_vc) AS "��ǰ��"
   ,SUM(qty_nu)||' ��' AS "�ǸŰ���"
   ,SUM(a.qty_nu*a.price_nu)||' ��' AS "�ǸŰ���"
  FROM t_orderbasket a
      ,(SELECT rownum rno FROM dept WHERE rownum<4) b
 GROUP BY DECODE(b.rno,1,a.indate_vc,2,'�Ұ�',3,'�Ѱ�')
      ,DECODE(b.rno,1,a.gubun_vc,2,a.gubun_vc||'-��') --GROUP�Լ��� �ƴ� ��� �÷����� ����ؾ� ��
      ,DECODE(b.rno,1,name_vc)
 ORDER BY "�Ǹų�¥"
 
 
 
SELECT indate_vc AS "�Ǹų�¥"
     , gubun_vc AS "����"
     , sum(qty_nu*price_nu) "�Ǹűݾ�"
  FROM t_orderbasket
GROUP BY ROLLUP(indate_vc,gubun_vc)