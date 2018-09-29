1. 'TEMP 테이블에서 취미가 NULL이 아닌 사람의 성명을 읽어오시오.'

SELECT emp_name "성명", hobby "취미"
  FROM temp
 WHERE hobby IS NOT NULL
 ORDER BY emp_name
 

 
2. 'TEMP의 자료 중 HOBBY의 값이 NULL인 사원을 '등산'으로 치환했을때
    HOBBY가 '등산'인 사람의 성명을 가져오는 문장을 작성하시오.'
 
SELECT 성명,취미
  FROM (SELECT emp_name AS "성명"
       ,NVL(hobby,'등산') AS "취미" FROM TEMP)
  WHERE 취미 = '등산'



3. 'SMITH가 근무하는 부서와 같은 부서에 근무하는 사원들의 이름과 입사일자를 출력하시오'

SELECT e.ename "이름", e.hiredate "입사일자", d.dname "근무부서"
  FROM emp e, dept d
 WHERE e.deptno = d.deptno
   AND e.deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN')
   


4. '입사년도가 1982년도인 사원들의 사번과 이름을 출력하시오.'

SELECT empno "사번", ename "이름", TO_CHAR(hiredate,'YYYY') "입사년도" FROM emp
WHERE TO_CHAR(hiredate,'YYYY') = 1982 



5. '우리회사에서 근무하는 사람들 중에 급여가 2000불 이상인 사원들의 급여의 평균을 구하시오. (소수 3자리에서 반올림하시오.)'

SELECT '$'||TO_CHAR(ROUND(AVG(sal),2),'9,999.99') "2000불 이상의 평균급여" FROM emp WHERE sal>= 2000



6. 'SQL문이 처리되는 과정 4단계에 대해 설명하시오.'
    1) 실행계획수립 (15가지 규칙기반 자동계획 - rule base / 일양에 따른 cost base )
    2) TABLE 관계정리
    3) 옵티마이저 실행계획수령
    4) 페치(실제TABLE접속)후 데이터 조회
     
    

7. '보유하고 있는 포인트로 과일바구니를 받을 수 있는 사람들의 명단과 보유포인트, 상품포인트를 출력하시오.'

SELECT mem.name_vc "고객명", mem.point_nu "보유포인트" , poi.name_vc "상품명", poi.point_nu "소요포인트"
  FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '과일바구니'
   AND mem.point_nu >= (SELECT point_nu FROM t_giftpoint WHERE name_vc = '과일바구니')
 ORDER BY mem.name_vc, poi.point_nu




8. 'ALLEN이 근무하는 부서명을 출력하는 SQL문을 작성하시오'

SELECT emp.ename "성명", dept.dname "부서명"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
   AND emp.ename = 'ALLEN'
   


9. '부서별 급여 평균을 구하고 급여 평균이 2000불 이상인 부서의 부서번호를 출력하시오.'

SELECT dept.dname "부서명", '$'||TO_CHAR(ROUND(AVG(emp.sal),2),'99,999.99') "평균급여"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno
 GROUP BY dept.dname
 HAVING AVG(sal) >= 2000
 


10. 'JOB이 MANAGER 사원들의 급여의 합, JOB이 ANALYST인 사원들의 급여의 합, 그리고 나머지는 기타사원들의 급여의 합을 구하시오.' 
 
SELECT DECODE(job,'MANAGER',job,'ANALYST',job,'기타') "JOB"
      ,'$'||TO_CHAR(SUM(sal),'999,999') "급여합계"
  FROM emp
 GROUP BY DECODE(job,'MANAGER',job,'ANALYST',job,'기타')
 ORDER BY DECODE(job,'MANAGER',job,'ANALYST',job,'기타')
 
 
 
11. 'lec_time이 크면 실험과목, lec_point가 크면 기타과목, 둘이 같으면 일반과목으로 값을 돌려받고자 한다. 어떻게 해야하는가?'

SELECT a.lec_id "No", DECODE(SIGN(a.lec_time - b.lec_point),1,'실험과목',-1,'기타과목',0,'일반과목') "분류"
  FROM (SELECT rownum rno, lec_id, lec_time FROM lecture) a
      , (SELECT rownum rno, lec_point FROM lecture) b
 WHERE a.rno = b.rno
 
 
 
12. 다음을 DECODE구문으로 표현해보시오
 
IF A = B THEN
    IF C = D THEN
        RETURN 'T';
    ELSE
        RETURN 'F';
    END IF
ELSE
    RETURN 'F'
END IF;

DECODE(A-B,0,DECODE(C-D,0,'T','F'),'F')

모범답안 : DECODE(A,A,DECODE(C,C,'T','F'),'F')
 
