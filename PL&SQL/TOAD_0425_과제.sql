DECODE Ȱ���� ���� ��������
--DECODE�� ���������� ELSE�� ����� ������ ������, ELSE�� �ش�� ��� NULL�� ������.

��������1
�ִ� ���ǽð�(lec_time)�� ����(lec_point)�� ������ '�Ϲݰ���'�� �����޴� sql�� �ۼ��ϱ�

SELECT   
    LEC_ID
   ,DECODE(lec_time,lec_point,'�Ϲݰ���')
    FROM LECTURE

------------------------[ ����Ǯ�� ]--------------------------------

DECODE ( �ð�, ����, '�Ϲݰ���' ) FROM ����

SELECT
    lec_id as "���¾��̵�"
   ,DECODE(lec_time, lec_point, '�Ϲݰ���', null)as "��������"
    FROM lecture

-----------------------------------------------------------------



��������2
�ִ� ���ǽð��� ������ ���� ���� ������ ���� �˼��ִ� sql�� �ۼ��ϱ�

SELECT count(*) as "'�ִ� ���ǽð�=����'������ ��" FROM LECTURE
    WHERE DECODE(lec_time,lec_point,1)=1

�Ǵ�

SELECT count(*) as "'�ִ� ���ǽð�=����'������ ��" FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=0

------------------------[ ����Ǯ�� ]--------------------------------

--SELECT count(*), count(empno)m, count(comm) FROM emp

--SELECT count(*)
--    FROM lecture
--   WHERE lec_time = lec_point
   
--DECODE(lec_time, lec_point,1)

SELECT
        COUNT(DECODE(lec_time, lec_point,1,null)) as "���ǽð��������̰������¼�  "
    FROM lecture

-----------------------------------------------------------------



��������3
lec_time�� lec_point���� ũ�� '�������', lec_point�� ũ�� '��Ÿ����',
���� ������ '�Ϲݰ���'���� �����޴� sql�� �ۼ��ϱ�

SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),0,'�Ϲݰ���') as "�з�"FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=0
UNION ALL
SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),1,'�������') FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=1
UNION ALL
SELECT LEC_ID, DECODE(SIGN(lec_time-lec_point),-1,'��Ÿ����') FROM LECTURE
    WHERE SIGN(lec_time-lec_point)=-1
ORDER BY LEC_ID ASC;

-----------------------------------------------------------------

SELECT
    lec_id
   ,DECODE(SIGN(lec_time-lec_point),1,'�������',-1,'��Ÿ����',0,'�Ϲݰ���') as "�з�"
    FROM lecture

------------------------[ ����Ǯ�� ]--------------------------------

lec_time-lec_point > 0 �������
lec_time-lec_point = 0 �Ϲݰ���
lec_time-lec_point < 0 ��Ÿ����
>>>>> SIGN(???) !!!!

DECODE �� �ɰ��� ��ְ� �ִ� : ũ�� Ȥ�� �۴� �� �񱳴� �Ұ��ϴ�.
�׷���
SIGN �� �̿��ϸ� �� ������ ������ ������ ũ��񱳰� �����ϴ� ( -1, 0, 1 )

DECODE( SIGN(lec_time-lec_point),1,'�������'
                                                ,0,'�Ϲݰ���'
                                                ,-1,'��Ÿ����')

SELECT
        lec_id as " ���¾��̵�"
       ,DECODE( SIGN(lec_time-lec_point),1,'�������'
                                                ,0,'�Ϲݰ���'
                                                ,-1,'��Ÿ����') as "��������"
    FROM lecture
 
-----------------------------------------------------------------

BEGIN
    DBMS_OUTPUT.ENABLE;
    SELECT lec_id into v_lec_id FROM LECTURE;
    IF (SIGN(lec_time-lec_point)=1) THEN
    DBMS_OUTPUT.PUT_LINE( ' ������� ' );
    ELSIF (SIGN(lec_time-lec_point)=-1) THEN
    DBMS_OUTPUT.PUT_LINE( ' ��Ÿ���� ' );
    ELSe (SIGN(lec_time-lec_point)=0) THEN
    DBMS_OUTPUT.PUT_LINE( ' �Ϲݰ��� ' );
    END IF;

---------------------------------------------------------------------------

---------------------------------------------------------------------------

����1
��ȭ Ƽ���� ���� �� �ִ� ����� ��ܰ� ���� ������ �ִ� ����Ʈ, ��ȭ Ƽ���� ����Ʈ
�׸��� �� Ƽ���� ����� �� ���� ���� ����Ʈ�� ����Ͻÿ�.

SELECT
    NAME_VC as "���̸�"
   ,POINT_NU as "��������Ʈ"
   ,15000 as "��ȭƼ�ϼҸ�����Ʈ"--GIFTPOINT ���̺� �ִ� ��ȭƼ���� POINT_NU�� ���� �����ͼ� ������ ��������??
   ,DECODE(SIGN(POINT_NU-15000),1,'��ȯ����','���ش�') as "��ȭƼ��"
   ,DECODE(SIGN(POINT_NU-15000),1,POINT_NU-15000) as "�����ܿ�����Ʈ"
    FROM T_GIFTMEM

---------- �ĺ��ڸ� �̿��ؼ� ���� ���տ��� ���ð���

SELECT
    a.NAME_VC as "���̸�"
   ,a.POINT_NU as "��������Ʈ"
   ,b.POINT_NU  as "��ȭƼ��"
   ,a.POINT_NU-b.POINT_NU as "�ܿ�����Ʈ"
    FROM T_GIFTMEM a, T_GIFTPOINT b
    WHERE b.NAME_VC = '��ȭƼ��' AND a.POINT_NU >= b.POINT_NU

--[����Ǯ��]---------------------------------------------------------------------------

edit t_giftmem

edit t_giftpoint

SELECT * FROM t_giftmem, t_giftpoint --�ƽ��͸���ũ(*)�� �ظ��ϸ� ��� ���� ������.


SELECT * FROM t_giftmem mem, t_giftpoint point
WHERE mem.point_nu >= point.point_nu
      AND point.name_vc='��ȭƼ��'
      
��°��
��������Ʈ mem.point_nu
�������Ʈ point.point_nu
�ܿ�����Ʈ mem.point_nu - point.point_nu

SELECT
        mem.name_vc as "ȸ���̸�"
       ,TO_CHAR(mem.point_nu,'999,999')||'��' as "��������Ʈ"
       ,TO_CHAR(point.point_nu,'999,999')||'��' as "�������Ʈ"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'��' as "�ܿ�����Ʈ"
    FROM t_giftmem mem, t_giftpoint point
    WHERE mem.point_nu >= point.point_nu
    AND point.name_vc='��ȭƼ��'

������ -> Ctrl+E : �����ȹ����


�����ڵ�? �Ϸ��� ���̴� ����� ���� ������?

�� ����� ������ t_giftmem��ü�� t_giftpoint ��ü�� ���ϰ� �ִ�.
�׷��� ����������� �䱸������ ��ȭƼ�Ͽ� ���ؼ��� ��ȸ�� ���ϰ� �ִ�.
���� ���� ��ü�� ������ ���� t_giftpoint ���տ��� ��ȭƼ�ϸ� 1�� �����ؼ�
���ϰԵǸ� ��Ƽ�������� ������ �ϴ� ����� ���� ���� �� �ִ�.

�����ڵ� 1

SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
 WHERE name_vc='��ȭƼ��'

SELECT /*+choose*/
        mem.name_vc as "ȸ���̸�"
       ,TO_CHAR(mem.point_nu,'999,999')||'��' as "��������Ʈ"
       ,TO_CHAR(point.point_nu,'999,999')||'��' as "�������Ʈ"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'��' as "�ܿ�����Ʈ"
    FROM t_giftmem mem, (SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
                          WHERE name_vc='��ȭƼ��') point
    WHERE mem.point_nu >= point.point_nu -- 1:n���� ������־� ��Ƽ�������� ���ϸ� �ٿ�����.


SELECT /*+choose*/
        mem.name_vc as "ȸ���̸�"
       ,TO_CHAR(mem.point_nu,'999,999')||'��' as "��������Ʈ"
       ,TO_CHAR(point.point_nu,'999,999')||'��' as "�������Ʈ"
       ,TO_CHAR(mem.point_nu - point.point_nu,'999,999')||'��' as "�ܿ�����Ʈ"
    FROM t_giftmem mem, (SELECT giftid_vc, name_vc, point_nu FROM t_giftpoint
                          WHERE name_vc='��ȭƼ��') point
    WHERE mem.point_nu >= point.point_nu -- 1:n���� ������־� ��Ƽ�������� ���ϸ� �ٿ�����.

��Ƽ�������� �۵���� 2����
1)rule base optimizer - 15������  ��Ģ ���ؿ� ���� �����ȹ�� �����.
    ����ī�޶� - �����ڰ� �����ϴ� �����ȹ���� ��ȸ�� �� �ִ�.
2)cost base optimizer - ����� ����ؼ� �� ����� ���� ������ �����ȹ�� �����.
    �ڵ�ī�޶� - �������� ���� �ݿ�
    ��, �������� �������� ����ؾ� ��Ȯ���� ��������.
    

���
�� �� �̻��� ������ �����ؼ� ���� ���ؾ� �� ��쿡��
�����ϸ� ���� ������ ���� ���̰� ���� ��


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
����2
�����ž��� �����ϰ� �ִ� ���ϸ��� ����Ʈ�� ���� �� �ִ� ��ǰ �� ���� ����Ʈ�� ���� ���� �����ΰ�?

SELECT a.NAME_VC as "���̸�"
      ,a.POINT_NU as "��������Ʈ"
      ,b.NAME_VC as "���Ű��ɻ�ǰ"
      ,b.POINT_NU as "�ҿ�����Ʈ"
    FROM  T_GIFTMEM a
        ,(SELECT NAME_VC, POINT_NU FROM T_GIFTPOINT
            ORDER BY POINT_NU desc) b
    WHERE a.NAME_VC='������'
        AND b.POINT_NU<=a.POINT_NU
        AND rownum = 1    

      
-----

SELECT * FROM T_GIFTPOINT
    ORDER BY POINT_NU DESC

SELECT
    a.NAME_VC as "���̸�"
   ,b.NAME_VC as "�ְ���ǰ"
   ,b.POINT_NU as "�ҿ�����Ʈ"
    FROM T_GIFTMEM a
        ,T_GIFTPOINT b
   WHERE a.NAME_VC = '������'
     AND b.NAME_VC='���λ�ǰ��'      


--����Ǯ��----------------------------------------------------------------------

1) �������� �����ϰ� �ִ� ����Ʈ�� ã�´�.

SELECT point_nu FROM t_giftmem
 WHERE name_vc='������'

2) 1������ ���� ����Ʈ�� ������ t_giftpoint���� �۰ų� ���� ���� ã�´�.

SELECT point_nu
  FROM t_giftpoint
 WHERE point_nu <= 50012
 
SELECT point_nu
  FROM t_giftpoint
 WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                     WHERE name_vc='������')
                     
3) 2�� ��� �߿��� ���� ū ���� ã�´�. (max�Լ�)

SELECT MAX(point_nu)
  FROM t_giftpoint
 WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                     WHERE name_vc='������')
                     
4) 3������ ���� ���� ������ t_giftpoint���� ��ǰ���� ����Ѵ�.

SELECT
        name_vc as "��Ʈ��", point_nu as "�ְ� ��������"
  FROM t_giftpoint
 WHERE point_nu = (SELECT MAX(point_nu)
                    FROM t_giftpoint
                   WHERE point_nu <= (SELECT point_nu FROM t_giftmem
                                       WHERE name_vc='������'))
                                       
----- T_GIFTPOINT ������ 2�����ļ� ����Ǿ��µ�..? Ƚ���� ���� �� �ִ� ����� ������?

--�Ʒ��ڵ�� ��ǰ�̸� �߿� �̸��� ���� ū���� ������ ����̹Ƿ� ���� �ƴϴ�.
--��ǰ�̸��� ��ǰ����Ʈ�� �ٸ���.

SELECT MAX(poi.name_vc)
      ,MAX(poi.point_nu)
  FROM t_giftpoint poi, t_giftmem mem
 WHERE poi.point_nu <= mem.point_nu
   AND mem.name_vc='����ȯ'