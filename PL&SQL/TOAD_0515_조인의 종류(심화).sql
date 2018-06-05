edit temp

edit EMP_LEVEL 

SELECT
    TEMP.EMP_ID
   ,TEMP.EMP_NAME
   ,temp.lev
   , to_char(temp.salary/10000,'999,999')||'����' salary
  FROM temp, emp_level
  WHERE emp_level lev = '����' 
  and TEMP.SALARY BETWEEN EMP_level, FROM_SAL 
  AND TO_SAL  order by temp, salary desc

select SALARY from temp where lev = "����"

select FROM_SAL, to_age from EMP_LEVEL 

select * from temp
where salary

(select FROM_SAL, to_age from EMP_LEVEL) where lev = "����"

select 
    TEMP.EMP_ID as "��ȣ"
   ,TEMP.EMP_NAME as " �̸�"
   ,to_char(temp.salary/10000, '999,999,999')||'����' as "����"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'����'as "���ѿ���"
   ,to_char(emp_level.from_sal/10000, '999,999')||'����'as "���ѿ���"
    from temp, emp_level
    where TEMP.lev = emp_level.lev(+) 
    
select 
    TEMP.EMP_ID as "��ȣ"
   ,TEMP.EMP_NAME as " �̸�"
   ,to_char(temp.salary/10000, '999,999,999')||'����' as "����"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'����'as "���ѿ���"
   ,to_char(emp_level.from_sal/10000, '999,999')||'����'as "���ѿ���"
    from temp LEFT OUTER JOIN emp_level
    ON TEMP.lev = emp_level.lev
    
    
select 
    TEMP.EMP_ID as "��ȣ"
   ,TEMP.EMP_NAME as " �̸�"
   ,to_char(temp.salary/10000, '999,999,999')||'����' as "����"
   ,to_char(EMP_LEVEL.TO_SAL/10000, '999,999')||'����'as "���ѿ���"
   ,to_char(emp_level.from_sal/10000, '999,999')||'����'as "���ѿ���"
    from temp RIGHT OUTER JOIN emp_level
    ON TEMP.lev = emp_level.lev                                 
    
    --left outer join�� ��� ������ ��ü�� �������� �������� ���̺��� �����Ͽ� ���� �´ٸ� ����� �ǵ��� �ƴ϶�� ���ʸ� ����� �ǵ���
    --right outer join�� ��� �������� ��ü�� �������� ������ ���̺��� �����Ͽ� ���� �´ٸ� ����� �ǵ��� �ƴ϶�� �����ʸ� ����� �ǵ���
    --inner join �������� = ������ �� ��ü ������ ��ġ�� �͸�
    --all outer join �������� = ������ �� ��ü ������ ���ΰ� ���

SELF join
��ü�� �����̶�� �ϸ� � ���̺�� �� �ٸ� ���̺��� Ư�� �÷����� �����ϴ� ��츦 ���Ѵ�.
tdept���̺� �ڽ��� ���� �μ� ������ �����ϰ� �ִ�.
�� ���̺��� �̿��Ͽ� �μ��ڵ�, �μ���, �����μ��ڵ�, �����μ����� �;� ���� sql���� �����ÿ�.

edit tdept


SELECT 
     A.DEPT_CODE AS "�μ��ڵ�"
    ,A.DEPT_NAME AS "�μ���"
    ,A.PARENT_DEPT AS "�����μ��ڵ�"
    ,B.DEPT_NAME AS "�����μ���"
    FROM TDEPT A, TDEPT B
     WHERE A.PARENT_DEPT = B.DEPT_CODE
 
 �����μ��� ca0001�� �μ��� �Ҽӵ� ������ 1,��� ,2����, 3, �μ��ڵ�, 4,�μ���, 5,�����μ��ڵ�
6,�����μ���, 7,�����μ����ڵ�, 8,�����μ��强�� ������ ����ϼ���.


edit tdept

edit temp

SELECT
     AA.DEPT_CODE "���"
    ,AA.EMP_NAME "����"
    ,AB.DEPT_NAME "�μ��ڵ�"
    ,AB.PARENT_DEPT "�μ���"
    ,AC.DEPT_NAME "�����μ���"
    ,AC.BOSS_ID "�����μ����ڵ�"
    ,AC.DEPT_NAME "�����μ���"
    ,AA.EMP_NAME "�����μ��强��"
    FROM TEMP AA,TDEPT AB , TDEPT AC 
    WHERE AA.DEPT_CODE = AB.PARENT_DEPT
    AND AB.DEPT_CODE = 'CA0001'
    AND AB.PARENT_DEPT = AA.DEPT_CODE
    ORDER BY AC.BOSS_ID DESC
     
    AND AC.BOSS_ID = AA.EMP_NAME 
    
    ORDER BY AC.BOSS_ID DESC
    
 
select
        a.dept_code "�μ��ڵ�"
       ,A.DEPT_NAME "�μ���"
       ,b.dept_code  "�����μ��ڵ�"
       ,b.dept_name "�����μ���"
from tdept a, tdept b   
 where a. parent_dept = b.dept_code
    
 
 2) 1�� ����� 1�� (���)�� 2��(����)�� �߰��� ������.
 
 SELECT
        C. EMP_ID "�����ȣ"
       ,C. EMP_NAME "�����"
       ,A.DEPT_CODE "�μ��ڵ�"
       ,A.DEPT_NAME "�μ���"
       ,B.DEPT_CODE  "�����μ��ڵ�"
       ,B.DEPT_NAME "�����μ���"
       ,D. EMP_ID "�����μ����ڵ�"
       ,D. EMP_NAME "�����μ����"
FROM TDEPT A, TDEPT B, TEMP C, temp D
 WHERE A. PARENT_DEPT = B.DEPT_CODE
    AND A.DEPT_CODE = C.DEPT_CODE
    and d.emp_id = B.boss_id
    and b.dept_code ='CA0001'
    
���� t_orderbasket ���̺��� �м��� �Լ��� ������� �ʰ� �� ��¥����
�� ��� ������ �󸶸�ŭ �ȷ����� ������� ��� �Ǵ��� �˰� �ʹ�.
��� �Ұ�� �հ踦 ���� ���ΰ�?    


 edit T_ORDERBASKET
 
 ��¥�� ����.
 select INdate_vc from T_ORDERBASKET
   group by INdate_vc
   
 ������ ������ ���ϰ�, �� ������� �հ踦 ���ߴ�.
 select INdate_vc, sum(QTY_NU),SUM(QTY_NU*PRICE_NU) from T_ORDERBASKET
   group by INdate_vc
   
   
 