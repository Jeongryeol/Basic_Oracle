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
    (pstd_no     IN NUMBER
    ,pgrade      IN NUMBER
    ,pdepartment IN VARCHAR2
    ,psname      IN VARCHAR2
    ,msg        OUT VARCHAR2
    )
IS --선언부
    ustd_no NUMBER(8) := 0; --찾아낸 학생정보가 담길 변수
    result  NUMBER(1) := 0; --담긴 결과정보를 담음
    CURSOR cur_student IS   --커서생성
        SELECT std_no FROM student; --학생정보를 찾아서 담음
BEGIN --실행부
    --입력한 값으로 테이블에 입력하기
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    OPEN cur_student; --커서열기
    LOOP --반복문 시작
        FETCH cur_student INTO ustd_no; --커서를 돌리면서 학생정보를 담음
        EXIT WHEN cur_student%NOTFOUND; --커서를 멈출 조건식 입력
        IF --조건문 시작 
            pstd_no = ustd_no THEN     --파라미터와 담은 정보가 같으면
            result :=  1;              --결과정보를 초기화한다
            msg := '이미 데이터가 있습니다.';
            dbms_output.put_Line(msg);
        ELSE
            result := -1;               --그외에는 이렇게 초기화한다
            msg := 'pass';
            dbms_output.put_Line(msg);
        END IF; --조건문 끝
    END LOOP; --반복문 끝
    CLOSE cur_student; --커서닫기
END;


EDIT student;

--테스트
exec proc_studentINS(18000001,1,'컴퓨터공학과','테스터',:msg);

--확인
SELECT * FROM student;