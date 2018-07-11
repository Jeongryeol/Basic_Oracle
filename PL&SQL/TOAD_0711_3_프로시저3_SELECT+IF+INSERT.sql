--각 과목의 성적을  합계내고 입력하는  프로시저를 작성해보자

CREATE OR REPLACE PROCEDURE proc_studentACC
    (pstd_no IN NUMBER
    ,msg    OUT VARCHAR2
    )
IS --선언부
    rtot    NUMBER(10,2) := 0; --과목의 합계를 저장할 변수
    rgrade  NUMBER(1) := 0;    --학년을 저장할 변수
    v_comp computer_engineering%rowtype;--컬럼명을 그대로 변수로 누릴 수 있다.
BEGIN --실행부
    --equal join으로 SELECT문 조회
    SELECT ce.java, ce.oracle, ce.html, stu.grade
      INTO v_comp.java, v_comp.oracle, v_comp.html, rgrade
      FROM computer_engineering ce, student stu
     WHERE ce.std_no = pstd_no
       AND ce.std_no = stu.std_no;
    
    --조회된 값에서 합계값 구하고 저장하기
    rtot := v_comp.java + v_comp.oracle + v_comp.html;
    --msg := tot;--단위테스트
    
    IF --조건문 시작
        rtot > 0 THEN --합계값이 있다면
        UPDATE computer_engineering SET tot = rtot, grade = rgrade
         WHERE std_no = pstd_no;
        COMMIT; --갱신하고 커밋
    END IF; --조건문 끝
    
    --커밋이후 변경된 테이블로부터 이름과 합계점수 다시 조회하고 rowtype변수로 담기 
    SELECT sname, tot INTO v_comp.sname, v_comp.tot
      FROM computer_engineering
     WHERE std_no = pstd_no;
    
    --메시지에 담기
    msg := v_comp.sname||' 학생은 컴공과 '||
           rgrade||'학년이고 총점은 '||
           v_comp.tot||'입니다.';
END;


exec proc_studentACC(18020118,:msg);