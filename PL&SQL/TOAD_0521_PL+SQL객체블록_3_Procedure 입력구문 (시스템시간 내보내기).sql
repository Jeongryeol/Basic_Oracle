--시스템시간을 외부로 내보내기 위한 PL/SQL
CREATE OR REPLACE PROCEDURE proc_selectinto(tmp IN varchar2,msg OUT varchar2)
IS
    v_date varchar2(30) :='';
BEGIN
    SELECT TO_CHAR(sysdate,'YYYY-MM-DD') INTO v_date
      FROM dual;
    msg:=v_date;
END;