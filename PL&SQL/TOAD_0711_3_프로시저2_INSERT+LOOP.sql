--모범답안 프로시저의 목적
--사용자가 입력한 정보를 테이블에 저장하는 일 처리하기

--result가 1이면 테이블에 저장 성공된 것임. ( 0은 저장 실패한 것. )

--result2는 사용자가 입력한 학번(pstd_no)에서 테이블에 저장한 학번(ustd_no)를 뺀 값을 담는 변수
--result2가 0이면 두 값이 같다는 것이므로 ( 예, 2-2는 0이됨 )
--IF문에서 분기하고 LOOP문을 빠져나올 때 사용함.

CREATE OR REPLACE PROCEDURE proc_studentINS2
    (pstd_no     IN NUMBER
    ,pgrade      IN NUMBER
    ,pdepartment IN VARCHAR2
    ,psname      IN VARCHAR2
    ,result     OUT NUMBER
    )
IS --선언부
    ustd_no NUMBER(8) := 0;
    result2 NUMBER(1) := 0;
    CURSOR cur_student IS
        SELECT std_no FROM student;
BEGIN --실행부
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    commit; --삽인된 1개 로우를 커밋처리함. DB반영.
    OPEN cur_student; --커서를 열어줌.
    LOOP --반복문 시작
        FETCH cur_student INTO ustd_no; --커서를 FETCH하여 ustd_no에 정보를 담음
        EXIT WHEN cur_student%NOTFOUND; --커서 다 돌렸니?
        result2 := SIGN(pstd_no - ustd_no);--사용자가 입력한 학번과 DB에서 가져온 학번의 차
        IF --조건문 시작
            result2 = 0 THEN
            result := 1;
            EXIT WHEN result2 = 1;  --PK이르모 같은 값이 존재할 리 없음
        ELSE
            result2 := 9; --아니면 9를 출력하라 (의미없는 숫자) 
        END IF; --조건문 끝
    END LOOP; --반복문 끝
    dbms_output.put_Line('result 2: '||result2);--단위테스트 출력용
    CLOSE cur_student; --커서를 닫아줌.
END;

exec proc_studentINS2(18020118, 4, '컴퓨터공학과', '이순신', :result2);

SELECT * FROM student -- 확인


