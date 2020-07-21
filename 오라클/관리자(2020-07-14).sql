-- Comment : 한줄 주석
/*
    여러줄 주석
    SQL 명령을 입력할 때 명령이 끝났다라는 것을 알리기 위해 ;을 붙여준다.(자바랑 같음)
    
    Ctrl + Enter : 현재 커서가 있는 곳의 명령문을 DBMS로 보내고 결과를 받기
*/
-- 현재 오라클에 접속된 사용자(sys)가 관리하는 table들이 있는데
--그 중에서 tab 이라는 이름의 table정보를 가져와서 나에게 보여달라.

-- 오라클의 tap table은 현재 접속된 사용자가 관리하는 DB Object(객체)들의 정보를 보관하고 있는 table
SELECT *
FROM tab;
-- 이렇게 명령문을 여러줄로 입력해도 되고 한줄로 입력해도 된다.
-- tab : 테이블 이름 
-- * : 모든 칼럼


-- ALL_ALL_TABLES : 오라클 System 데이터 사전의 자세한 정보를 보관하는 table
SELECT *
FROM all_all_tables;

-- SELECT 키워드는 FROM절을 포함하는 명령문 형태로 작성을 하며
-- DBMS가 보관하고 있는 데이터를 table 형식으로 보여달라 하는 명령
-- DBMS의 DML(Database Manupulation Language)중에서 Read(조회)를 수행하는 명령
-- CRUD 중에서 R : Read, Retrive을 수행하는 명령문
SELECT *
FROM 주소록;

-- SQL 명령문을 통해서 DB 객체를 만들고 삭제하고, 데이터를 추가, 변경 삭제를 수행할텐데
-- sys 사용자로 접속을 하게 되면 중요한 정보들을 잘못 삭제, 변경 할 우려가 있기 때문에
-- 실습을 위해서 사용자를 생성하여 수행을 할 것이다.

-- 사용자를 추가하는 순서
-- 1. Table Space : 데이터를 저장할 물리적 공간 설정
-- 2. User : 사용자를 생성하고, 물리적 저장공간과 연결

-- TableSpace 생성(Create)
-- Table Space는 오라클에서 Data를 저장할 물리적 공간을 설정하는 것
-- myTS : 앞으로 SQL을 통해서 사용할 TableSpace의 Alias(이름)
-- '.../myTS.dbf' : 저장할 파일 이름
-- Size : 오라클에서는 성능의 효율성을 주기위해 일단 빈 공간을 일정부분 설정하게 된다.
--      크기는 최초의 저장할 데이터의 크기등을 계산하여 설계하고 설정한다.
--      너무 작으면 효율성이 떨어지고, 너무 크면 불필요한 공간을 낭비하게 된다.
--      오라클 xe(Express Edition)에서는 tableSpace의 최대 크기를 11G로 제한한다.
--      만약 Size 10G로 지정ㅎ아고, 용량이 초과되어 AUTO NEXT로 추가가 되는경우
--      전체 Size가 11G를 넘어서면 오류가 나면서 더이상 데이터를 저장할 수 없게 된다.

-- AUTO... NEXT : 만약 초기에 지정한 Size공간에 데이터가 가득차면
--      자동으로 용량을 늘려서 저장 할 수 있도록 만들어라

-- Size의 1M : 기본크기를 1024 * 1024 byte크기로 지정하라. 
--      Size를 지정할 때 1MB라고 하지 않는다.
-- Next 500K : 자동으로 확장(늘리기)를 1024*500 크기로 설정
--      Next를 지정할 때 500KB라 하지 않는다.

-- CREATE로 시작되는 명령문 : DDL(Data definition Language) : 데이터 선언, 생성(추가와는 다름)
CREATE TABLESPACE myTS
DATAFILE 'C:/bizwork/workspace/oracle_data/myTS.dbf'
SIZE 1M AUTOEXTEND ON NEXT 500K;

-- 내 컴퓨터에 설치되어 있는 오라클 DBMS에서 데이터 저장공간으로 myTS를 만들겠다.
-- 그리고 C드라이브 C:\bizwork\workspace\oracle_data 에 myTS로 파일을 저장하겠다.
-- 최초로 1M바이트로 비어있는 공간을 생성하고 나중에 이 공간이 부족하면 500K를 추가하겠다.
-- 최초로 얼마만큼의 공간을 생성할건지 oracle은 설정하게 되어있다. 이유는 이렇게 하면 굉장히 빠른 속도로 데이터를 저장할 수 있다.
-- 우리가 파일을 저장하게 되면 기억장치에 있던 것을 local drive에 저장 그리고 수정시에도 똑같음(엑셀같은 프로그램 경우)
-- 그러나 DBMS같은 경우에는 메모리에 있는 것들이 변경되거나 하는게 아니라 바로 직접 그 파일이 변경됨.

-- 질의작성기에서 코드를 작성할 때 약속
-- DBMS의 SQL문은 특별한 일부 경우를 제외하고 대소문자 구별을 하지 않는다.
-- DBMS, SQL, 오라클과 관련된 키워드는 모두 대문자로 작성할 것
-- 변수, 값, 내용 등은 소문자로 사용하며
-- 특별히 대소문자를 구분해야 하는 경우는 별도로 공지를 할 것.

-- DROP : DDL 명령의 CREATE와 반대되는 개념의 명령문
-- DROP 명령은 데이터를 물리적으로 완전 삭제하는 개념이므로 매우 신중하게 사용해야 한다.
DROP TABLESPACE myTS -- myTS tableSpace를 삭제하면서
INCLUDING CONTENTS AND DATAFILES -- 연관된 정보와 data file도 같이 삭제하고
CASCADE CONSTRAINTS; -- 그리고 설정된 권한, 역할 등이 있으면 그들도 같이 삭제하라

-- 위에서 생성한 TableSpace를 관리하며, 데이터를 조작할 사용자를 생성
CREATE USER user1 IDENTIFIED BY 1234 -- 사용자 ID : user1으로 설정하고 초기 비번을 1234로 설정
DEFAULT TABLESPACE myTS; -- 이걸 안적어주면 user1이 작성한 데이터가 sys에 저장이 되어서 보안에 문제가 될 수 있기 때문에
                         -- myTS에 저장하겠다라고 적어줌.

-- DCL : Data Control Langauge.
-- 새로 생성된 user1에게 권한을 부여하기
-- user1이 로그인만 할 수 있도록 권한(역할)을 부여하라
GRANT CONNECT TO user1;
-- user1이 로그인 할 수 있는 권한을 제거
REVOKE CONNECT FROM user1;

-- user1이 로그인을 수행하고, 최소한으로 데이터들을 관리할 수 있도록 권한을 부여
-- RESOURCE : 오라클에서 USER에게 줄 수 있는 권한 중 상당히 많은 일을 수행할 수 있는 권한
-- 현재 시스템에 설치된 모든 TableSpace를 대상으로 무제한(TableSpace가 허용하는 범위) 저장이 가능한 권한
-- RESOURCE 권한은 Standard, Enterprise DBMS에서는 함부로 부여해서는 안된다.
-- CONNECT, RESOURCE 권한을 부여하게 되면 거의 DBA수준의 권한을 갖게 된다.
GRANT CONNECT,RESOURCE TO user1;

-- login권한과 table을 생성할 수 있는 권한
GRANT CONNECT,CREATE TABLE TO user1;
-- login 권한, table 생성권한, 학생정보 테이블에 데이터를 추가할 수 있는 권한
GRANT CONNECT,CREATE TABLE, INSERT TABLE 학생정보 TO user1;

-- login, table생성, 학생정보 추가, 학생정보 조회
GRANT CONNECT,CREATE TABLE, INSERT TABLE 학생정보, SELECT TABLE 학생정보 TO user1;
-- 이런식으로 세부적으로 정책에 따라 부여를 세세하게 해주어야 한다.

-- 권한을 세부적으로 부여하는 것은 실무상에서 매우 필요하며 중요한 일이다.
-- 하지만 학습하는 입장에서 GRANT 부여하는데 너무 많은 노력을 보이면 피곤하니
-- xe 버전에서는 사용자에게 DBA권한을 부여하고, 실습을 수행한다.
GRANT DBA TO user1;

-- DBA 권한(Roll)은 sysDBA보다 한단계 낮은 권한 등급을 가지며
-- 일반적으로 자신이 생성한 Table 등 DB Object만 접근하여 명령을 수행한다.
