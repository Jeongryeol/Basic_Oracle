--------------------------------------------------------------------------------

컬럼레벨을 로우레벨에서 출력하기
로우레벨에 있는 데이터를 컬럼레벨에 출력하기

--------------------------------------------------------------------------------
View(뷰)

CREATE VIEW v_dept(deptno,dname)
as
SELECT deptno,dname FROM dept
WHERE deptno >= 30

SELECT deptno,dname FROM dept 

--중요한 컬럼정보를 감추어 개발자에게 노출을 막을 수 있다.
--ex. 금융(보안)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

제목 : 이전레코드를 참조하기

테이블 정보
E:\김승수\39기_20180417\2. 오라클수업\오라클실습소스\8장 파일 추가

출력결과
  날짜        결제금액(달러)        환율          한화금액
----------------------------------------------------------
20010905          13200            1390        18,348,000
20010906          10800            1310        14,148,000


--[과제목표]----------------------------------------------------------------------
테이블에서 제공되지 않는 컬럼은 사용할 수 없다.
해결방법 : 인라인뷰를 사용하면 해결할 수 있다.

SELECT rownum rno, dname, loc FROM dept

SELECT rownum rno, dname, loc FROM dept --dept에 없는 rno를 컬럼으로 사용할 수 없음
 WHERE rno < 4
 
SELECT rno, dname, loc
  FROM (SELECT rownum rno, dname, loc FROM dept)
 WHERE rno < 3

관계지향형 데이터베이스는 테이블의 갯수가 많아진다.
--어떤 경우이든 테이블 구조 그대로 출력을 내보내는 경우는 없다.
  사용자가 원하는 양식에 맞추어 테이블을 찾고 가공해야할때, 인라인뷰를 활용할 수 있다.


--[풀이]--------------------------------------------------------------------------
--기본꼴
SELECT *
  FROM (인라인뷰1)a, (인라인뷰2)b
 WHERE a.ano = b.bno-1

--인라인뷰1 : a
SELECT rownum ano, crate FROM test02

--인라인뷰2 : b
SELECT rownum bno, cdate, amt FROM test02

--[모범답안]
SELECT b.cdate as "날짜"
      ,'$'||TO_CHAR(b.amt,'999,999') as "결제금액"
      ,a.crate as "환율"
      ,TO_CHAR(a.crate*b.amt,'999,999,999')||'원' as "한화금액"
  FROM (SELECT rownum ano, crate FROM test02) a
      ,(SELECT rownum bno, cdate, amt FROM test02) b
 WHERE a.ano = b.bno-1

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

함수 만들어보기

오라클에서 제공되는 함수

SELECT TO_CHAR(sysdate,'yyyy-mm-dd') FROM dual


사용자 정의 함수 = 잘하는 사람


아래　사용자　정의　함수는　해당　날짜의　환율을　알고　싶어하는　업무담당자를　위해　사용자가　정의한　함수임．
CREATE OR REPLACE FUNCTION func_yesterdaycrate(pdate vachar2)－－파라미터로　날짜를　받아서　바차２타입으로　저장
return number　－－반환값의　타입지정
IS
tmpVar number;
BEGIN
    tmpVar :=0;
    SELECT MAX(crate) INTO tmpVar
      FROM test02
     WHERE cdate = (SELECT MAX(cdate) FROM test02 WHERE cdate < pdate);
    return tmpVar;
END；


SELECT func_yesterdaycrate('20010908')
      ,func_yesterdaycrate('20010903')
      ,func_yesterdaycrate('20010905')
  FROM dual
