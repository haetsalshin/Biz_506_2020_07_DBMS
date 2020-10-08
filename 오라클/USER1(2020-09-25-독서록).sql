-- USER1 독서록 프로젝트
DROP TABLE tbl_member;
CREATE TABLE tbl_member (
    M_USERID	VARCHAR2(30)		PRIMARY KEY,
    M_PASSWORD	nVARCHAR2(255)	NOT NULL,
    M_NAME	nVARCHAR2(30),		
    M_TEL	VARCHAR2(30),
    M_EMAIL	VARCHAR2(30),
    M_ADDRESS	nVARCHAR2(125),		
    M_ROLL	VARCHAR2(20),		
    -- ENABLE 칼럼에 문자열 0 또는 1 이외의 값은 저장하지 말라
    -- CHECK 제약사항 등록
    
    ENABLED	CHAR(1)	DEFAULT'0' CONSTRAINT enable_veri CHECK(ENABLED = '0' OR ENABLED ='1'),	
    AccountNonExpired	CHAR(1),		
    AccountNonLocked	CHAR(1),	
    CredentialsNonExpired	CHAR(1)		
);

COMMIT;


CREATE TABLE tbl_authority(
    seq	NUMBER		PRIMARY KEY,
    M_USERID	VARCHAR2(30)	NOT NULL,
    M_ROLE	VARCHAR2(30)	NOT NULL	
);

CREATE SEQUENCE seq_authority
START WITH 1 INCREMENT BY 1;

SELECT * FROM tbl_member;

COMMIT;

SELECT * FROM tbl_member;
SELECT * FROM tbl_authority;

-- 한개의 table에 여러개의 데이터를 INSERT 할 때 사용하는 다중 INSERT SQL이다.
-- seq 값으로 PK설정을 해두면 SQL이 작동ㅇ르 하지 않는다.
INSERT ALL
    INTO tbl_member(m_userid,m_password) VALUES('user1',1)
    INTO tbl_member(m_userid,m_password) VALUES('user2',1)
    INTO tbl_member(m_userid,m_password) VALUES('user3',1)
    INTO tbl_member(m_userid,m_password) VALUES('user4',1)
    INTO tbl_member(m_userid,m_password) VALUES('user5',1)
SELECT * FROM dual;


-- SEQ 값을 시퀀스의 NEXTVAL 값으로 설정하는 TABLE의 경우 다중 INSERT가 오류 발생을 한다.
INSERT ALL 
    INTO tbl_authority (seq,m_userid, m_role) VALUES (seq_authority.nextval,'admin','ADMIN')
    INTO tbl_authority (seq,m_userid, m_role) VALUES (seq_authority.nextval,'admin1','ADMIN')
    INTO tbl_authority (seq,m_userid, m_role) VALUES (seq_authority.nextval,'admin2','ADMIN')
    INTO tbl_authority (seq,m_userid, m_role) VALUES (seq_authority.nextval,'admin3','ADMIN')
SELECT * FROM dual;

-- 오라클에서 SEQ PK 칼럼을 가진 table db 다중 insert 문을 수행하기 위해서
-- 1. 추가할 데이터를 갖는 가상의 table을 생성
-- 2. 가상 table 생성 SQL을 서브쿼리 묶는다.
-- 3. 서브쿼리 부모 SQL에서 seq.nextval 실행하여 UNIQUE한 SEQ을 생성
-- 4. 생성된 가상 테이블 데이터를 INSERT문을 사용하여 Table에 추가
-- 5. 생성된 가상 테이블의 데이터를 tbl_authority table에 복사하는 코드

INSERT INTO tbl_authority (seq, m_userid, m_role)
SELECT SEQ_AUTHORITY.NEXTVAL, SUB.* FROM
(
-- 가상테이블
    SELECT 'user11' AS USERNAME ,'ROLE_ADMIN'AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user11' AS USERNAME ,'ROLE_USER'AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user12' AS USERNAME ,'ROLE_ADMIN'AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user12' AS USERNAME ,'ROLE_USER'AS AUTHORITY FROM DUAL
) SUB;

SELECT * FROM tbl_authority;
SELECT * FROM tbl_member;
COMMIT;

SELECT * FROM tbl_member M
 LEFT JOIN tbl_authority A
   ON m.m_userid = A.m_userid;

COMMIT;

UPDATE tbl_member SET enabled = 1 WHERE m_userid = 'user';