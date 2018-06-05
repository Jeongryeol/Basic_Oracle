--마스터계정 SYS로부터 생성된 계정에 관리자권한이 부여되었으면,
--권한을 가진 관리자 계정으로 테이블생성하기

CREATE table member
(mem_id VARCHAR2(15) constraints memid_pk primary key --constraints:제약조건
,mem_pw VARCHAR2(15) not null
,mem_name VARCHAR2(30) not null)