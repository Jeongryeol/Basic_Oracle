create table computer_engineering
(std_no number(8) constraints std_no_pk primary key
,grade number(1) default 0
,sname varchar2(30) not null
,oracle number(4,2) default 0
,java number(4,2) default 0
,html number(4,2) default 0
,tot number(6,2) default 0
)

--테이블 삭제하기
--DROP TABLE student;