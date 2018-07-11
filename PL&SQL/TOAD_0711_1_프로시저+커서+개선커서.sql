/*  [문제상황]
    우리 회사에서 근무하는 사원들 중에서
    인센티브를 받는 사원들의 사원번호, 사원명, 인센티브금액을
    인센티브금액 기준 내림차순으로 출력하는 프로시저를 작성하시오.
*/

--SQL문 선행작성
SELECT empno AS "사원번호",ename AS "사원명",LPAD(comm||' $',12) AS "인센티브금액"
  FROM emp WHERE comm > 0 ORDER BY comm desc;
 
--프로시저 기본꼴 작성
CREATE OR REPLACE PROCEDURE proc_empList(p_text IN VARCHAR2)
IS
    --선언부
    v_emp emp%rowtype;--테이블의 조회결과를 담을 자리 생성 (변수 선언)
    --커서선언하기
    CURSOR cur_emp IS
        SELECT empno,ename,comm--프로시저는 알리아스명을 사용하면 인식하지 못하는구나...
          FROM emp WHERE comm > 0 ORDER BY comm desc;
BEGIN
    --실행부
    dbms_output.put_line('사번   이름    인센티브');
    dbms_output.put_line('--------------------');
    OPEN cur_emp;
    LOOP
        FETCH cur_emp INTO v_emp.empno, v_emp.ename, v_emp.comm;
        EXIT WHEN cur_emp%NOTFOUND;--담기 종료조건 설정
        dbms_output.put_line(v_emp.empno||', '||v_emp.ename||', '||v_emp.comm);
    END LOOP;
    CLOSE cur_emp;
END;

--프로시저 테스트
exec proc_empList('test');


--모범답안
CREATE OR REPLACE PROCEDURE proc_empList2(temp IN VARCHAR2)
IS
    v_emp emp%rowtype;--테이블의 조회결과를 담을 자리 생성 (변수 선언)
    CURSOR cur_emp IS--커서생성
    SELECT empno, ename, comm FROM emp
     WHERE comm IS NOT NULL AND comm > 0
     ORDER BY comm desc;--커서에 담을 구문
BEGIN
    dbms_output.put_Line('사번     이름     인센티브');
    dbms_output.put_Line('------------------');
    --자동으로 커서를 열고 닫는 방식 개선FOR문
    --FOR 변수 IN 커서 LOOP (닫기조건문;반복수행문;) END LOOP;
    FOR v_emp IN cur_emp LOOP
        dbms_output.put_Line(v_emp.empno||'  '||v_emp.ename||'   '||v_emp.comm);
    END LOOP;
END;

--모범답안 프로시저 테스트
exec proc_empList2('test');