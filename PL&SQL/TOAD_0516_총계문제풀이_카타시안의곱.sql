[ �Ѱ� ���� 1ź ]

���� t_orderbasket ���̺��� �м��� �Լ��� ������� �ʰ�
�� ��¥���� �� �� ���� ������ �󸶸�ŭ �ȷ����� ������� ��� �Ǵ��� �˰� �ʹ�.
��� �Ұ�� �հ踦 ���� ���ΰ�?

SELECT
        *
  FROM T_ORDERBASKET



2������� - īŸ�þ��� �� - �Ұ踦 ���ϰų� �Ѱ踦 ���Ҷ�
�� ���� �����Լ��� ������ �ʿ����.


--1
SELECT indate_vc, qty_nu, price_nu FROM T_ORDERBASKET


--2
SELECT indate_vc, qty_nu, price_nu
  FROM T_ORDERBASKET
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 )

      
--3
SELECT DECODE(tmp.rno,1,bas.indate_vc,2,'�Ѱ�')
  FROM T_ORDERBASKET bas
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 ) tmp
 GROUP BY DECODE(tmp.rno,1,bas.indate_vc,2,'�Ѱ�')
--COUNT�Լ��� �ο��� �����̱⶧����, �÷��� �������� DATA�� ���������ϹǷ� SUM�Լ��� ����Ѵ�.
--GROUP�Լ��� ����� �Բ� ����� �� ������, �����Լ��ʹ� �Բ� ����� �� ����. �׷��Լ��� �����־�� �Ѵ�.
 

--4
SELECT DECODE(tmp.rno,1,bas.indate_vc,2,'�Ѱ�') as "�Ǹ�����"
      ,SUM(qty_nu) as "�ǸŰ���"
      ,SUM(qty_nu*price_nu) as "�Ǹž�"
  FROM T_ORDERBASKET bas
      ,(SELECT rownum rno FROM dept WHERE rownum < 3 ) tmp
 GROUP BY DECODE(tmp.rno,1,bas.indate_vc,2,'�Ѱ�')
 ORDER BY DECODE(tmp.rno,1,bas.indate_vc,2,'�Ѱ�')
--GROUP BY �� ORDER BY �� �뵵 ����
--īŸ�þ��� ���� Ȱ��� �� �ִ� ���
--decode�� from���� �����ϰ� ��� ����� �� �ִ�.