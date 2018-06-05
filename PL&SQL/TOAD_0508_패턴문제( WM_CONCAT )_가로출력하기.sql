--------------------------------------------------------------------------------                                 

���Ϲ���

SELECT name_vc, MIN(quantity_nu)||','||MAX(quantity_nu) as "value"
  FROM t_giftorder WHERE MOD(num_nu,2)=1 GROUP BY name_vc
UNION all
SELECT name_vc, MIN(quantity_nu)||','||MAX(quantity_nu) as "value"
  FROM t_giftorder WHERE MOD(num_nu,2)=0 GROUP BY name_vc

--------------------------------------------------------------------------------

select NAME_VC,WM_CONCAT(QUANTITY_NU)as "VALUE"
  from T_GIFTORDER
  group by NAME_VC

Oracle 10g������ ���������� ������������
http://denodo1.tistory.com/266


--[����Ǯ��]----------------------------------------------------------------------

SELECT * FROM t_giftorder

--������ �ִ� ���̺� ������ ����õ�
--������ ������ �ֵ��� �ٿ��� ����ϰ�
--������ ���� �ϱ� ���� ����1�� ����2�� �ΰ� �����Ѵ�.
SELECT name_vc, quantity_nu q1, quantity_nu q2 FROM t_giftorder
 ORDER BY name_vc --�Ǵ㳢�� ��ũ�ν����� ��Ƽ� ������

--�� SQL���� �ζ��κ�� �ΰ� ��(����� �ϴ�,������)���� rownum�� ���� �ڿ� 2�� ����� ���� 0�� 1�� ��µǵ���
DECODE()
MOD(rownum,2),0�϶� q1�� �������,  1�϶� q2�� �������...
DECODE���̿��� ||','||

SELECT
    name_vc
   ,DECODE ( MOD(rownum,2),1,q1 )--
   ,DECODE ( MOD(rownum,2),0,q2 )
   ,DECODE ( MOD(rownum,2),1,q1 )||','||DECODE ( MOD(rownum,2),0,q2 )
   --rownum���� row�� ��ȣ�� �ο��ϰ�, �� ��ȣ�� MOD�Ͽ� DECODE�� ����� ������ 
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--�ζ��κ�
  
--���� �͵��� �ϳ��� �����ϱ� : GROUP BY
--�׷���, �׷��Լ��� �Բ� �Ϲ��Լ��� ����� �� ���⶧����, DECODE�� ���� ���������߻�
SELECT
    name_vc
   ,DECODE ( MOD(rownum,2),1,q1 )||','||DECODE ( MOD(rownum,2),0,q2 )
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--�ζ��κ�
 GROUP BY name_vc
 
--������ ���� ����ְ�, �ٽ� NULL�� �͸� �ݺ��Ǵ� DECODE ���ǽ��� ����� �ݿ��Ͽ� �����Լ� MIN()�� �����ص� �����ϴ�.
--�̶�, ¦���� Ȧ�� ������ �¾ұ� ������ ���밡���ߴ� ����.
SELECT
    name_vc
   ,MIN ( DECODE ( MOD(rownum,2),1,q1 ) )||','||MIN ( DECODE ( MOD(rownum,2),0,q2 ) ) as "VALUE"
  FROM (SELECT name_vc, quantity_nu q1, quantity_nu q2
          FROM t_giftorder ORDER BY name_vc)--�ζ��κ�
 GROUP BY name_vc
 
 select * from tdept
 select * from temp
 
 select  from tdept b inner join temp a on b.DEPT_CODE = a.DEPT_CODE