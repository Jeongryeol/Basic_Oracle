CREATE OR REPLACE TRIGGER tri_test1
BEFORE
UPDATE OR DELETE OR INSERT on emp
DECLARE
    s_msg VARCHAR2(100) := '';
BEGIN
    IF updating THEN
        dbms_output.put_line('===> update');
    END IF;
    IF deleting THEN
        dbms_output.put_line('===> delete');
    END IF;
    IF inserting THEN
        dbms_output.put_line('===> insert');
    END IF;
END;


DELETE from emp WHERE empno=7566

INSERT INTO emp(empno, ename) VALUES(9001,'�̼���')

UPDATE emp SET ename = 'ȫ�浿' WHERE empno = 9001

rollback;

--Ʈ���� ��Ȱ��ȭ ��Ű��
ALTER trigger tri_test1 disable;