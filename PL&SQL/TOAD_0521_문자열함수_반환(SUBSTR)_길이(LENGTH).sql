문자열의 일부를 돌려주는 함수
SUBSTR(char,n);   --char문자의 n번째 자리부터 문자열 끝까지 돌려준다.
SUBSTR(char,n,m); --char문자의 n번째 재리부터 m번째 자리까지 문자열을 돌려준다.
**B 를 붙이면 바이트를 계산하여 출력한다.

SELECT substr('ORACLE JAVA',1,3)--글자를 잘라서 표기함
      ,substr('ORACLE JAVA',1,2)
      ,substr('ORACLE JAVA',0,2)
      ,substr('ORACLE JAVA',3)
      ,substr('ORACLE JAVA',5)
      ,substrb('이순신',1,3)
      ,substrb('이순신',1,2)
      ,substrb('이순신',1,1)
  FROM dual;
  

문자열의 길이를 돌려주는 함수
LENGTH(char) --char문자의 길이를 출력해준다.
LENGTHB(char) --char문자를 바이트로 변환하여 길이를 출력해준다. (한글은 2바이트, 영문은 1바이트)

SELECT length('오라클 Project'), lengthb('오라클 Project')
  FROM dual; 
  
  


[연습문제] 본인의 이름을 입력받아서 성이 김씨면 김유신님은 김씨입니다. 출력...
        김유신님은 이씨, 홍씨, 박씨가 아닙니다.
        
CREATE OR REPLACE PROCEDURE proc_test4(p_name IN varchar2, msg OUT varchar2)
IS
    v_tmp varchar2(50);
BEGIN
    v_tmp := substr(p_name,1,1);--이름에서 첫글자 성을 추출하여 v_tmp초기화시킴[:=]은 오라클에서의 대입연산자
    dbms_output.put_line(v_tmp);--출력
    IF '김'=v_tmp THEN
        msg:=p_name||'님은 김씨입니다.';
    ELSIF '이'=v_tmp THEN
        msg:=p_name||'님은 이씨입니다.';
    ELSIF '박'=v_tmp THEN
        msg:=p_name||'님은 박씨입니다.';
    ELSE
        msg:=p_name||'님은 김씨, 이씨,박씨가 아닙니다.';
    END IF;--경우에따른 msg값 초기화
    dbms_output.put_line(msg);--출력
END;


exec proc_test4('홍인표',:msg);
