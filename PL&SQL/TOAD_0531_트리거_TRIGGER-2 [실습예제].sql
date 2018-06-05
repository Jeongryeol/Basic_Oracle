--트리거 비활성화 시키기
ALTER trigger tri_test1 disable;

-------------------------------------------------------------------------------
--[실습예제]
--매주 목요일에는 emp테이블에
--데이터 변경을 할 수 없도록 차단하고 싶다.
--    트리거명 : tri_test2
--    SELECT TO_CHAR(sysdate,'dy') FROM dual 
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tri_test2
BEFORE
UPDATE OR DELETE OR INSERT on emp
BEGIN
    IF (TO_CHAR(sysdate,'DY') IN ('목')) THEN
        raise_application_error 
        (-20500,'목요일에는 데이터를 변경할 수 없습니다.');
    END IF;
END;


--테스트

DELETE FROM emp WHERE empno=7566

INSERT INTO emp(empno,ename) VALUES(9001,'이순신')

commit;
