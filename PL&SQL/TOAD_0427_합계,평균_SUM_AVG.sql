edit t_greport

�ش� �÷��� ��� ���Ҷ�, ����̸��� �÷����� �߰��ϸ� �� ����� �ش�Ǵ� ���� �����ش�.

SELECT
        name_vc
       ,SUM(point_nu) as "����"
       ,AVG(point_nu) as "���"
  FROM t_greport
 WHERE grade_vc=1
GROUP BY name_vc


SELECT
        RANK() OVER(ORDER BY tot1) as "����1"
       ,DENSE_RANK() OVER(ORDER BY tot1) as "����2" 
       ,name_vc
       ,tot1
  FROM(
        SELECT
            name_vc
           ,SUM(point_nu) tot1
           ,AVG(point_nu) avg1
          FROM t_greport
         WHERE grade_vc=1
         GROUP BY name_vc
       )
       


�츮ȸ�翡 �ٹ��ϴ� ����� �߿��� �μ��� �޿��� ����� ���ϴ� SQL���� �ۼ��Ͻÿ�.

SELECT
        a.deptno
       ,AVG(a.sal) as "�޿�"
  FROM emp a, dept b
  WHERE a.deptno = b.deptno
  GROUP BY b.deptno  -- �̸��� �׷����� ������ �����ټ�����, max�� �Ἥ �����ټ������� ��ȿ��������
