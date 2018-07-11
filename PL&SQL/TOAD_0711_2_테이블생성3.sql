create table student
(std_no number(8) constraints stud_no_pk primary key
,grade number(1) default 0
,department varchar2(50) not null
,sname varchar2(30) not null
)