CREATE OR REPLACE PROCEDURE proc_cursor_attribute2(p_empno IN VARCHAR2)
IS
    t_emp emp%rowtype;--emp테이블에 있는 모든 컬럼을 변수로 쓰겠다는 의미 
    cursor c_emp--커서추가 후 SELECT문을 넣음 (INTO 빼고 넣음)
    is
      SELECT empno, ename
        FROM emp
       WHERE empno = p_empno;
BEGIN
    open c_emp;--커서추가 후 열어둠
    LOOP
        -- 1. 파싱  2. 실행계획  3. 옵티마이저 전달   4. 오픈 커서배치  패치(메모리에 올려줌)
        fetch c_emp INTO t_emp.empno, t_emp.ename;
        exit when c_emp%notfound;
        dbms_output.put_line(t_emp.empno||', '||t_emp.ename);
    END LOOP;
    close c_emp;
    EXCEPTION
        WHEN others THEN
        dbms_output.put_line('<<<ERROR>>>');
        dbms_output.put_line('에러코드:'||sqlcode);
        dbms_output.put_line('성명:'||t_emp.ename);
END;


exec proc_cursor_attribute2(7566);--SELECT INTO 문이 성립되어서 IF문이 작동됨

exec proc_cursor_attribute2(300);--SELECT INTO 문이 성립되지않아 바로 오류가 생김

exec proc_cursor_attribute2(3000);

exec proc_cursor_attribute2(7903);