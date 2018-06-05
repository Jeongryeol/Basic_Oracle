--Procedure 생성 구문
CREATE OR REPLACE PROCEDURE proc_test1
(v_name IN VARCHAR2, msg OUT VARCHAR2)
--msg OUT 타입: Procedure 객체생성된 결과값을 자바에서 받는 예약어
IS
BEGIN
    dbms_output.put_line('이름'||v_name);
    msg:='사원명'||v_name;
END;

--------------------------------------------------------------------------------
--cmd 에서 Procedure OUT 확인하기
--Toad 접속
sqlpuls scott/tiger

SQL> variable msg varchar2(100);  --변수 msg 선언
SQL> exec proc_test1('김유신',:msg);--변수 msg 호출 ( :변수이름 )

--PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> print msg;                   --변수 출력 선언

MSG
--------------------
사원명김유신

SQL>
--------------------------------------------------------------------------------


--실습구문
CREATE OR REPLACE PROCEDURE proc_test1_p
(v_name IN VARCHAR2,v_date IN VARCHAR2
,msg OUT VARCHAR2,hiredate OUT VARCHAR2)
IS
BEGIN
    dbms_output.put_line('이름 : '||v_name);
    msg:='사원명 : '||v_name;
    dbms_output.put_line('일자 : '||v_date);
    hiredate:='고용일자 : '||v_date;
END;




CREATE OR REPLACE PROCEDURE proc_test2
(pempno IN number, oename OUT varchar2)
IS
    v_ename varchar2(30);
BEGIN --BEGIN~END 사이의 SELECT 문은 한번에 한개만 조회가능 / CURSOR?를 사용해서 다중조회 해야한다고 함.
    SELECT ename INTO v_ename --변수에 저장할때 INTO 사용
      FROM emp
     WHERE empno = pempno;
     oename := v_ename;
END;