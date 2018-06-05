DB서버 세팅하기

CREATE USER wadiz identified by qwer1234
--DDL 구조생성언어

GRANT connect, resource TO wadiz
--DCL 권한부여언어 : 관리자권한

--테이블 스페이스 생성하기(메모리공간할당)
--오라클이 설치된 물리적인 위치 확인하기
--E:\app\509\oradata\orcl11 
--해당 계정의 데이터파일의 경로와 생성파일, 파일크기를 지정해줌
CREATE TABLESPACE ts_wadiz DATAFILE 'E:\app\509\oradata\orcl11\db_wadiz.dbf' SIZE 200M
DEFAULT STORAGE
(INITIAL 10K
 NEXT 10K
 MINEXTENTS 2
 MAXEXTENTS 50
 PCTINCREASE 50)
--하단 상태표시줄에서 Tablespace created 확인 

SELECT tablespace_name, initial_extent, max_extents FROM dba_tablespaces;
--오라클상에서 서버생성확인하기
--컴퓨터 하드디스크상에서 물리적 서버생성확인하기 : 해당폴더에 db_wadiz.dbf 가 200mb로 생성되었는지 확인할것