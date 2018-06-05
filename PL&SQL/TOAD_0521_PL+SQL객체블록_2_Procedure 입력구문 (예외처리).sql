--DECLARE
CREATE OR REPLACE PROCEDURE proc_exception1(p_temp IN varchar2)
IS--담당자가 만들어둔 프로시저를 자바에서 호출하기 위해서 반드시 이해해야하는 기능
--선언
  --이름  타입      초기화  값;
    n_i number(10) := 0;
BEGIN
    n_i := '이순신';
    dbms_output.put_line('요기');
EXCEPTION--예외처리부
    WHEN invalid_number THEN
    dbms_output.put_line('이번 에러는 잘못된 숫자에 대한 에러');
    WHEN value_error THEN
    dbms_output.put_line('이번 에러는 잘못된 데이터에 대한 에러');
    WHEN others THEN
    dbms_output.put_line('이번 에러는 잘못된 숫자나 데이터값은 아닙니다.');
END;