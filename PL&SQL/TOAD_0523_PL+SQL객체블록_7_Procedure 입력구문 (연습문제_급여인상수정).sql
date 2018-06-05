[ 연습문제 ]
    우리회사에 근무하는 사원중에서 사원번호가 7566인 사원의 급여를 인상하고자 한다.
    인상율은 그 사원이 근무하는 부서의 평균급여보다 많이 받고 있으면 10%인상을 적용하고
    적게 받고 있으면 20%인상을 적용한 급여액을 수정하는 프로시저를 만들어내세요.

    프로시저 이름 : proc_emp_sal_update.sql


EDIT emp

SELECT deptno FROM emp WHERE empno = 7566

SELECT deptno, avg(sal) FROM emp
 WHERE deptno=(SELECT deptno FROM emp WHERE empno = 7566)
 GROUP BY deptno

SELECT empno,ename,DECODE(SIGN(sal-(SELECT AVG(sal) FROM emp)),1,'10%인상',-1,'20%인상') AS "인상률"
  FROM emp
 WHERE empno = 7566
 
CREATE OR REPLACE PROCEDURE proc_emp_sal_update(v_empno IN NUMBER)
IS
    v_deptno NUMBER(10);
    v_avgsal NUMBER(10);
    v_sal    NUMBER(10);
BEGIN   
    SELECT avg(sal) INTO v_avgsal FROM emp
     WHERE deptno=(SELECT deptno FROM emp WHERE empno = v_empno);
    SELECT sal INTO v_sal FROM emp WHERE empno=v_empno;
    IF( v_sal>v_avgsal )    THEN sal := v_sal*1.1;
    ELSIF( v_sal<v_avgsal ) THEN sal := v_sal*1.2;
    END IF;
    dbms_output.put_line(v_empno||'의 인상된 연봉금액은 '||v_sal);
END;



------[ 모 범 답 안 ]--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_emp_sal_update(p_empno IN NUMBER, msg OUT VARCHAR2)
IS
    v_ename VARCHAR2(30);
    n_sal NUMBER(7,2);
    n_avgsal NUMBER(9,2);
    n_rate NUMBER(3,1);
BEGIN   
    --1.입력한 사원번호를 조건으로 테이블로부터 사원정보 먼저 읽어오기
    SELECT ename, sal INTO v_ename, n_sal FROM emp
     WHERE empno = p_empno;
    --2.해당부서의 평균 급여를 구하기
    SELECT AVG(sal) INTO n_avgsal FROM emp
     WHERE deptno = (SELECT deptno FROM emp WHERE empno = p_empno);
    --3.평균급여와 해당사원의급여를 비교하D기
    IF (n_sal > n_avgsal) THEN
        n_rate := 1.1;
    ELSE
        n_rate := 1.2;
    END IF;
    --4.업데이트문 추가하기
    UPDATE emp SET sal=sal*n_rate
     WHERE empno=p_empno;
    commit;--업데이트한 내용을 DB서버에 관여하고싶다.
    msg := v_ename||'님은 '||n_rate||'인상률로 급여는 '||n_sal*n_rate||'입니다.';
END;

--5.테스트하기
exec proc_emp_sal_update(7566);

SELECT * FROM emp WHERE empno = 7566;

rollback;