-- MySQL에서 사용자는 기본적으로 root로 시작을 한다.
-- 오라클과 차이점
-------------------------------------------------------------------------------
-- 구분 		   오라클					MySQL
-- 저장소		   TableSpace			DataBase
-- Scheme      User					DataBase
-- 데이터저장     User.Table 형식		Table
-- User의 개념   Scheme 				login하는 Account
-------------------------------------------------------------------------------

-- 1. MySQL 데이터를 저장하기 위해서 최초로 DataBase를 생성
-- 2. 생성된 Database를 사용가능하도록 Open절차 필요
-- 3. 사용자 login 권한과 접속하는 용도의 Account

