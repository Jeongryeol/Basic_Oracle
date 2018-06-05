CREATE OR REPLACE PROCEDURE proc_test3(tmp IN varchar2)
IS
    v_dept dept%rowtype; --v_dept 라는 변수를 가지고 dept컬럼정보에 접근할 수 있다.
BEGIN
    SELECT deptno, dname, loc INTO v_dept.deptno, v_dept.dname, v_dept.loc
      FROM dept --실행부의 SELECT문은 1개밖에 조회할 수 없기 때문에
     WHERE deptno = 10; --조건을 걸어주어야 한다.
   dbms_output.put_line(v_dept.deptno||','||v_dept.dname||','||v_dept.loc);
END;