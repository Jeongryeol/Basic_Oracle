--PK와 관리할 컬럼을 정의하여 테이블을 생성한다

CREATE TABLE addrtb
(ano number(5) constraints addrtb_ano_pk PRIMARY KEY
,a_id VARCHAR2(10) not null
,a_pw VARCHAR2(10) not null
,a_name VARCHAR2(30) not null
,a_hp VARCHAR2(20))

--시퀀스를 추가하면 접속자수에따라 유니크한 번호로 채번됨
SELECT seq_addrtb_ano.nextval FROM dual


--INSERT
--JAVA에서 작성하여 연결준비가 끝나면 SQL문을 Toad에서 입력시키는 테스트를 해본다
INSERT INTO addrtb(ano,a_id,a_pw,a_name,a_hp)
    VALUES(8,'test','123','이순신','010-0000-9999')
    
rollback;--확인했으면 롤백하고 SQl문을 복사하여 JAVA로 다시 이동

SELECT * FROM addrtb--입력한거 확인하기

DELETE FROM addrtb

commit;

--SELECT
--JAVA에서 작성하여 연결준비가 끝나면 SQL문을 Toad에서 입력시키는 테스트를 해본다
SELECT ano, a_id, a_pw, a_name, a_hp
  FROM addrtb
 WHERE a_name = '김유신'