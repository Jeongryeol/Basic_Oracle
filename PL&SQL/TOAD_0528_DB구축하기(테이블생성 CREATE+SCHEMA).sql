--PK�� ������ �÷��� �����Ͽ� ���̺��� �����Ѵ�

CREATE TABLE addrtb
(ano number(5) constraints addrtb_ano_pk PRIMARY KEY
,a_id VARCHAR2(10) not null
,a_pw VARCHAR2(10) not null
,a_name VARCHAR2(30) not null
,a_hp VARCHAR2(20))

--�������� �߰��ϸ� �����ڼ������� ����ũ�� ��ȣ�� ä����
SELECT seq_addrtb_ano.nextval FROM dual


--INSERT
--JAVA���� �ۼ��Ͽ� �����غ� ������ SQL���� Toad���� �Է½�Ű�� �׽�Ʈ�� �غ���
INSERT INTO addrtb(ano,a_id,a_pw,a_name,a_hp)
    VALUES(8,'test','123','�̼���','010-0000-9999')
    
rollback;--Ȯ�������� �ѹ��ϰ� SQl���� �����Ͽ� JAVA�� �ٽ� �̵�

SELECT * FROM addrtb--�Է��Ѱ� Ȯ���ϱ�

DELETE FROM addrtb

commit;

--SELECT
--JAVA���� �ۼ��Ͽ� �����غ� ������ SQL���� Toad���� �Է½�Ű�� �׽�Ʈ�� �غ���
SELECT ano, a_id, a_pw, a_name, a_hp
  FROM addrtb
 WHERE a_name = '������'