����Ŭ������ �ε����� ���̺������� ���� �����ǰ��ִ�.
���� ��ȸ �÷��� PK�� ��쿡�� ���̺� �＼�� ���� �ε����� �а� ��ȸ����� ��ȯ�Ѵ�.
�˻��ӵ��� �����ִ� �κ���.--Ctrl + e (Explain Plan): ���ѹ����� ����
PK�� �ƴѰ�� Ǯ�� �� �о�� �ϱ� ������ 

SELECT empno FROM emp--���ڴ� ���������ĵǾ���? ( ������������ ������ )

SELECT ename FROM emp--���ڴ� �������ĵǾ���?

��ȸ����� ���� ������ �� �ִ�.
������ �ϸ� 2�� ������ �Ͼ�Ƿ� �˻� �ӵ��� �ʾ���������?
������� �ۿ� �������� ��� ��������, Ű ������� ������� �ֹ��Ѵٸ�, �ε��ϴµ� �ſ� �ð��� �ɸ��� ��
--��, ORDER BY�� ������� �ʰ� ������ �� �� �� �ִ� ����� ����� ȿ���� �����ɷ��� ���� �����.

SELECT ename FROM emp ORDER BY ename asc-- ORDER BY�� 2�� �����Ǳ⋚���� �ӵ��� ������!!!!

SELECT ename FROM emp ORDER BY ename desc

SELECT empno, ename FROM emp

SELECT 1+2,2*4,100-5,100/5,MOD(5,2) FROM dual

WHERE MOD(empno,2)=0--�����, 2�γ���� 0�� �Ǵ� ���� :: �� ¦�� (Toad ���� ������� ==�� �ƴ� = )

SELECT 1 FROM dual WHERE 1=1 OR 1>3

SELECT �� FROM ���̿��� �÷����� �� �� �ִ�. ( ������ ���� )
SELECT �� FROM ������ ��Ģ������ ��Ƽ�������� ó���ϰ� �� �� �ִ�.


SELECT /*+index_desc(emp pk_emp)*/ empno FROM emp--hint���� ����Ͽ� ������������ �����ߴ�.

hint���� ������ ������ ���õȴ�. ( ����, ��Ÿ�� ���ܵ� �����Ѵ� )
�� ������ �߻����� �ʰ�, ���̺��� �� �� �ƴ� �����κ��� ���������� ������ ������ �����.

���� ��밡���ұ�?
�ֹ���ȣ ä���Ҷ� ��밡���� �κ�

SELECT /*+index_desc(emp pk_emp)*/ empno FROM emp
--desc : descending�� ����

SELECT /*+index_desc(emp pk_emp)*/ empno+1 FROM emp --��Ģ���� �����Ͽ� ä���س�
WHERE rownum = 1

SELECT 5000/12 FROM dual

dual�� ����Ŭ���� �����ϴ� ������ ���̺��, �ο�1��/�÷�1�� �� �����Ǿ��ִ� �������̺��
�������̺�＼������ �׽�Ʈ�� �����ϰ�, ������� ���ų� ��Ģ������ ����ϱ⿡ �̿밡��


Q.�츮ȸ�翡�� �޿��� ���� ���� �޴� ����� �̸��� �޿��� ����ϴ� sql���� �ۼ��Ͻÿ�.
    
        �Լ����� max
        SELECT �÷���1, �Լ�(�÷���), �Լ�(��), ��Ģ���� FROM dual
        --�Լ��� ���� ó�� ����� ���Ϲ��� ���� �ִ�.
    
        SELECT count(empno),MAX(ename), MIN(sal), MOD(5,2) FROM emp
        

        ��Ʈ
        ���� �츮ȸ�翡�� �޿��� ���� ���� �޴� ����� �޿����� �˾� ����.
        
        �ι�°,
        �� �޿������� ���� �˻��� �ؼ� ������ �޿����� ����� ����.

        SELECT MAX(sal) FROM emp

        SELECT ename,sal FROM emp WHERE sal=5000
    

        �ϳ��� ���̴� ���?

        MAX�� ���� �׷��Լ�����ȸ����� 1���Դϴ�.
        �׷� �׷��Լ� ��ȸ ����� ename�� ���� �Ϲ� �÷��� ���� ����� ���� ���°���
        �ֳ��ϸ� sal�� ���� �ִ밪�� ã�Ҵµ�, ����̸��� �����޶�� �ϸ� 14�� �� ������ ������� ����
        ��Ƽ������ ���忡���� ������ ��Ȳ�� �Ǳ� ������, FROM Ű���忡���� �����ϰ� �˴ϴ�.
        
        SELECT MAX(sal), ename WHERE emp
        
        �ذ���
        �� ���� ������ �ذ��Ϸ��� ename���� max�� �����ָ� �չ��� �Ǳ� ������
        �׶�  ��µ� �̸��� �̸��� �ִ밪���� �޿��� �ִ��� ����� �̸��� �ƴϱ� ������ ���� ���ϴ� ���� �ɼ� �����.
        
        SELECT sal, ename FROM emp WHERE sal>=(SELECT MAX(sal) FROM emp)
            
        
        
        �츮ȸ�翡�� �μ�Ƽ�긦 �޴� ������� �����ȣ, ����� �׸��� �μ�Ƽ�� �ݾ��� ����ϴ� sql���� �ۼ��Ͻÿ�.
        
        SELECT empno as "�����ȣ", ename as "�����",comm as "�μ�Ƽ�� �ݾ�"
            FROM emp
           WHERE comm IS NOT NULL
             AND comm != 0 
        
        
       
        �н���ǥ
        ���� ���� ���ؼ� ��ȸ����� ����� �� �ִ�.
        
        SELECT 1 FROM dual WHERE 1 > 3
        
        SELECT 1 FROM dual WHERE 1 < 3
        
        NULL�� ���� �� IS NULL  Ȥ�� IS NOT NULL  �� �ؾ��Ѵ�. ( �𸣴� ���̱� ���� )
        
        
        
        �߰��н���ǥ
        ������ ��� �ڵ忡 ������ �� �ִ�. - �߱޳��̵�
        
        SELECT 1 FROM dual
        UNION ALL
        SELECT 2 FROM dual
        
        SELECT 1 FROM dual
        MINUS
        SELECT 2 FROM dual
        
        SELECT 1 FROM dual
        INTERSECT
        SELECT 1 FROM dual
        
        
        
        1
        SELECT empno, ename, comm FROM emp
        WHERE comm IS NOT NULL
          AND comm !=0--!�� �����Ѵٴ� �ǹ�
       
        2
        SELECT empno, ename, comm FROM emp
        WHERE comm IS NOT NULL
        MINUS
        SELECT empno, ename, comm FROM emp
        WHERE comm =0
        
        ù��°�� ���̺��� �� ���� �а� ó��������
        �ι�°�� ������ ���̺��� �ι� �о ó���ϹǷ�
        ù��°�� �� ȿ�����Դϴ�. (ȿ�����̶�°� �Ϸ��� ���ٴ� �ǹ�)
        
        
        
        �ش� �÷��� NULL�� ���� �ڸ��� ����,'����'�� ����־� ��
        
        SELECT NVL(comm,0) FROM emp
        
        SELECT NVL(comm,'1') FROM emp
        
        
        
        ����Ŭ�� ��ҹ��ڸ� �������� ������, ����Ŭ���� �������� ��ҹ��ڴ� �����Ѵ�.
        ���� �̱� �����̼�( ' ' )�� �����Ͱ�, ���� �����̼� ( " " )�� ġȯ�� ��? 
        
        SELECT sal FROM emp WHERE ename='SMITH'
        
        SELECT sal as "�޿�" FROM emp
        
        
        ����Ŭ���� 2���� �÷��� ���ļ� �ϳ��� �� �ȿ� ��Ÿ���� ��� 
        
        SELECT empno||ename FROM emp