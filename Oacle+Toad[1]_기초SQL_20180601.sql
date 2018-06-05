■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

 " 필 독 !! "
--SQL문의 특성상 공백이 있는 줄로 구문을 구분하기 때문에, 편집과 열람에 어려움이 있어서 모두 붙여서 정리합니다.
--그리므로 모든 구문은 개별로 복사하고 다른 장소에서 테스트해보길 권장합니다.  

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[-] 예약기호 :: 조회결과에 영향을 미치는 예약어
  1. "값 합치기"  { || }      (컬럼1 혹은 '문자1')||(컬럼2 혹은 '문자2')
  2. "입력값 받기" { :x }      팝업창으로부터 사용자가 값을 입력하게끔 변수화
  3. "초기화"    { :=x }     해당 값이 변경되었음을 알리는 제어용 예약어
  4. "힌트문"    { /*+ */ }     /*+index_desc(emp pk_emp)*/ (오류발생시 무시됨)
  5. '싱글쿼테이션' { ' ' }     데이터값  ex. 조건절에 사용되는 'SMITH'
  6. "더블쿼테이션" { " " }     치환희망값 ex. Alias로 사용되는 "별칭"
  7. "아스터리스크" { * }       해당 테이블의 모든 컬럼을 지칭하는 기호

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[-] 효과적인 SQL문을 만들기 위하여..
  1. "실행계획 보기" ( Ctrl + E : http://blog.naver.com/sophie_yeom/220891529668 )
  2. "개선코드 고민하기" : 업무담당자의 요청사항을 분석하고 코드짜기 전 결과형태 그리기 / 
     경우의 수 줄이기 / 서버요청횟수 줄이기 / 정확한 별칭 사용하기
  3. "옵티마이저의 작동모드"
     1)rule base optimizer - 15가지의  규칙 기준에 따라 실행계획을 세운다.
     --(수동카메라처럼)  개발자가 생각할 수 있는 실행계획으로 작동한다.
     2)cost base optimizer - 작동에 필요한 비용을 계산해서 적은 쪽으로 실행계획을 세운다.
     --(자동카메라처럼) 개발자의 생각을 반영하지만, 데이터의 분포도 계산이후 정확도가 높아짐
  4. "즉, 원소의 개수를 줄여서 비교하고 조회한다."
  
[-] SQL 실행계획
  1. PARSING(파싱) : 일련의 문자열을 의미있는 토큰(token)으로 분해하고 다시 파스 트리(parse tree)를 만드는 과정
  2. DBRMS 기반한 실행계획 설정
  3. 옵티마이저 실행계획 수령
  4-1. OPEN(오픈) : 테이블 접근 (커서기준 열람 : Default는 TOP - isLast / rs.isLast)
  4-2. FETCH(페치) : 커서이동하며 열람 + 메모리(RAM) 열람
  4-3. 결과를 테이블에 담음
  
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  
[-] 복합SQL문 기초구성 : 서브쿼리 / 인라인뷰
--서브쿼리 기본꼴
SELECT
  FROM 집합
 WHERE 컬럼명 = (SELECT문) --서브쿼리

--인라인뷰 기본꼴
SELECT
  FROM (SELECT절) --인라인뷰

"공통점"
    SELECT문이 2개 이상이다.

"주의사항"
    서브쿼리에서 사용된 컬럼명은 바깥쪽 주쿼리 SELECT문에서는 사용이 불가능함.
    FROM절에 사용한 테이블명은 사용할 수 있지만, 없는 컬럼명은 사용이 불가능하다.

    인라인뷰에서 사용하지 않은 컬럼과 서브쿼리에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다.
    또한, 테이블엔 존재하더라도 인라인뷰에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다.


■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

<001> SELECT :: 조회 + 조인

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[-] "★★★★" SELECT문의 문법순서 "★★★★"

  SELECT (조회하고자하는 컬럼명 리스트) --그룹별칭에 따른 각 컬럼지정 필수
DISTINCT (중복을 제거하고자 하는 컬럼명 리스트)
    FROM (조회하고자하는 테이블명 리스트) -- 그룹별칭지정
   WHERE (조회하고자하는 로우의 조건식) --그룹별칭에 따른 각 컬럼지정 필수
   GROUP BY (동일한 값을 갖는 로우들을 한 그룹으로 묶음) --그룹함수 외 일반컬럼 모두 적용
  HAVING (로우들의 그룹이 만족해야하는 조건식)
   ORDER BY (결과 로우들의 정렬순서 제시)

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


[A] 조회하기 + 별칭부여하기
SELECT 컬럼명1, 컬럼명2, ..., 컬럼명? as "별칭", 컬럼명? "별칭"
  FROM 집합
    --해당 집합으로부터 원하는 컬럼을 골라서 조회할 수 있다.
    --(즉, 해당 집합에 없는 컬럼은 조회할 수 없다.)
    --★★컬럼명 뒤에 AS"별칭"을 부여하여 조회결과에 반영할 수 있다.
    --★★SELECT과 FROM절 사이에 추가되는 값이 추가될수록 컬럼이 늘어난다.
    --SELECT문과 FROM 절 사이에는 계산값이 들어올 수 있고, FROM절 이하의 dual은 가상테이블이다.( 옵티마이저 처리 )
    
    --★★인라인뷰에서 사용하지 않은 컬럼과 서브쿼리에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다
    --★★또한, 테이블엔 존재하더라도 인라인뷰에서 사용하지 않은 컬럼은 주쿼리에서 사용할 수 없다
    

SELECT empno, ename, deptno
  FROM emp

SELECT "사원번호", "사원명", deptno
  FROM (SELECT empno AS "사원번호" , ename "사원명", deptno
  FROM emp)
    --일반적으로 별칭부여할때의 AS(Alias)는 생략가능하다.
    --FROM절에서 임시공간으로 생성되는 인라인뷰에서 별칭을 부여할 경우,
    --인라인뷰밖에서는 별칭으로 조회해야한다.

---------------------------------------------------------------------------------

[B] 조인하기 : http://www.gurubee.net/lecture/1020
SELECT t1.컬럼명1, ..., t2.컬럼명1, ... FROM 집합1 t1, 집합2 t2
    --조인(Join) : 2개 이상의 집합을 동시에 조회하는 것
    --조인하는 경우, 반드시 집합명.컬럼명 으로 컬럼을 구체적으로 지정한다.
    --아무런 조건없이 조회하는 것은 n-n대응으로 "카타시안의 곱"으로 결과가 나타난다.

SELECT e.empno, e.ename, e. deptno
  FROM emp e, dept d    


[B-1a] "EQUALS JOIN"
-- 가장 일반적으로 사용하는 Equality Condition(=)에 의한 조인이다
-- Equi join의 성능을 높이기 위해서는 Index 기능을 사용하는 것이 좋다.

-- dept 테이블과 emp 테이블을 조인하는 예제
SELECT e.empno, e.ename, d.dname
  FROM dept d, emp e
 WHERE d.deptno = e.deptno;



[B-1b] "INNER JOIN" 
-- 두 테이블간의 조인 조건을 만족하는 ROW만 리턴함
-- 콤마(,) 대신 INNER JOIN을 사용 할 수 있으며, INNER는 생략 가능하다. Join 조건은 ON 절에 온다.

-- INNER JOIN절을 이용하여 조인하는 예제
SELECT e.empno, e.ename, d.dname
  FROM dept d 
 INNER JOIN emp e
    ON d.deptno = e.deptno;



[B-1c] "NATURAL JOIN"
--NATURAL JOIN을 사용 하면 동일한 컬럼을 내부적으로 모두조인 하므로, ON절이 생략 가능하다
--NATURAL JOIN의 단점은 동일한 이름을 가지는 칼럼은 모두 조인이 되는데
--USING 문을 사용하면 컬럼을 선택해서 조인을 할 수가 있다.

-- JOIN~USING절을 이용하여 조인하는 예제
SELECT e.empno, e.ename, deptno 
  FROM emp e 
  JOIN dept d 
 USING (deptno);



[B-2] "Non-EQUI JOIN"
--테이블의 어떤 column도 Join할 테이블의 column에 일치하지 않을 때 사용하고, 조인조건은 동등( = )이외의 연산자를 갖는다.
--BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN

--거의 사용하지 않는다
SELECT e.ename,e.sal,s.grade
  FROM emp e, salgrade s
  WHERE e.sal 
BETWEEN s.losal 
    AND s.hisal;



[B-3] "SELF JOIN"
-- Equi Join과 같으나 하나의 테이블에서 조인이 일어나는 것이 다르다.
-- 같은 테이블에 대해 두 개의 alias를 사용하여 FROM절에 두 개의 테이블을 사용하는 것 처럼 조인한다.

-- 사원의 매니저명을 조회하는 Self Join 예제
SELECT e.ename, a.ename "Manager"
  FROM emp e, emp a
 WHERE e.empno = a.mgr;
 
 

[B-3] "OUTTER JOIN"  : http://www.gurubee.net/lecture/1021
-- Equi Join은 조인을 생성하려는 두 개의 테이블의 한쪽 컬럼에서 값이 없다면 테이터를 반환하지 못한다.
-- 동일 조건에서 조인 조건을 만족하는 값이 없는 행들을 조회하기 위해 Outer Join을 사용 한다.

-- Outer Join 연산자는 "(+)" 이다.
-- 조인시 값이 없는 조인측에 "(+)"를 위치 시킨다.
-- Outer Join 연산자는 표현식의 한 편에만 올 수 있다.
-- Outer Join을 사용하는 테이블에 추가로 조건절이 있다면 (+)연산자를 모두 해야 한다.

-- ename LIKE 조건절에 (+)연산자를 추가해야 정상적으로 데이터가 조회 된다. 
SELECT DISTINCT(a.deptno), b.deptno
  FROM emp a, dept b
 WHERE a.deptno(+) = b.deptno
   AND a.ename(+) LIKE '%';
 
DEPTNO  DEPTNO
 ------- --------
     10       10
     20       20
     30       30
              40


[B-3a] "LEFT OUTER JOIN"
--LEFT OUTERL JOIN은 오른쪽 테이블(아래 예제에서 emp테이블)에 조인시킬 컬럼의 값이 없는 경우 사용한다
--조인문 왼쪽에 있는 테이블의 모든 결과를 가져온 후 오른쪽 테이블의 데이터를 매칭하며, 매칭되는 데이터가 없는 경우 NULL 매칭


-- LEFT OUTER JOIN 조인 예제
SELECT DISTINCT(e.deptno), d.deptno
  FROM dept d 
  LEFT OUTER JOIN emp e
  ON d.deptno = e.deptno; 
  
  
[B-3b] "RIGHT OUTER JOIN"
--RIGHT OUTERL JOIN은 왼쪽 테이블(아래 예제에서 emp테이블)에 조인시킬 컬럼의 값이 없는 경우 사용한다.
--조인문 오른쪽에 있는 테이블의 모든 결과를 가져온 후 왼쪽 테이블의 데이터를 매칭하며, 매칭되는 데이터가 없는 경우 NULL 매칭

-- RIGHT OUTER JOIN 조인 예제
SELECT DISTINCT(e.deptno), d.deptno
  FROM emp e 
 RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;
    
    
[B-3c] "FULL OUTER JOIN"
--FULL OUTERL JOIN은 양쪽 테이블 모두 Outer Join걸어야 하는 경우 사용 한다.

-- FULL OUTER JOIN 조인 예제
SELECT DISTINCT(e.deptno), d.deptno
  FROM emp e 
  FULL OUTER JOIN dept d
    ON e.deptno = d.deptno;   




---------------------------------------------------------------------------------

[C] 조건에 따라 결과 조회하기

[C-1] 선분조건-1 :: WHERE >= ... ( AND ... )

SELECT 컬럼명1, 컬럼명2, ... FROM 집합 WHERE 비교조건식
    --해당 집합의 컬럼을 조회할때, 특정 조건에 맞는 결과만을 조회할 수 있다.
    --WHERE 조건식은 어느 한 집합의 조건만 만족하거나,
    --집합간의 결과를 맞추는 조건을 설정하는 것도 가능하다.
      >= 크거나 같다(이상), > 크다(초과), = 같다 (점조건), < 작다(미만), <= 작거나 같다(이하) 

SELECT e.empno, e.ename, e. deptno, d.loc
  FROM emp e, dept d
 WHERE d.deptno >= 30
   AND e.empno >= 7400
   AND e.deptno = d.deptno --PK와 FK를 연결시켜서 2집합을 조인하여 조회함

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-2] 선분조건-2 :: BETWEEN ... AND ....

SELECT 컬럼명1, 컬럼명2, ... FROM 집합 WHERE 컬럼명 BETWEEN A AND B 
    --BETWEEN 조건식은 구간을 설정한다.
    
SELECT empno FROM emp WHERE empno BETWEEN 7300 AND 7400

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-3] 선분조건-3 :: LIKE
--LIKE 조건식은 문자열의 패턴을 검색할 때 사용하는 조건식이다.

--예를 들어, 사원 테이블에서 사원이름이 ‘A’로 시작되는 사원을 조회하는 쿼리를 작성한다면 다음과 같이 LIKE 조건식을 사용한다.
SELECT ename
  FROM emp
 WHERE ename LIKE 'A%'
 ORDER BY ename;

 EMP_NAME
---------------------
 ADAMS
 ALLEN



--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-3] 점조건-1 :: = 같다, !=같지않다 (점조건)

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-4] 점조건-2 :: (A,B)IN(a,b) (다수점조건) 

<예제> "tdept에서 부서코드와 boss_id를 읽어서[부서장의 사원번호]
이 두 개 컬럼이 temp의 부서코드와 사번에 일치하는 사람의 사번과 성명을 읽어오는 쿼리문을 작성하시오"

SELECT emp_id, emp_name
  FROM temp
 WHERE (dept_code, emp_id)
    IN (SELECT dept_code, boss_id FROM tdept)
    --일치하는! 이라고 했으므로 IN구문!!

---------------------------------------------------------------------------------

[A~C] 기초실습문제 :: 서로 다른 두 집합을 하나의 조건으로 조인하기
<<문제상황>>
업무담당자 : "우리회사에 근무하는 사원들 중에서 사번이 7499인 사원이 근무하는 부서명을 알고 싶습니다."

--dname은 emp테이블에 없는 컬럼이므로 사용할 수 없어요.( dname은 dept에 있는 컬럼 )
--dept테이블의 PK인 deptno는 emp테이블에서 FK로 사용되므로 deptno를 먼저 찾아줘요.
SELECT deptno as "부서번호"
  FROM emp
 WHERE empno = 7499--부서번호 30 확인
  
--찾아낸 deptno를 기준으로 dept에 있는 dname 컬럼을 찾아줘요.
SELECT dname as "부서명"
  FROM dept
 WHERE deptno = 30--부서명 SALES 확인

--한방에 처리하고 싶어요. ( 실행계획을 더 높게 하자 )
SELECT emp.empno as "부서번호", dept.dname as "부서명"
  FROM emp, dept
 WHERE emp.empno = 7499
   AND dept.deptno = 30--사번이 7499인 사원의 근무부서명 확인






■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

<002> 조회결과 가공함수

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[-] ROWNUM (가상)컬럼명 :: 로우에 번호룰 붙인 가상컬럼생성

SELECT ROWNUM eno, ename FROM emp

"참고"--rownum과 컬럼이 조회된 이후, 조회결과를 정리하는 ORDER BY

SELECT ROWNUM eno, ename FROM emp ORDER BY ename 



---------------------------------------------------------------------------------

[A] 결과값의 형전환 및 출력형식 지정
TO_CHAR(컬럼명,'지정형식')
--숫자타입의 컬럼(NUMBER, DATE)을 문자로 변환

SELECT '\'||TO_CHAR(sal,'999,999')||'만' 연봉 FROM emp
--YEAR : 연도를 알파벳으로     YYYY : 연도를 4자리로  YY : 연도를 2자리로
--MON(TH) : 월을 알파벳으로    MM : 월을 2자리로
--DAY : 일을 알파벳으로        DD : 일을 2자리로
--DDD,DD,DD : 연도,월,일 중의 날짜를 숫자로 표시
--HH : 12시간단위
--HH24 : 24시간단위
--MI : 분을 2자리로
--SS : 초를 2자리로
--AM(A.M.), PM (P.M.) : am인지 pm인지

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

TO_NUMBER(컬럼명)
--문자열로 된 숫자를 숫자로 변환

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

TO_DATE(컬럼명,'YYYY-MM-DD')
--문자열로 된 날짜를 날짜형식으로 변환

TO_DATE(sysdate,'YYYY-MM-DD')
--시스템의 시간을 지정한 형식으로 변환하여 출력함




---------------------------------------------------------------------------------

[B-1] TRUNC(컬럼명,자리수) :: 특정자리수 이하 버림
--소수점을 기준으로 오른쪽(→)으로 한칸 움직이면(+1) 해당자리수 이하를 버림
--소수점을 기준으로 왼쪽(←)으로  한칸 움직이면(-1) 해당자리수 이하를 버림

SELECT TO_CHAR(TRUNC(sal/3,2),'999,999.99') "0.01 버림" FROM emp

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[B-2] ROUND(컬럼명,자리수) :: 특정자리수 이하 반올림
--소수점을 기준으로 오른쪽(→)으로 한칸 움직이면(+1) 해당자리수 이하를 버림
--소수점을 기준으로 왼쪽(←)으로  한칸 움직이면(-1) 해당자리수 이하를 버림

SELECT TO_CHAR(ROUND(sal/3,2),'999,999.99') "0.01 반올림" FROM emp

SELECT TO_CHAR(ROUND(sal/3,3),'999,999.999') "0.001 반올림" FROM emp





---------------------------------------------------------------------------------

[C-1] NVL :: 컬럼의 null값 대체하기
NVL(컬럼명,'대체값')
--컬럼의 형식에 맞추어 대체값을 지정

SELECT NVL(comm,'없음') FROM emp--형식이 맞지않아 에러
SELECT NVL(comm,0) FROM emp--형식일치 후 null값을 0으로 대체

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-2] IS (NOT) NULL :: 컬럼의 null값 찾기
WHERE 컬럼 IS NULL
--해당 컬럼이 NULL값이 들어있는 경우로 제한하는 조건절


SELECT emp_name, hobby FROM TEMP WHERE hobby IS NULL

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

[C-응용] NVL + IS NULL :: 해당 컬럼의 null인 값을 특정 값으로 대체하여 특정값가진 자료 전체출력하기

SELECT emp_name, hobby FROM TEMP --기존결과

SELECT emp_name, NVL(hobby,'노래') FROM TEMP WHERE hobby IS NULL --가공된 결과

SELECT emp_name, 취미 FROM ( SELECT emp_name, NVL(hobby,'노래') 취미 FROM TEMP )
 WHERE 취미 = '노래'--합산 결과





---------------------------------------------------------------------------------

[D] 값에 대하여 특정값을 출력하는 가공함수
SIGN(컬럼명 혹은 값)
--해당값이 양수면 1, 0이면 0, 음수면 -1을 출력함
--두개의 컬럼의 값을 빼서 비교하면 크다와 작다의 비교가 가능함
--DECODE와 연계하면 값에 따른 출력비교가 가능

SELECT SIGN(6) FROM dual

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

DECODE(컬럼명, 참값1, 대치값1, 참값2, 대치값2, ..., 그외대치값)
--해당값에대하여 참값에 해당하는 내용을 옵티마이저가 판단했을때, 
--True로 판단되면 그에 해당하는 대치값으로 대치한다.
--그외대치값을 지정하지않으면 null값이 defaulf로 출력한다. ( null = 모른다 )

SELECT DECODE(SIGN(183-170),1,'키카 크다','키가 작다') FROM dual






---------------------------------------------------------------------------------

[E] LPAD & RPAD :: 문자열 가공함수
LPAD (변수, 길이, 문자)
RPAD (변수, 길이, 문자)
--좌측(LPAD) 혹은 우측(RPAD)에 원하는 길이만큼 특정 문자를 채워서 반환한다.

select LPAD('test', 10, '#') from dual;
-- ######test

select RPAD('test', 10, '#') from dual;
-- test######

select LPAD('test', 2, '#') from dual;
-- te

select RPAD('test', 2, '#') from dual;
-- te

select LPAD('test', 9, '123') from dual;
-- 12312test

select RPAD('test', 9, '123') from dual;
-- test12312







---------------------------------------------------------------------------------

[F] 그룹함수 + GROUP BY + HAVING
--그룹함수는 그룹단위로 한데 묶어서 결과를 출력하는 값이므로,
--일반 컬럼과 함께 출력하기 위해서는 GROUP BY+(그룹함수미적용 컬럼) 이 필수이고,
--이때 그룹함수는 미적용된 컬럼의 값에 따라 그룹이 묶여진다. [ 제시된 상황에 그룹별 등의 제약조건일때 사용 ]

MAX(컬럼명)   -- 해당 컬럼의 최고값을 출력 (한글은 가나다순에서 가장 끝 글자)
MIN(컬럼명)   -- 해당 컬럼의 최저값을 출력 (한글은 가나다순에서 가장 첫 글자)
COUNT(컬럼명) -- 해당 컬럼의 결과로 나온 로우의 개수를 출력
SUM(컬럼명)   -- 해당 컬럼의 합계값을 출력
AVG(컬럼명)   -- 해당 컬럼의 평균값을 출력

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

GROUP BY (그룹함수 외 일반컬럼명)
--일반컬럼의 각 값을 그룹별로 정리함
--GROUP BY 절에 사용한 컬럼은 SELECT 과 FROM절 사이에서 그룹함수와 함께 사용할 수있다.
"GROUP BY에 사용되는 컬럼은 반드시 컬럼명으로 기술해야하고, 별칭을 기술하면 문법에러 발생함."

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

HAVING (조건식)
--그룹함수에 조건문을 걸때 사용하는 HAVING절 ( 일반함수는 WHERE 절 )






---------------------------------------------------------------------------------

[G] ORDER BY (ASC/DESC):: 결과정렬
--전체결과를 오름차순/내림차순 으로 정렬한다.

SELECT ename, sal FROM emp
ORDER BY sal asc --오름차순 : ㄱ부터 ㅎ까지 정리 후, NULL(모른다) 로 정리함.

SELECT ename, comm FROM emp
ORDER BY comm desc --내림차순 : null(모른다)이후 ㅎ부터 ㄱ까지 정리함

--NULL값은 모른다 이므로 정렬시 맨 뒤에 올 수 밖에 없다.
--내림차순은 이와 반대이므로 가장 먼저 나타난다.





■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

<003> ORACLE 제공함수와 수동작성함수

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[A] LAG/LEAD :: 분석함수

--CDATE : 년월일 날짜 9월1일 ~9월 11일
--AMT : 일자별 환전 금액
--CRATE : 당일 마감 환률 

--직전 레코드 바로 전의 레코드, 그러니까 현재 레코드로부터 2개 앞에 있던 레코드는 다음과 같이 구한다. 
--LAG함수의 2번째 매개변수인 2 가 현재레코드 전전 레코드 가져 오라는 것이고,
--3번째 매개변수는 현재 레코드의 전전 레코드가 없을 때 디폴트로 어떤 값을 넣을 것인가 지정하는 것.
SELECT CDATE,
       AMT, CRATE,
       LAG(AMT,2,777) OVER(ORDER BY CDATE) EX_AMT,-- 2일전 환전 금액
       LAG(CRATE,2,777) OVER(ORDER BY CDATE) EX_CRATE -- 2일전 환률      
       FROM TEST02


-- 아래는 지난 5일간의 환률 보여주는 쿼리
SELECT CDATE,
       AMT, 
       CRATE,
       LAG(AMT,1) OVER(ORDER BY CDATE) EX_AMT1,-- 1일전 환전 금액
       LAG(CRATE,1) OVER(ORDER BY CDATE) EX_CRATE1, -- 1일전 환률     
       LAG(AMT,2) OVER(ORDER BY CDATE) EX_AMT2,-- 2일전 환전 금액
       LAG(CRATE,2) OVER(ORDER BY CDATE) EX_CRATE2, -- 2일전 환률   
       LAG(AMT,3) OVER(ORDER BY CDATE) EX_AMT3,-- 3일전 환전 금액
       LAG(CRATE,3) OVER(ORDER BY CDATE) EX_CRATE3, -- 3일전 환률   
       LAG(AMT,4) OVER(ORDER BY CDATE) EX_AMT4,-- 4일전 환전 금액
       LAG(CRATE,4) OVER(ORDER BY CDATE) EX_CRATE4, -- 4일전 환률   
       LAG(AMT,5) OVER(ORDER BY CDATE) EX_AMT5,-- 5일전 환전 금액
       LAG(CRATE,5) OVER(ORDER BY CDATE) EX_CRATE5 -- 5일전 환률                                
       FROM TEST02

"아래는 LAG함수 없이 지난 5일간의 환률을 보여주는 쿼리"

SELECT
       SUM(rf1.cdate) as "대상일자"
      ,rf2.cdate as "비교일자"
      ,rf1.crate as "마감환율"
  FROM TEST02 rf1, TEST02 rf2
 WHERE rf1.cdate >= rf2.cdate
   AND rf1.cdate - rf2.cdate <= 6
 GROUP BY rf1.cdate, rf2.cdate, rf1.crate
 ORDER By rf1.cdate

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -
      
-- 바로 이후 레코드 값을 참조하고자 할 때. LEAD 함수를 사용한다.
 SELECT CDATE,
       AMT, CRATE,
       LEAD(AMT) OVER(ORDER BY CDATE) POST_AMT,--1일 후 환전금액
       LEAD(CRATE) OVER(ORDER BY CDATE) POST_CRATE -- 1일후 환률      
       FROM TEST02


--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

--아래와 같이 어떤 회사의 3년 간의 사원 수도 구해볼 수 있다. 이건 테이블이 없음. 쿼리만 볼 것.
SELECT TO_CHAR(HIRE_DATE), 'YYYY' 입사연도,
    COUNT(*) 사원수, --기준년도 사원 수
    LAG(COUNT(*) , 1, 0) OVER(ORDER BY TO_CHAR(HIRE_DATE, 'YYYY'))--이전년도사원수,
    LEAD(COUNT(*) , 1, 0) OVER(ORDER BY TO_CHAR(HIRE_DATE, 'YYYY'))--이후년도사원수
    FROM EMPLOYEE
    GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
    ORDER BY TO_CHAR(HIRE_DATE, 'YYYY')

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -

--TEMP 의 자료를 이용하여 각자의 사번, 성명, 급여를 읽고 ,
--자신을 제외한  이전 사번 중 급여가 가장 작은 금액을 뽑아보는 쿼리
--WINDOWING 절과 MIN (..) 함수를 이용한다.

SELECT EMP_ID,
       EMP_NAME,
       SALARY,
       MIN(SALARY) OVER(ORDER BY EMP_ID
                        ROWS BETWEEN UNBOUNDED PRECEDING
                                 AND 1 PRECEDING) SALARY1
       FROM TEMP




---------------------------------------------------------------------------------

[B] WM_CONCAT :: 세로로 된 데이터를 가로로 모아서 출력해주는 함수
--Oracle 10g에서는 문자정렬이 가능하지않음 ( http://denodo1.tistory.com/266 )

select NAME_VC,WM_CONCAT(QUANTITY_NU)as "VALUE"
  from T_GIFTORDER
  group by NAME_VC

출력결과
건담   | 2,7
마크로스 | 9,11

"아래는 WM_CONCAT(컬럼명) 함수 없이 작성한 쿼리"

SELECT
    DECODE(MOD(num_nu,2),1, '건담', '마크로스') name_vc
   ,MIN(quantity_nu) || ',' || MAX(quantity_nu) VALUE
FROM t_giftorder
GROUP BY DECODE(MOD(num_nu,2),1, '건담', '마크로스')




■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

<004> 집합적 사고하기
--집합을 수학적집합 정리방법으로 정리할경우, 반드시 컬럼의 개수와 형식을 맞춰주어야 한다.

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

[A] 합집합 : UNION & UNION ALL

SELECT deptno FROM dept
UNION
SELECT ename  FROM emp
--형식이 맞지 않아서 에러발생

SELECT deptno FROM dept
UNION
SELECT empno  FROM emp
--형식을 맞추서 합집합 실행

SELECT deptno FROM dept
UNION
SELECT deptno FROM emp
--PK와 FK를 합집합하는 경우, 중복이 제거되어 실행된다. 

SELECT deptno FROM dept
UNION ALL
SELECT deptno FROM emp
--UNION ALL은 윗집합의 결과에 아랫집합의 결과를 이어 붙인다.
--(중복제거과정 없기때문에 결과값이 많고, 결과계산이 UNION에 비해 빠르다.) 

---------------------------------------------------------------------------------

[B] 차집합 : MINUS

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp
--차집합을 이용하여 특정 정보의 값을 추려냄

SELECT deptno FROM emp
MINUS
SELECT deptno FROM dept
--작은 집합에서 큰 집합을 빼면 결과는 없다

---------------------------------------------------------------------------------

[C] 교집합 : INTERSECT

SELECT deptno FROM dept
INTERSECT
SELECT deptno FROM emp
-- 교집합을 이용하여 공통 정보의 값을 추려낸다