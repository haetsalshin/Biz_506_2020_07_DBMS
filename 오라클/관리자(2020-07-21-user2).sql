-- 여기는 관리자 화면 입니다.
-- 새로운 TableSpace와 사용자를 등록
-- TableSpace : user2Ts
--user : User2, password : user2

--C:\bizwork\workspace\oracle_data

CREATE TABLESPACE user2Ts
DATAFILE 'C:/bizwork/workspace/oracle_data/user2.dbf'
SIZE 1M AUTOEXTEND ON NEXT 10K;

CREATE USER user2 IDENTIFIED BY user2
DEFAULT TABLESPACE user2Ts;

GRANT DBA TO user2;