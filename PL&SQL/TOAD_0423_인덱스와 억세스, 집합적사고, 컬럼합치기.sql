오라클에서는 인덱스와 테이블정보가 따로 관리되고있다.
만일 조회 컬럼이 PK인 경우에는 테이블 억세스 없이 인덱스만 읽고 조회결과를 반환한다.
검색속도와 관계있는 부분임.--Ctrl + e (Explain Plan): 권한무시후 실행
PK가 아닌경우 풀로 다 읽어야 하기 때문임 

SELECT empno FROM emp--숫자는 오른쪽정렬되었네? ( 오름차순으로 정리됨 )

SELECT ename FROM emp--문자는 왼쪽정렬되었네?

조회결과에 대해 정렬할 수 있다.
정렬을 하면 2차 가공이 일어나므로 검색 속도는 늦어지겠지요?
예를들면 밖에 수강생을 모두 세워놓고, 키 순서대로 들어오라고 주문한다면, 로딩하는데 매우 시간이 걸리게 됨
--즉, ORDER BY를 사용하지 않고 정리를 잘 할 수 있는 사람이 대단한 효율의 업무능력을 가진 사람임.

SELECT ename FROM emp ORDER BY ename asc-- ORDER BY는 2차 가공되기떄문에 속도가 느려짐!!!!

SELECT ename FROM emp ORDER BY ename desc

SELECT empno, ename FROM emp

SELECT 1+2,2*4,100-5,100/5,MOD(5,2) FROM dual

WHERE MOD(empno,2)=0--대상을, 2로나누어서 0이 되는 조건 :: 즉 짝수 (Toad 에서 등가조건은 ==이 아닌 = )

SELECT 1 FROM dual WHERE 1=1 OR 1>3

SELECT 와 FROM 사이에는 컬럼명이 올 수 있다. ( 지난주 내용 )
SELECT 와 FROM 사이의 사칙연산은 옵티마이저가 처리하게 할 수 있다.


SELECT /*+index_desc(emp pk_emp)*/ empno FROM emp--hint문을 사용하여 내림차순으로 정리했다.

hint문은 에러가 있으면 무시된다. ( 예시, 오타가 생겨도 무시한다 )
즉 에러가 발생하지 않고, 테이블문을 볼 줄 아는 것으로부터 관계지향형 데이터 설계의 출발점.

언제 사용가능할까?
주문번호 채번할때 사용가능한 부분

SELECT /*+index_desc(emp pk_emp)*/ empno FROM emp
--desc : descending의 약자

SELECT /*+index_desc(emp pk_emp)*/ empno+1 FROM emp --사칙연산 적용하여 채번해냄
WHERE rownum = 1

SELECT 5000/12 FROM dual

dual은 오라클에서 제공하는 가상의 테이블로, 로우1개/컬럼1개 로 구성되어있는 가상테이블로
실제테이블억세스없이 테스트를 가능하고, 상수값을 보거나 사칙연산을 계산하기에 이용가능


Q.우리회사에서 급여를 제일 많이 받는 사원의 이름과 급여를 출력하는 sql문을 작성하시오.
    
        함수명은 max
        SELECT 컬럼명1, 함수(컬럼명), 함수(값), 사칙연산 FROM dual
        --함수에 대한 처리 결과를 리턴받을 수도 있다.
    
        SELECT count(empno),MAX(ename), MIN(sal), MOD(5,2) FROM emp
        

        힌트
        먼저 우리회사에서 급여를 제일 많이 받는 사원의 급여액을 알아 낸다.
        
        두번째,
        그 급여액으로 조건 검색을 해서 사원명과 급여액을 출력해 본다.

        SELECT MAX(sal) FROM emp

        SELECT ename,sal FROM emp WHERE sal=5000
    

        하나로 줄이는 방법?

        MAX와 같은 그룹함수는조회결과가 1건입니다.
        그런 그룹함수 조회 결과와 ename과 같은 일반 컬럼을 같이 사용할 수는 없는거죠
        왜냐하면 sal에 대한 최대값을 찾았는데, 사원이름을 보여달라고 하면 14명 중 누구를 보여줘야 할지
        옵티마이저 입장에서는 난감한 상황이 되기 때문에, FROM 키워드에러가 발행하게 됩니다.
        
        SELECT MAX(sal), ename WHERE emp
        
        해결방법
        이 논리의 문제를 해결하려면 ename에도 max를 씌워주면 합법이 되긴 하지만
        그때  출력된 이름은 이름의 최대값이지 급여가 최대인 사원의 이름이 아니기 때문에 내가 원하는 답이 될수 없어요.
        
        SELECT sal, ename FROM emp WHERE sal>=(SELECT MAX(sal) FROM emp)
            
        
        
        우리회사에서 인센티브를 받는 사원들의 사원번호, 사원명 그리고 인센티브 금액을 출력하는 sql문을 작성하시오.
        
        SELECT empno as "사원번호", ename as "사원명",comm as "인센티브 금액"
            FROM emp
           WHERE comm IS NOT NULL
             AND comm != 0 
        
        
       
        학습목표
        나는 널을 비교해서 조회결과르 출력할 수 있다.
        
        SELECT 1 FROM dual WHERE 1 > 3
        
        SELECT 1 FROM dual WHERE 1 < 3
        
        NULL를 비교할 땐 IS NULL  혹은 IS NOT NULL  로 해야한다. ( 모르는 값이기 때문 )
        
        
        
        추가학습목표
        집합적 사고를 코드에 적용할 수 있다. - 중급난이도
        
        SELECT 1 FROM dual
        UNION ALL
        SELECT 2 FROM dual
        
        SELECT 1 FROM dual
        MINUS
        SELECT 2 FROM dual
        
        SELECT 1 FROM dual
        INTERSECT
        SELECT 1 FROM dual
        
        
        
        1
        SELECT empno, ename, comm FROM emp
        WHERE comm IS NOT NULL
          AND comm !=0--!는 부정한다는 의미
       
        2
        SELECT empno, ename, comm FROM emp
        WHERE comm IS NOT NULL
        MINUS
        SELECT empno, ename, comm FROM emp
        WHERE comm =0
        
        첫번째는 테이블을 한 번만 읽고서 처리하지만
        두번째는 동일한 테이블을 두번 읽어서 처리하므로
        첫번째가 더 효과적입니다. (효과적이라는건 일량이 적다는 의미)
        
        
        
        해당 컬럼에 NULL인 값인 자리에 숫자,'문자'를 집어넣어 줌
        
        SELECT NVL(comm,0) FROM emp
        
        SELECT NVL(comm,'1') FROM emp
        
        
        
        오라클은 대소문자를 구분하지 않지만, 오라클상의 데이터의 대소문자는 구분한다.
        또한 싱글 쿼테이션( ' ' )은 데이터값, 더블 쿼테이션 ( " " )은 치환할 값? 
        
        SELECT sal FROM emp WHERE ename='SMITH'
        
        SELECT sal as "급여" FROM emp
        
        
        오라클에서 2개의 컬럼을 합쳐서 하나의 셀 안에 나타내는 방법 
        
        SELECT empno||ename FROM emp