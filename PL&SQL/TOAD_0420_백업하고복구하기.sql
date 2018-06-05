SELECT deptno, dname, loc FROM dept


SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp
-- 관계가 있는 테이블은 모두 백업을 받아두어야 모두 복구 가능함.


SELECT qna_writer, qna_date, qna_title, qna_contents, qna_count, qna_no
    FROM qnaboard
--데이터를 삭제하고 싶을 땐 어떡하지?
--삭제시 팀장의 컨펌을 반드시 받아야 한다.
--삭제한 경우 데이터베이스와 타개발자에게 피해를 주기 때문에 신중하게 해야하는 문제임.
--복구하는 방법을 알아야함.


DELETE FROM dept WHERE deptno = 30
--조건에 맞지 않은 자료는 삭제할 수 없다.


DELETE FROM dept WHERE deptno = 40
--무셜성 제약조건 위배 : 애비없는 자식이 생길수 없기 때문에 보호함
--식제순서
--부모와 자식관계에 놓여있는 테이블을 삭제할때는
--먼저 자식을 삭제(emp)하고 그다음 부모(dept)를 삭제함


rollback;
--단 commit를 한 후에는 복구 불가능 : 실제 물리적 테이블에 데이터를 삭제하는것(commit)


DELETE FROM emp
--전체를 삭제하는 것이므로 와일드카드(*)가 필요없음
commit;
--commit;을 해야 물리적으로 삭제됨.


DELETE FROM dept
--전체를 삭제하는 것이므로 와일드카드(*)가 필요없음
commit;


SELECT * FROM dept

SELECT * FROM emp


SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp
-- 차집합을 이용하여 특정 정보의 값을 추려냄


SELECT deptno FROM emp
MINUS
SELECT deptno FROM dept
--작은집합에서 큰집합을 빼면 결과는 없다



--복구할땐 어떻게 하지?

--복구순서
--부모테이(dept)블을 먼저 추가하고 자식 테이블(emp)을 추가함
--왜냐하면 사원 테이블에 외래키인 deptno가 있으므로 선 조치함