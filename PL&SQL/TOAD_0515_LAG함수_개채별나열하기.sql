SELECT 
        cdate as "��¥"
       ,TO_CHAR(amt,'999,999') as "�޷��ݾ�"
       ,TO_CHAR(crate, '99,999') as " ȯ�� "
       ,TO_CHAR(LAG(crate,1) OVER(ORDER BY cdate),'99,999') as " D-1 "
       ,TO_CHAR(LAG(crate,2) OVER(ORDER BY cdate),'99,999') as " D-2 "
       ,TO_CHAR(LAG(crate,3) OVER(ORDER BY cdate),'99,999') as " D-3 "
       ,TO_CHAR(LAG(crate,4) OVER(ORDER BY cdate),'99,999') as " D-4 "
       ,TO_CHAR(LAG(crate,5) OVER(ORDER BY cdate),'99,999') as " D-5 "
  FROM test02
        
        
  
LAG�Լ��� ���� ��, ����� �����ϴ� ���

--a
SELECT rownum rno, cdate,crate FROM test02

--b
SELECT rownum num, cdate,crate FROM test02

--������ ���� �������� ��ȸ�ϱ�
SELECT a.rno,a.cdate as "��¥",MIN(a.crate) as "ȯ��"   
     ,(MAX(DECODE(rno-num,0,b.crate))) ȯ��1
     ,(MAX(DECODE(rno-num,1,b.crate))) ȯ��2
     ,(MAX(DECODE(rno-num,2,b.crate))) ȯ��3
     ,(MAX(DECODE(rno-num,3,b.crate))) ȯ��4
     ,(MAX(DECODE(rno-num,4,b.crate))) ȯ��5
     ,(MAX(DECODE(rno-num,5,b.crate))) ȯ��6 
                   FROM 
                    (SELECT rownum rno, cdate,crate FROM test02)a 
                   ,(SELECT rownum num, cdate,crate FROM test02)b  
                 WHERE a.cdate >= b.cdate
                 GROUP BY a.rno,a.cdate
                 ORDER BY a.cdate
