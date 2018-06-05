1. 영어가사만 출력하세요.

    SELECT words_vc as "영어가사" FROM t_letitbe WHERE MOD(seq_vc,2)=1

    ★★★모범답안★★★

    SELECT words_vc as "영어가사" FROM t_letitbe WHERE MOD(TO_NUMBER(seq_vc),2)=1


    ★★★질의회신답안★★

    SELECT words_vc as "영어가사"
    FROM(SELECT SEQ_VC,words_vc FROM t_letitbe 
    MINUS
    SELECT SEQ_VC,words_vc FROM t_letitbe WHERE MOD(seq_vc,2)=0)
    WHERE MOD(TO_NUMBER(seq_vc),2)=1




2. 한글가사만 출력하세요.

    SELECT words_vc as "한글가사" FROM t_letitbe WHERE MOD(seq_vc,2)=0

    ★★★모범답안★★

    SELECT words_vc as "영어가사" FROM t_letitbe WHERE MOD(TO_NUMBER(seq_vc),2)=1




3. 영어가사와 한글가사를 교대로 출력하는 SQL문을 작성하세요.
요구사항 
반드시 UNION ALL를 사용해서 작성합니다.
SELECT * FROM t_letitbe는 답이 아닙니다.
    
    SELECT WORDS_VC as "가사"
    FROM(SELECT * FROM t_letitbe WHERE MOD(seq_vc,2)=1
         UNION ALL
         SELECT * FROM t_letitbe WHERE MOD(seq_vC,2)=0)
    ORDER BY TO_NUMBER(seq_vc) asc;
    
    
    --조건절에 사용하는 컬럼명은 별칭으로 사용할 수 없다
    --테이블에실제로 존재하는 컬럼명만 가능하다.
    --단,alias명(별칭)으로 조회가 가능한 경우는 인라인뷰 로 집합을 만들었을때 가능해짐
        
    SELECT *
        FROM ( SELECT empno as "사원번호", ename FROM emp )
       WHERE "사원번호" > 7800
    
    --a는 해당집합을 의미하는 식별자 역할

    SELECT a."사원번호"
        FROM ( SELECT empno as "사원번호", ename FROM emp )a
       WHERE "사원번호" > 7800
    
    ★★★모범답안★★★
    
    
      
    IF 1=1 THEN
        return "ㅁ"
    ELSE THEN
        return 'b'
    END IF;
    
    
    
    SELECT DECODE('A','B','T','F') FROM dual
    
           DECODE : 앞내용('A')과 뒷내용('B')이 같은지  판단하고 같으면 'T' 다르면 'F'를 반환한다.
           
           
    SELECT SIGN(7), SIGN(0), SIGN(50-50), SIGN(10-40), SIGN(-500) FROM dual
    
    SELECT DECODE(SIGN(183-170),1,'키카 크다','키가 작다') FROM dual
    
    SELECT deptno FROM emp GROUP BY deptno