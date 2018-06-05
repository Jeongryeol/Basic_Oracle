edit t_greport

해당 컬럼을 모두 더할때, 사람이름을 컬럼으로 추가하면 그 사람에 해당되는 값만 더해준다.

SELECT
        name_vc
       ,SUM(point_nu) as "총점"
       ,AVG(point_nu) as "평균"
  FROM t_greport
 WHERE grade_vc=1
GROUP BY name_vc


SELECT
        RANK() OVER(ORDER BY tot1) as "석차1"
       ,DENSE_RANK() OVER(ORDER BY tot1) as "석차2" 
       ,name_vc
       ,tot1
  FROM(
        SELECT
            name_vc
           ,SUM(point_nu) tot1
           ,AVG(point_nu) avg1
          FROM t_greport
         WHERE grade_vc=1
         GROUP BY name_vc
       )
       


우리회사에 근무하는 사원들 중에서 부서별 급여의 평균을 구하는 SQL문을 작성하시오.

SELECT
        a.deptno
       ,AVG(a.sal) as "급여"
  FROM emp a, dept b
  WHERE a.deptno = b.deptno
  GROUP BY b.deptno  -- 이름은 그룹으로 묶으면 보여줄수없음, max를 써서 보여줄순있으나 유효하지않음
