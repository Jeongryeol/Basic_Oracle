1. ����縸 ����ϼ���.

    SELECT words_vc as "�����" FROM t_letitbe WHERE MOD(seq_vc,2)=1

    �ڡڡڸ����ȡڡڡ�

    SELECT words_vc as "�����" FROM t_letitbe WHERE MOD(TO_NUMBER(seq_vc),2)=1


    �ڡڡ�����ȸ�Ŵ�ȡڡ�

    SELECT words_vc as "�����"
    FROM(SELECT SEQ_VC,words_vc FROM t_letitbe 
    MINUS
    SELECT SEQ_VC,words_vc FROM t_letitbe WHERE MOD(seq_vc,2)=0)
    WHERE MOD(TO_NUMBER(seq_vc),2)=1




2. �ѱ۰��縸 ����ϼ���.

    SELECT words_vc as "�ѱ۰���" FROM t_letitbe WHERE MOD(seq_vc,2)=0

    �ڡڡڸ����ȡڡ�

    SELECT words_vc as "�����" FROM t_letitbe WHERE MOD(TO_NUMBER(seq_vc),2)=1




3. ������ �ѱ۰��縦 ����� ����ϴ� SQL���� �ۼ��ϼ���.
�䱸���� 
�ݵ�� UNION ALL�� ����ؼ� �ۼ��մϴ�.
SELECT * FROM t_letitbe�� ���� �ƴմϴ�.
    
    SELECT WORDS_VC as "����"
    FROM(SELECT * FROM t_letitbe WHERE MOD(seq_vc,2)=1
         UNION ALL
         SELECT * FROM t_letitbe WHERE MOD(seq_vC,2)=0)
    ORDER BY TO_NUMBER(seq_vc) asc;
    
    
    --�������� ����ϴ� �÷����� ��Ī���� ����� �� ����
    --���̺������� �����ϴ� �÷��� �����ϴ�.
    --��,alias��(��Ī)���� ��ȸ�� ������ ���� �ζ��κ� �� ������ ��������� ��������
        
    SELECT *
        FROM ( SELECT empno as "�����ȣ", ename FROM emp )
       WHERE "�����ȣ" > 7800
    
    --a�� �ش������� �ǹ��ϴ� �ĺ��� ����

    SELECT a."�����ȣ"
        FROM ( SELECT empno as "�����ȣ", ename FROM emp )a
       WHERE "�����ȣ" > 7800
    
    �ڡڡڸ����ȡڡڡ�
    
    
      
    IF 1=1 THEN
        return "��"
    ELSE THEN
        return 'b'
    END IF;
    
    
    
    SELECT DECODE('A','B','T','F') FROM dual
    
           DECODE : �ճ���('A')�� �޳���('B')�� ������  �Ǵ��ϰ� ������ 'T' �ٸ��� 'F'�� ��ȯ�Ѵ�.
           
           
    SELECT SIGN(7), SIGN(0), SIGN(50-50), SIGN(10-40), SIGN(-500) FROM dual
    
    SELECT DECODE(SIGN(183-170),1,'Űī ũ��','Ű�� �۴�') FROM dual
    
    SELECT deptno FROM emp GROUP BY deptno