--DECLARE
CREATE OR REPLACE PROCEDURE proc_exception1(p_temp IN varchar2)
IS--����ڰ� ������ ���ν����� �ڹٿ��� ȣ���ϱ� ���ؼ� �ݵ�� �����ؾ��ϴ� ���
--����
  --�̸�  Ÿ��      �ʱ�ȭ  ��;
    n_i number(10) := 0;
BEGIN
    n_i := '�̼���';
    dbms_output.put_line('���');
EXCEPTION--����ó����
    WHEN invalid_number THEN
    dbms_output.put_line('�̹� ������ �߸��� ���ڿ� ���� ����');
    WHEN value_error THEN
    dbms_output.put_line('�̹� ������ �߸��� �����Ϳ� ���� ����');
    WHEN others THEN
    dbms_output.put_line('�̹� ������ �߸��� ���ڳ� �����Ͱ��� �ƴմϴ�.');
END;