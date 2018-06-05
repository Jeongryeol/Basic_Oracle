exec proc_test1('김유신');
--Turn Output On 후, ctrl+Enter 키

exec proc_test1_p('김유신',20180518);


▼Procedure 객체 코딩 연습 // 신철우씨 답변 ( Toad 상에서 Output 출력하기위해 변수선언까지 함 )

declare
    v_name varchar2(20) ;
    n_age  varchar2(20) ;
begin
--프로그래코딩부(for문, if문, SELECT문, 변수의 값을 초기화)
    proc_test1_p('김유신','20190104',v_name,n_age);
    dbms_output.put_line(v_name);
    dbms_output.put_line(n_age);
end;