--Ʈ���� ��Ȱ��ȭ ��Ű��
ALTER trigger tri_test1 disable;

-------------------------------------------------------------------------------
--[�ǽ�����]
--���� ����Ͽ��� emp���̺�
--������ ������ �� �� ������ �����ϰ� �ʹ�.
--    Ʈ���Ÿ� : tri_test2
--    SELECT TO_CHAR(sysdate,'dy') FROM dual 
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tri_test2
BEFORE
UPDATE OR DELETE OR INSERT on emp
BEGIN
    IF (TO_CHAR(sysdate,'DY') IN ('��')) THEN
        raise_application_error 
        (-20500,'����Ͽ��� �����͸� ������ �� �����ϴ�.');
    END IF;
END;


--�׽�Ʈ

DELETE FROM emp WHERE empno=7566

INSERT INTO emp(empno,ename) VALUES(9001,'�̼���')

commit;
