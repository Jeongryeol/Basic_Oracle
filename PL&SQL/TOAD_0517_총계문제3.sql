--���̺� ���� Ȯ��
EDIT T_ORDERBASKET

--SQL�� �����ۼ�------------------------------------------------------------------
SELECT
    �Ǹų�¥(��,�Ұ�,��ü�հ�)
   ,��ǰ����,��ǰ��
   ,�ǸŰ���( ��),�ǸŰ���( ��)
  FROM t_orderbasket front
      ,(SELECT rownum rno FROM t_orderbasket WHERE rownum<4) back
 GROUP BY �Ǹų�¥(��,�Ұ�,��ü�հ�),��ǰ����,��ǰ��
 ORDER BY �Ǹų�¥(��,�Ұ�,��ü�հ�),��ǰ����,��ǰ��
--------------------------------------------------------------------------------
 
--�Ǹų�¥(��,�Ұ�,��ü�հ�)
DECODE(back.bno,1,indate_vc,2,indate_vc||' ��',3,'�Ұ�',4,'��ü�հ�') AS "�Ǹų�¥"

--��ǰ����
DECODE(back.bno,1,gubun_vc,2,gubun_vc||' ��') AS "��ǰ����"

--��ǰ��
DECODE(back.bno,1,name_vc,null) AS "��ǰ��"

--�ǸŰ���( ��)
--NUMBERŸ���� ��� ����ϴ� DECODE�� �ۼ��ϰ�, �׷��Լ��� SUM�� ������ �� ������ �����Ѵ�.
SUM(DECODE(back.bno,1,qty_nu,3,qty_nu,4,qty_nu))||' ��' AS "�ǸŰ���"

--�ǸŰ���( ��)
--NUMBERŸ���� ��� ����ϴ� DECODE�� �ۼ��ϰ�, �׷��Լ��� SUM�� ������ �� ������ �����Ѵ�.
SUM(DECODE(back.bno,1,qty_nu*price_nu,2,qty_nu*price_nu
                   ,3,qty_nu*price_nu,4,qty_nu*price_nu))||' ��' AS "�ǸŰ���"
      
--------------------------------------------------------------------------------

--SQL�� ���� �� ��ȸ
SELECT
    DECODE(back.bno,1,front.indate_vc,2,front.indate_vc||' ��',3,'��ü�հ�') AS "�Ǹų�¥"
   ,DECODE(back.bno,1,front.gubun_vc,2,front.gubun_vc||' ��') AS "��ǰ����"
   ,DECODE(back.bno,1,front.name_vc) AS "��ǰ�̸�"
   ,SUM(DECODE(back.bno,1,qty_nu,2,qty_nu,3,qty_nu))||' ��' AS "�ǸŰ���"
   ,SUM(DECODE(back.bno,1,qty_nu*price_nu,2,qty_nu*price_nu
                       ,3,qty_nu*price_nu))||' ��' AS "�ǸŰ���"
  FROM t_orderbasket front
      ,(SELECT rownum bno FROM t_orderbasket WHERE rownum<4) back
 GROUP BY DECODE(back.bno,1,front.indate_vc,2,front.indate_vc||' ��',3,'��ü�հ�')
         ,DECODE(back.bno,1,front.gubun_vc,2,front.gubun_vc||' ��')
         ,DECODE(back.bno,1,front.name_vc)
 ORDER BY "�Ǹų�¥","��ǰ����","��ǰ�̸�"