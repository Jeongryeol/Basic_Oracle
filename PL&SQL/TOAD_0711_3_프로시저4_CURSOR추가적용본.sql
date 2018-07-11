--커서 적용본

CREATE OR REPLACE PROCEDURE proc_studentACC2(temp IN VARCHAR2)
IS
    --선언부
    rtot NUMBER(10,2):=0;--총점을 담을 변수 선언
    v_comp computer_engineering%rowtype;
    --커서를 선언함
    CURSOR cur_comp IS --커서 fetch시 컬럼갯수 맞출것.
    SELECT ce.java, ce.oracle, ce.html, std.std_no, std.grade
      FROM computer_engineering ce, student std
      --조인을 사용하여 update시 필요한 학번과 학년 정보 추가함.
      --학년정보가 student에 있으므로 양쪽 테이블에 있는 학번으로 equal join함.
     WHERE ce.std_no = std.std_no;
      --집합이 2개 이상일때 where절이 없으면 카타시안의 곱이 걸림
      --그러면 쓰레기값 포함됨.(equals join은 양쪽에 있는 정보만 출력됨.)
BEGIN
    --실행부
    OPEN cur_comp; --커서 열기
    LOOP
    --select..into 대신 fetch..into문 사용함
        --차이점 : 반복문 안에서 사용시 n건을 조회해서 값을 담을 수 있음.
        --영화 좌석을 예매한다든가? 환자들에 대한 수술전 사전 검사를 한다든가?
        --우리회사 직원 전체에 대한 급여를 조정한다든가? 할 때.....
        --fetch시 커서이름 그리고 into 뒤에 변수 추가할 것.........
        FETCH cur_comp INTO v_comp.java
                           ,v_comp.oracle
                           ,v_comp.html
                           ,v_comp.std_no
                           ,v_comp.grade;
    --무한 루프 방지 코드 무조건 추가할것.-서버가 다운될 수 있음.
    --즉시 다운이 되는건 아니지만 자원이 계속 쌓이면 memory overflow위험있음.
        EXIT WHEN cur_comp%notfound;  
    
    --총점을 구할 때 변수 사용함. 더하기 연산자를 사용하여 총점 구한후 변수 처리
        rtot :=v_comp.java+v_comp.oracle+v_comp.html;
        dbms_output.put_line(rtot||', '||v_comp.std_no);--출력 
    
    --n건에 대해 수정해야 하므로 update문은 반드시 반복문 안에 작성해야 됨.
        UPDATE computer_engineering 
           SET tot   = rtot
              ,grade = v_comp.grade      
    --수정시 사용자 한사람, 한사람에 대한 처리이므로 반드시 조건절 추가할 것.
         WHERE std_no = v_comp.std_no;
         
        COMMIT;--수정한 뒤 커밋처리 할 것.
        
    END LOOP;
    
    CLOSE cur_comp;--커서 닫기
    
END;



