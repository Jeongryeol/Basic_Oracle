create table social_physical
(std_no number(8) constraints soc_no_pk primary key
,grade number(1) default 0
,sname varchar2(30) not null
,golf number(4,2) default 0
,swimming number(4,2) default 0
,physical number(4,2) default 0
,tot number(6,2) default 0
)