SELECT ename FROM emp WHERE empno='7566'--Oracle에서 자동형전환 해줌

--컬럼에 새로운 값 입력하기
--(JAVA 로 오라클 컨트롤하는 것으로 연계하기위해 이해하는 과정)
INSERT INTO dept(deptno,dname,loc) VALUES(50,'인사','서울');

--commit되기 전에는 입력되는것은 아님. 또한, PK때문에  무결성 문제가 발생함

--변수처리하면 어떻게 되나? (사용자가 입력하는 자리가 됨)
INSERT INTO dept(deptno,dname,loc) VALUES(:x,:y,:z);



--JAVA에서 입력하도록 하는 메소드를 작성하기 전에, 어떻게 실행되는지를 보고
--commit하지않고, JAVA에서 실행시켜서 값을 입력해보기 위한 INSERT 과정이해용 SQL
INSERT INTO emp(empno,ename,job, mgr, hiredate, sal, comm, deptno)
       VALUES(9000,'이순신','SALESMAN',7566,'2018-04-21',3300,0,50);

rollback;


--JAVA에서 입력하도록 하는 메소드를 작성하기 전에, 어떻게 실행되는지를 보고
--commit하지않고, JAVA에서 실행시켜서 값을 입력해보기 위한 UPDATE 과정이해용 SQL
UPDATE emp
   SET ename    = '김유신'
      ,job      = 'CLERK'
      ,hiredate = '2018-05-03'
 WHERE empno=9000
 
rollback;


--JAVA에서 입력하도록 하는 메소드를 작성하기 전에, 어떻게 실행되는지를 보고
--commit하지않고, JAVA에서 실행시켜서 값을 입력해보기 위한 DELETE 과정이해용 SQL
--DELETE는 rowlevel로 지우는 예약어 ( 반드시 WHERE절이 필요함 / 아니면 다 테이블 통째로 날아감 )
DELETE FROM emp
 WHERE empno=9000

rollback;


--JAVA에서 입력하도록 하는 메소드를 작성하기 전에, 어떻게 실행되는지를 보고
-- JAVA에서 실행시켜서 값을 입력해보기 위한 SELECT 과정이해용 SQL
SELECT empno,ename,job,deptno FROM emp
 WHERE empno >=7700