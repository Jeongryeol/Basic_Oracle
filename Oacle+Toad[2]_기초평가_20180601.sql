1. 'TEMP ���̺��� ��̰� NULL�� �ƴ� ����� ������ �о���ÿ�.'

SELECT emp_name "����", hobby "���"
  FROM temp
 WHERE hobby IS NOT NULL
 ORDER BY emp_name
 

 
2. 'TEMP�� �ڷ� �� HOBBY�� ���� NULL�� ����� '���'���� ġȯ������
    HOBBY�� '���'�� ����� ������ �������� ������ �ۼ��Ͻÿ�.'
 
SELECT ����,���
  FROM (SELECT emp_name AS "����"
       ,NVL(hobby,'���') AS "���" FROM TEMP)
  WHERE ��� = '���'



3. 'SMITH�� �ٹ��ϴ� �μ��� ���� �μ��� �ٹ��ϴ� ������� �̸��� �Ի����ڸ� ����Ͻÿ�'

SELECT e.ename "�̸�", e.hiredate "�Ի�����", d.dname "�ٹ��μ�"
  FROM emp e, dept d
 WHERE e.deptno = d.deptno
   AND e.deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN')
   


4. '�Ի�⵵�� 1982�⵵�� ������� ����� �̸��� ����Ͻÿ�.'

SELECT empno "���", ename "�̸�", TO_CHAR(hiredate,'YYYY') "�Ի�⵵" FROM emp
WHERE TO_CHAR(hiredate,'YYYY') = 1982 



5. '�츮ȸ�翡�� �ٹ��ϴ� ����� �߿� �޿��� 2000�� �̻��� ������� �޿��� ����� ���Ͻÿ�. (�Ҽ� 3�ڸ����� �ݿø��Ͻÿ�.)'

SELECT '$'||TO_CHAR(ROUND(AVG(sal),2),'9,999.99') "2000�� �̻��� ��ձ޿�" FROM emp WHERE sal>= 2000



6. 'SQL���� ó���Ǵ� ���� 4�ܰ迡 ���� �����Ͻÿ�.'
    1) �����ȹ���� (15���� ��Ģ��� �ڵ���ȹ - rule base / �Ͼ翡 ���� cost base )
    2) TABLE ��������
    3) ��Ƽ������ �����ȹ����
    4) ��ġ(����TABLE����)�� ������ ��ȸ
     
    

7. '�����ϰ� �ִ� ����Ʈ�� ���Ϲٱ��ϸ� ���� �� �ִ� ������� ��ܰ� ��������Ʈ, ��ǰ����Ʈ�� ����Ͻÿ�.'

SELECT mem.name_vc "����", mem.point_nu "��������Ʈ" , poi.name_vc "��ǰ��", poi.point_nu "�ҿ�����Ʈ"
  FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '���Ϲٱ���'
   AND mem.point_nu >= (SELECT point_nu FROM t_giftpoint WHERE name_vc = '���Ϲٱ���')
 ORDER BY mem.name_vc, poi.point_nu




8. 'ALLEN�� �ٹ��ϴ� ���μ����� ����ϴ� SQL���� �ۼ��Ͻÿ�'

SELECT emp.ename "����", dept.dname "�μ���"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
   AND emp.ename = 'ALLEN'
   


9. '�μ��� �޿� ����� ���ϰ� �޿� ����� 2000�� �̻��� �μ��� �μ���ȣ�� ����Ͻÿ�.'

SELECT dept.dname "�μ���", '$'||TO_CHAR(ROUND(AVG(emp.sal),2),'99,999.99') "��ձ޿�"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
 GROUP BY dept.dname
 HAVING AVG(sal) >= 2000
 


10. 'JOB�� MANAGER ������� �޿��� ��, JOB�� ANALYST�� ������� �޿��� ��, �׸��� �������� ��Ÿ������� �޿��� ���� ���Ͻÿ�.' 
 
SELECT DECODE(job,'MANAGER',job,'ANALYST',job,'��Ÿ') "JOB"
      ,'$'||TO_CHAR(SUM(sal),'999,999') "�޿��հ�"
  FROM emp
 GROUP BY DECODE(job,'MANAGER',job,'ANALYST',job,'��Ÿ')
 ORDER BY DECODE(job,'MANAGER',job,'ANALYST',job,'��Ÿ')
 
 
 
11. 'lec_time�� ũ�� �������, lec_point�� ũ�� ��Ÿ����� ���� ������ �Ϲݰ������� ���� �����ް����Ѵ�. ��� �ؾ��ϴ°�?'

SELECT a.lec_id "No", DECODE(SIGN(a.lec_time - b.lec_point),1,'�������',-1,'��Ÿ����',0,'�Ϲݰ���') "�з�"
  FROM (SELECT rownum rno, lec_id, lec_time FROM lecture) a
      , (SELECT rownum rno, lec_point FROM lecture) b
 WHERE a.rno = b.rno
 
 
 
12. ������ DECODE�������� ǥ���غ��ÿ�
 
IF A = B THEN
    IF C = D THEN
        RETURN 'T';
    ELSE
        RETURN 'F';
    END IF
ELSE
    RETURN 'F'
END IF;

DECODE(A-B,0,DECODE(C-D,0,'T','F'),'F')

������ : DECODE(A,A,DECODE(C,C,'T','F'),'F')
 