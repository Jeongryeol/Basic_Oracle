--트리거 비활성화 시키기
--ALTER trigger tri_test1 disable;

--ALTER trigger tri_test2 disable;

-------------------------------------------------------------------------------
--[연습문제]
--7369사번은 수정할 수 없도록 하는 트리거를 작성해보시오.
-------------------------------------------------------------------------------

--HINT
CREATE OR REPLACE TRIGGER tri_test3
    BEFORE
    UPDATE OF ename ON emp
    FOR EACH ROW
DECLARE
    s_msg VARCHAR2(100) := '';
BEGIN
    s_msg:='Trigger발생';
    dbms_output.put_line('반영전 emp_name ==> '||:old.ename);
    dbms_output.put_line('반영후 emp_name ==> '||:new.ename);
END;


UPDATE emp
   SET ename = '김유신'
 WHERE empno = 9001
 
 
 
 
CREATE OR REPLACE TRIGGER tri_test3
    BEFORE
    UPDATE ON emp
    FOR EACH ROW
DECLARE
    s_msg VARCHAR2(100) := '';
BEGIN
    IF :old.empno=7369 THEN
        s_msg:='7369사번은 수정할 수 없습니다.';
    END IF;   
    raise_application_error(-20001,s_msg);
END;


UPDATE emp
   SET ename ='안된다'
 WHERE empno = 7369