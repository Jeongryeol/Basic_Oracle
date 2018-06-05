오라클에서 사용자 정의 객체를 만들 수 있다. (OBJECT개념)
- 변수를 선언할 수 있다.
- 제어문을 사용할 수 있다.
- 출력할 수 있다.


교재 p.364

1) Function
 : 함수는 호출했을때 반환값이 있다. | 리턴값이 있다. ( 리턴값은 하나다 : 1 )
 : 파라미터가 있다. ( 적합한 파라미터가 하나 이상이 필요하다 )
    --( 로그인할때 : 아이디, 비밀번호 / 우편번호를 조회할때 : 동이름 )
 : 자바와 오라클을 연동하여 SQL문을 걸거나 혹은 오라클에서 SQL문을 실행할때
   "수치가 부적합하다"는 문구가 나오면 "ORACLE ERROR"라는 사실을 인지해야함
   ▶ --ERROR ORA-0172:수치가 부적합합니다. : 적합한 파라미터가 적용되지 않았다.
   ▶ "반드시" SELECT INSERT UPDATE DELETE 구문 확인  
 
 a) 제공되는  함수
         SELECT MOD(5,2), MAX(6), MIN(1) FROM dual
 b) 사용자 정의 함수
 
2) Procedure
 : 파라미터를 넘길수도 있고, 리턴값을 받아낼 수 있다. / 자바연계가능 ( 은행, 회계 돈 )
 : 업무에 대한 복잡도가 높을수록, 업무에 대한 depth(깊이)가 깊을수록 "반드시" Procedure가 필요함.

3) Trigger
 : 데이터에 대한 동기화를 지원한다. [기술면접대상]
 : 테이블간의 동기화란, A테이블에 입력된 데이터가 자동으로 B테이블에 입력이 되는 기능.
 
 


▼객체코딩 기본꼴

declare
--선언부
begin
--프로그래코딩부(for문, if문, SELECT문, 변수의 값을 초기화)
end;


▼객체코딩 연습

declare
--선언부
    --이름   타입         초기화  값;
    v_name varchar2(30) :='이순신';
    n_age  number(5) :=30;
begin
--프로그래코딩부(for문, if문, SELECT문, 변수의 값을 초기화)
    dbms_output.put_line(v_name||','||n_age);
    dbms_output.put_line(TO_CHAR(sysdate,'YYYY-MM-DD'));
end;
--드래그한 뒤 Execute as script 클릭하여 실행
--Script Output 탭에서 결과문구 확인
--DBMS Output (disabled) 탭에서 조회이력 확인 (흰종이 아이콘으로 초기화 가능)

--schema script에서 보면 조회가 안됨 >> 컴퓨터가 켜져있는 지금만 볼 수 있는 자료라는 뜻
--제대로된 Procedure 객체로 만들어 주어야 한다.



