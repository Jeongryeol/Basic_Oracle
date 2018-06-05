�������� 2ȸ��

�����Ͽ� �ش����ڿ� 01�� �ٿ��� 4�ڸ� ��ȣ�� �����
ȭ���Ͽ� 11, �����Ͽ� 21, ����Ͽ� 31, �ݿ��Ͽ� 41, ����Ͽ� 51, �Ͽ��Ͽ� 61�� �ٿ���
4�ڸ� ��ȣ�� ����ٰ� �� �� ��ȣ�� ���ϴ� SQL���� �ۼ��Ͻÿ�.

��Ʈ

SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH:MI:SS AM')
     ,TO_CHAR(sysdate,'day')
     ,TO_CHAR(sysdate,'DD')
    FROM dual

SELECT
        TO_CHAR(sysdate,'DD') || DECODE(TO_CHAR(sysdate,'day'),'������',01
                                                                                         ,'ȭ����',11
                                                                                         ,'������',21
                                                                                         ,'�����',31
                                                                                         ,'�ݿ���',41
                                                                                         ,'�����',51
                                                                                         ,'�Ͽ���',61) as "4�ڸ� ��ȣ"
    FROM dual

--------------------------------------------------------------------------------------------------------------------
    
IF TO_CHAR(sysdate,'day')='������' THEN
        return '01';
ELSIF TO_CHAR(sysdate,'day')='ȭ����' THEN
        return '11';
ELSIF TO_CHAR(sysdate,'day')='������' THEN
        return '21';
ELSIF TO_CHAR(sysdate,'day')='�����' THEN
        return '31';
ELSIF TO_CHAR(sysdate,'day')='�ݿ���' THEN
        return '41';
ELSIF TO_CHAR(sysdate,'day')='�����' THEN
        return '51';
ELSIF TO_CHAR(sysdate,'day')='�Ͽ���' THEN
        return '61';    
END IF;


--------------------------------------------------------------------------------------------------------------------
��������

������̺��� job�� CLERK�� ����� �޿��� ��. SALESMAN�� ����� �޿��� ���� ���ϰ� 
������ job�� ���ؼ��� ��Ÿ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.

CLERK_��    SALESMAN_��   ��Ÿ_��
------------------------------------
     ?                     ?                  ?
     

SELECT
        '$'||TO_CHAR(SUM(DECODE(job,'CLERK',sal)), '9,999') as "CLERK_�հ�"
       ,'$'||TO_CHAR(SUM(DECODE(job,'SALESMAN',sal)), '9,999') as "SALEMAN_�հ�"
       ,'$'||TO_CHAR(SUM(DECODE(job,'CLERK',null,'SALESMAN',null,sal)), '99,999') as "��Ÿ_�հ�"
    FROM emp
    


------------------------------------------------------------------
��������
t_worktime ���̺��� �۾��ڵ庰�� �۾��ð��� ����Ǿ� �ִ�.
�̵� �������� �۾��ð��� ª�� �ɸ��� �ð� ������� 1���� 15������ ������ 
�Űܼ� ����Ͻÿ�.
(�� rank()�Լ��� ������� ���� �� �غ�����)
���� rank�Լ��� ������� ��쿡�� �ݵ�� ����Ǯ�̸� 2���� �÷��ּ���^^

COUNT �Լ��� �̿��Ͽ� RANK�ű��

SELECT
    seq_vc, COUNT(seq_vc) as "�۾��켱����"
    FROM(SELECT
                        a.seq_vc
                    FROM t_worktime a, t_worktime b
                    WHERE a.time_nu>= b.time_nu)
    GROUP BY seq_vc
    ORDER BY COUNT(seq_vc) 

--[����Ǯ��] �����ϰ� �����ϱ�---------------------------------------

1) ������ 3��¥�� ������� �ִ� ���̺��� ���������� ������

SELECT 1.15 w_t FROM dual
UNION ALL
SELECT 0.4 w_t FROM dual
UNION ALL
SELECT 2.4 w_t FROM dual

2) �� ������ 2���� �����ؼ� a1�� a2�� �����Ͽ�, 9���� ����� ���� ������ ���� Ȯ���� ( 3 X 3 )

SELECT
        *
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
      
3) a1�� ���� a2�� ������ ū ����� ���� �����

SELECT
        *
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
 WHERE a1.w_t >= a2.w_t

4) COUNT�Լ��� �̿��ؼ� �� ����� ���� ������ �����, �� ������ a1�� ���� a2�� ������ ũ�ٴ� ����̹Ƿ�, �� ���� �ð��� ���� �׸�ŭ �� ���ٴ� �ǹ��̴�.
��, COUNT�� ���ڰ� ������ �ȴ�.

SELECT
        COUNT(a1.w_t)
  FROM(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a1
     ,(
       SELECT 1.15 w_t FROM dual
       UNION ALL
       SELECT 0.4 w_t FROM dual
       UNION ALL
       SELECT 2.4 w_t FROM dual
      )a2
 WHERE a1.w_t >= a2.w_t
GROUP BY a1.w_t
ORDER BY count(a2.w_t) asc;

-------------------------------------------------------------------------------

SELECT
        RANK() OVER (PARTITION BY workcd_vc ORDER BY TIME_NU) as ����
       ,workcd_vc
       ,time_nu
  FROM t_worktime