/*
    [실전연습문제]
    1) 컴퓨터공학과 재학생을 관리하는 테이블을 설계하시오.
        ㄴ공통사항 : 학년정보, 이름, 과별과목 3개이상 추가 (학번이 PK)
    
    2) 사회체육학과 재학생을 관리하는 테입르을 설계하시오.
        ㄴ공통사항 : 학년정보, 이름, 과별과목 3개이상 추가 (학번이 PK)
    
    3) 학생정보를 관리하는 테이블을 설계하시오.
        ㄴ필수입력사항 : 학년정보, 이름, 학과정보, 학번
    
    4) 학생 테이블에서 이번 중간고사 성적을 처리하는 프로시저를 작성하시오.
        성적처리결과는 각각 컴퓨터공학과 테이블과 사회체육학과 테이블에 반영해야 합니다.
        프로시저로 SELECT과 UPDATE를 관리하도록 하기 
    
    5) 왜 프로시저를  사용하야 하는지 그 이유에 대하여 경험한 것을 바탕으로 작성하시오.
*/

--학생정보를 저장하는 프로시저
--  학생테이블의 컬럼이 4개이므로 파라미터도 학생정보를 받아온다.
--  정상적으로 추가되었을 때, 그 결과를 담을 변수를 선언한다. ( result )
CREATE OR REPLACE PROCEDURE proc_studentINS
(pstd_no IN NUMBER, pgrade IN NUMBER, pdepartment IN VARCHAR2, psname IN VARCHAR)--,msg OUT VARCHAR2)
IS  --선언부
    ustd_no NUMBER(8) := 0;     --학생정보를 담음
    result NUMBER(1) := 0;
    msg VARCHAR(50) := null;
    CURSOR cur_student IS       --커서생성
    SELECT std_no FROM student; --학생정보를 찾아서 담음
BEGIN
    --실행부
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    OPEN cur_student;   --커서열기
    LOOP
        FETCH cur_student INTO ustd_no; --커서를 돌려서 학생정보를 담기
        EXIT WHEN cur_student%NOTFOUND;
        IF  pstd_no = ustd_no THEN      --파라미터와 커서의 학생정보가 같니?
            result := 1;                --결과변형
            msg := '이미 데이터가 있습니다.';
            dbms_output.put_Line(msg);
        ELSE
            result :=-1;
            msg := 'PASS';
            dbms_output.put_Line(msg);
        END IF;
    END LOOP;
    CLOSE cur_student;  --커서닫기
END;

exec proc_studentINS(18020904,3,'사회체육학과','테스터');

SELECT * FROM student;


--모범답안
--이 프로시저의 목적은 사용자가 입력한 정보를 테이블에 저장하는 일을 처리하는 것.
--result가 1이면 테이블에 저장 성공된 것임. ( 0은 저장 실패한 것.)
--result2는 사용자가 입력한 학번(pstd_no)에서 테이블에 저장된 학번(ustd_no)를 뺀값을 담을 변수임.
--result2가 0이면 두 수는 같다는 것이므로, ( 예, 2-2는 0이죠 )
--IF문에서 분기하고 LOOP문을 빠져나올 때 사용함.
CREATE OR REPLACE PROCEDURE proc_studentINS2
(pstd_no IN number, pgrade IN number, pdepartment IN varchar2, psname IN varchar2
, result OUT number)
IS
    ustd_no number(8):=0;
    result2 number(1):=0;
    cursor cur_student is
    SELECT std_no FROM student;
BEGIN
    INSERT INTO student(std_no, grade, department, sname)
    VALUES(pstd_no,pgrade,pdepartment,psname);
    commit;--삽입된 1개 로우를 커밋 처리함. 그래야 DB테이블에 반영됨.
    OPEN cur_student;--커서를 열어줌
    LOOP--반복문 시작
        fetch cur_student INTO ustd_no;--커서를 OPEN했고 FETCH시작함. FETCH함 정보를 ustd_no에 담음
        EXIT WHEN cur_student%notfound;--커서가 다 돌았뜨ㅑ
        result2 := SIGN(pstd_no-ustd_no);--result변수에 사용자가 입력한 학번에서 DB에서 가져온 학번을 빼고 그 결과를 담음
        IF result2=0 THEN -- 두수가 같다는 것을 의미하므로 result변수에 1 저장함
            result := 1; 
            EXIT WHEN result2=1;--PK이므로 같은 값이 존재할 리 없으므로 반복문을 탈출함.
        ELSE
        result2 := -1;-- 저장한다면 -1을 
        END IF;
    END LOOP;--반복문 
    dbms_output.put_line('result2:'||result2);--단위테스트 할때 출력해봄.
    close cur_student;
END;

exec proc_studentINS2(18020118, 4, '컴퓨터공학과', '이순신', :result2);

SELECT * FROM student

EDIT COMPUTER_ENGINEERING 



--성적을 합계내어 작성하는 프로시저를 작성해보자
CREATE OR REPLACE PROCEDURE proc_studentACC(pstd_no IN NUMBER, msg OUT VARCHAR2)
IS
    rtot NUMBER(10,2) := 0;
    rgrade NUMBER(1) := 0;
    v_comp computer_engineering%rowtype;--컬럼명을 그대로 변수로 누릴 수 있다.
BEGIN
    SELECT ce.java, ce.oracle, ce.html, stu.grade
      INTO v_comp.java, v_comp.oracle, v_comp.html, rgrade
      FROM computer_engineering ce, student stu
     WHERE ce.std_no = pstd_no
       AND ce.std_no = stu.std_no;
    rtot := v_comp.java + v_comp.oracle + v_comp.html;
    --msg := tot;--단위테스트
    IF rtot > 0 THEN
        UPDATE computer_engineering SET tot = rtot, grade = rgrade
         WHERE std_no = pstd_no;
        COMMIT;
    END IF;
    SELECT sname, tot INTO v_comp.sname, v_comp.tot
      FROM computer_engineering
     WHERE std_no = pstd_no;
    msg := v_comp.sname||' 학생은 컴공과 '||rgrade||'학년이고 총점은 '||v_comp.tot||'입니다.';
END;


exec proc_studentACC(18020118,:msg);



--커서 적용 고급예제 ( 무 주석 )
CREATE OR REPLACE PROCEDURE proc_studentACC2(temp IN VARCHAR2)
IS
    --선언부
    rtot NUMBER(10,2):=0;
    v_comp computer_engineering%rowtype;
    CURSOR cur_comp IS
    SELECT ce.java, ce.oracle, ce.html, std.std_no, std.grade
      FROM computer_engineering ce, student std
     WHERE ce.std_no = std.std_no;
BEGIN
    --실행부
    OPEN cur_comp; --커서 열기
    LOOP
        FETCH cur_comp INTO v_comp.java, v_comp.oracle
                           ,v_comp.html, v_comp.std_no, v_comp.grade;
        EXIT WHEN cur_comp%notfound;  
    
        rtot :=v_comp.java+v_comp.oracle+v_comp.html;
        dbms_output.put_line(rtot||', '||v_comp.std_no);
    
        UPDATE computer_engineering 
           SET tot   = rtot
              ,grade = v_comp.grade      
         WHERE std_no = v_comp.std_no;
         
        COMMIT;
        
    END LOOP;
    
    CLOSE cur_comp;
    
END;