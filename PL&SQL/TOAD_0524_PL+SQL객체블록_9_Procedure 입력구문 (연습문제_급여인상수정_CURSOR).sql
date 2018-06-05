[ 연습문제 ]
우리회사에서 근무하는 사원들 중에서 부서번호가 30인 사원들의 급여 평균을 구하고
그 평균보다 많이 받는 사원은 10%인상을, 적게받는 사원은 20%인상을 적용하여
테이블에 반영하는 프로시저를 작성하시오.
    -> 프로시저 이름 : proc_emp_update_salary();

SELECT
    t_e.empno, t_e.ename, t_e.deptno, t_e.sal
  FROM dept t_d, emp t_e
 WHERE t_d.deptno = 30 AND t_d.deptno = t_e.deptno
 
SELECT
    TO_CHAR(AVG(t_e.sal),'999,999.99')
  FROM dept t_d, emp t_e
 WHERE t_d.deptno = 30 AND t_d.deptno = t_e.deptno

CREATE OR REPLACE PROCEDURE proc_emp_update_salary(p_deptno IN NUMBER, msg OUT VARCHAR2)
IS
    t_emp emp%rowtype;
    t_dept dept%rowtype;
    n_rate number(3,1):=0;
    n_avgsal number(7,2) :=0;
    cursor c_emps--커서추가 후 SELECT문을 넣음 (INTO 빼고 넣음)
    is
        SELECT empno, ename, deptno, sal
          FROM emp
         WHERE deptno = p_deptno;
BEGIN
    dbms_output.put_line('조건에 따른 급여인상을 CURSOR로 다중출력하기');
    SELECT AVG(sal) INTO n_avgsal
      FROM emp
     WHERE deptno = p_deptno;
    
    OPEN c_emps;
    LOOP
        fetch c_emps INTO t_emp.empno, t_emp.ename,t_emp.deptno,t_emp.sal;
        exit when c_emps%notfound;
        dbms_output.put_line(t_emp.empno||', '||t_emp.ename||', '||t_emp.deptno||', '||t_emp.sal);
        IF (t_emp.sal > n_avgsal) THEN
            n_rate := 1.1;
        ELSE
            n_rate := 1.2;
        END IF;
        msg := msg||t_emp.ename||'님은 '||n_rate||'인상률로 급여는 '||t_emp.sal*n_rate||'입니다.'||CHR(13);
        dbms_output.put_line(msg);
    END LOOP;
    
     --4.업데이트문 추가하기
    UPDATE emp SET sal=t_emp.sal*n_rate
     WHERE empno=t_emp.empno--골라내진 사원번호에 해당하는 사람들만 적용한다
     --dept를 조건으로 거는 경우도 결과는 같을 수있지만, 중간에 다른 조건이 걸려있는 경우 올바르게 대치되지 않을 수 있다.
    
    --commit;--업데이트한 내용을 DB서버에 관여하고싶다.
    IF c_emps%found THEN
        dbms_output.put_line('<<<조회결과있음>>>');
    END IF;
    IF c_emps%rowcount = 1 THEN
        dbms_output.put_line('<<<조회결과>>>');
        dbms_output.put_line('사번'||t_emp.empno);
        dbms_output.put_line('성명'||t_emp.ename);
    ELSIF c_emps%rowcount = 0 THEN
        dbms_output.put_line('<<<에러>>>');
        dbms_output.put_line('<<<조회된 데이터가 없습니다.>>>');
    ELSIF c_emps%rowcount > 1 THEN
        dbms_output.put_line('<<<에러>>>');
        dbms_output.put_line('<<<조회된 데이터가 너무 많습니다.>>>');
    END IF;
    
    CLOSE c_emps;
    
END;

exec proc_emp_update_salary(30,:msg);

rollback;

--[  모  범  답  안  ]--------------------------------------------------------------------
--풀이순서
-- 1) 변수선언 - 평균을 담을 변수, 인상률을 담을 변수
-- 2) 커서정의 - CURSOR IS SELECT empno, ename, sal FROM emp WHERE dept = 파라미터값(부서번호)
--          모든 사원이 변하는것이더라도, 사원에따라 인상률이 다르기때문에
--          UPDATE문에서 sal의 변경을 적용하는 기준은 사원번호가 됨. 그러므로 
-- 3) 평균구하기 - 1건 : 평균을 담을 변수의 avg -> 그룹함수 -> SELECT ... INTO ...
-- 4) 커서 OPEN
-- 5) 커서의 결과가 다중이므로 LOOP
-- 6) fetch : 커서이동을 제어함 ( 사원번호, 이름, 급여 제어 ) 제어하여 결과도출
-- 7) 급여액과 평균급여액 비교 : 많니? 적니? 
-- 8) UPDATE
---------------------------------------------------------------------------------------