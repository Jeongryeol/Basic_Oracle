--�����Ͱ��� SYS�κ��� ������ ������ �����ڱ����� �ο��Ǿ�����,
--������ ���� ������ �������� ���̺�����ϱ�

CREATE table member
(mem_id VARCHAR2(15) constraints memid_pk primary key --constraints:��������
,mem_pw VARCHAR2(15) not null
,mem_name VARCHAR2(30) not null)