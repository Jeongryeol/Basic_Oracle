--�ý��۽ð��� �ܺη� �������� ���� PL/SQL
CREATE OR REPLACE PROCEDURE proc_selectinto(tmp IN varchar2,msg OUT varchar2)
IS
    v_date varchar2(30) :='';
BEGIN
    SELECT TO_CHAR(sysdate,'YYYY-MM-DD') INTO v_date
      FROM dual;
    msg:=v_date;
END;