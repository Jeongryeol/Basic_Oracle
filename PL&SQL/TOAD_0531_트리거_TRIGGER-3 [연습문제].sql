--Ʈ���� ��Ȱ��ȭ ��Ű��
--ALTER trigger tri_test1 disable;

--ALTER trigger tri_test2 disable;

-------------------------------------------------------------------------------
--[��������]
--7369����� ������ �� ������ �ϴ� Ʈ���Ÿ� �ۼ��غ��ÿ�.
-------------------------------------------------------------------------------

--HINT
CREATE OR REPLACE TRIGGER tri_test3
    BEFORE
    UPDATE OF ename ON emp
    FOR EACH ROW
DECLARE
    s_msg VARCHAR2(100) := '';
BEGIN
    s_msg:='Trigger�߻�';
    dbms_output.put_line('�ݿ��� emp_name ==> '||:old.ename);
    dbms_output.put_line('�ݿ��� emp_name ==> '||:new.ename);
END;


UPDATE emp
   SET ename = '������'
 WHERE empno = 9001
 
 
 
 
CREATE OR REPLACE TRIGGER tri_test3
    BEFORE
    UPDATE ON emp
    FOR EACH ROW
DECLARE
    s_msg VARCHAR2(100) := '';
BEGIN
    IF :old.empno=7369 THEN
        s_msg:='7369����� ������ �� �����ϴ�.';
    END IF;   
    raise_application_error(-20001,s_msg);
END;


UPDATE emp
   SET ename ='�ȵȴ�'
 WHERE empno = 7369