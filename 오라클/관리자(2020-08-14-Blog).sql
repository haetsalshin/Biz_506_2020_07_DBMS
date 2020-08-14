-- 여기는 관리자 화면.

-- 블로그를 위한 tablespace 생성
CREATE TABLESPACE blogTS
DATAFILE 'C:/bizwork/oracle_dbms/blogTS.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K; 

-- user1 사용자 생성
CREATE USER user1 IDENTIFIED BY user1
DEFAULT TABLESPACE blogTS;

-- user1에 권한 부여
GRANT DBA TO user1;