DB���� �����ϱ�

CREATE USER wadiz identified by qwer1234
--DDL �����������

GRANT connect, resource TO wadiz
--DCL ���Ѻο���� : �����ڱ���

--���̺� �����̽� �����ϱ�(�޸𸮰����Ҵ�)
--����Ŭ�� ��ġ�� �������� ��ġ Ȯ���ϱ�
--E:\app\509\oradata\orcl11 
--�ش� ������ ������������ ��ο� ��������, ����ũ�⸦ ��������
CREATE TABLESPACE ts_wadiz DATAFILE 'E:\app\509\oradata\orcl11\db_wadiz.dbf' SIZE 200M
DEFAULT STORAGE
(INITIAL 10K
 NEXT 10K
 MINEXTENTS 2
 MAXEXTENTS 50
 PCTINCREASE 50)
--�ϴ� ����ǥ���ٿ��� Tablespace created Ȯ�� 

SELECT tablespace_name, initial_extent, max_extents FROM dba_tablespaces;
--����Ŭ�󿡼� ��������Ȯ���ϱ�
--��ǻ�� �ϵ��ũ�󿡼� ������ ��������Ȯ���ϱ� : �ش������� db_wadiz.dbf �� 200mb�� �����Ǿ����� Ȯ���Ұ�