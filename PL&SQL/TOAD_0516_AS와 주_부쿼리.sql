SELECT ename as "사원명"
      ,sal 급여
      ,sal "급 여"
--    ,sal 급     여
  FROM EMP
  
▲ AS를 쓴 것과 쓰지 않은 것의 차이 : 인라인뷰 사용시, 컬럼명 사용가능 여부에 따른 차이


SELECT rownum rno FROM emp
 WHERE rno < 3 --에러발생
 
SELECT rownum rno FROM emp
 WHERE rownum < 3 --작동
 
 --인라인뷰는 부쿼리에서 사용한 별칭을
 --주쿼리(실제 출력되어 나가는 SELECT)에서 사용할 수 있다. 

SELECT rno,ename FROM (SELECT rownum rno,ename FROM emp)
 WHERE rno < 3

SELECT rno, 이름  FROM (SELECT rownum rno,ename as "이름" FROM emp)
 WHERE 이름 = 'SMITH'
 
SELECT ename as "이름",  TO_CHAR(hiredate,'YYYY-MM-DD') as "고용일자"  FROM EMP
 WHERE ename = 'SMITH'




