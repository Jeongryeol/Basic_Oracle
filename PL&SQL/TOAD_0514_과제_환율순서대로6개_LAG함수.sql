test02 ���̺��� �ڷḦ �̿��� �ش����ں��� ���ų� �������� ȯ����
������� 6������ �����ִ� �������� �ۼ��� ������.

�䱸����
LAG�Լ��� ������� ���� ó���� ������.
--https://m.blog.naver.com/PostView.nhn?blogId=acatholic&logNo=90148808397&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F

CDATE : ����� ��¥ 9��1�� ~9�� 11��
AMT : ���ں� ȯ�� �ݾ�
CRATE : ���� ���� ȯ�� 

EDIT test02

SELECT
       SUM(rf1.cdate) as "�������"
      ,rf2.cdate as "������"
      ,rf1.crate as "����ȯ��"
  FROM TEST02 rf1, TEST02 rf2
 WHERE rf1.cdate >= rf2.cdate
   AND rf1.cdate - rf2.cdate <= 6
 GROUP BY rf1.cdate, rf2.cdate, rf1.crate
 ORDER By rf1.cdate