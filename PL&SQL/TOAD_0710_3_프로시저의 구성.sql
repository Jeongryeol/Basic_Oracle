--프로시저는 오브젝트가 되기때문에 저장과 호출이 가능해지고, 재사용성으로 이어져서 업무효율이 높아진다.
--@name   proc_ : procedure
--@param  p_ : parameter용 변수
CREATE OR REPLACE PROCEDURE proc_emptest(p_empno IN number)
IS
    --선언부
    v_name VARCHAR2(20) := '이순신';
    v_emp emp%rowtype;
BEGIN
    --실행문
    SELECT empno, job
      INTO v_emp.empno, v_emp.job
      FROM emp
     WHERE empno = p_empno;
      dbms_output.put_line(v_emp.empno||','||v_emp.job);
END;

--실행하는 방법 1 : 기본
exec proc_emptest(7566)

--실행하는 방법 2 : 허용하는 형태 (생성된 프로시저에 또 프로시저를 넣는것은 안되지만..)
begin
proc_emptest(7369);
end;

