-- 여기는 user1화면입니다.

-- 블로그 테이블 생성
CREATE TABLE tbl_blogs(
    bl_seq	NUMBER		PRIMARY KEY,
    bl_user	nVARCHAR2(20)	NOT NULL,	
    bl_date	VARCHAR2(10)	NOT NULL,	
    bl_time	VARCHAR2(10)	NOT NULL,	
    bl_title	nVARCHAR2(125)	NOT NULL,	
    bl_contents	nVARCHAR2(2000)	NOT NULL	
);

-- 일련번호 생성을 위하여 SEQENCE 생성
-- 시작 값을 1 그리고 1씩 증가하는 조건
CREATE SEQUENCE seq_blog
START WITH 1
INCREMENT BY 1;

/*
    SQL Developer와 기타 다른 프로그래밍 프로젝트와 연동을 할 때
    SQL Developer에서 insert, delete를 수행했음에도 불구하고
    프로젝트에서 조회되는 데이터에 반영이 안되는 경우가 있다.
    
    원인
    SQL Developer에서 CUD(Insert, Updqte, Delete)를 수행하면
    실제 로컬 스토리지의 Data에 직접 적용이 안된다.
    변경한 데이터는 메모리 기억장치에 저장되어 있을 뿐
    
    프로그래밍 프로젝트에서 반영된 결과를 가져다 사용 하려면 
    COMMIT 명령을 수행해 주어야 한다.


*/
INSERT INTO tbl_blogs(bl_seq,bl_user, bl_date, bl_time, bl_title, bl_contents)
VALUES (SEQ_BLOG.nextval, '홍길동', '2020-08-14' ,'09:47:00','나의 블로그','블로그를 만들자');

INSERT INTO tbl_blogs(bl_seq,bl_user, bl_date, bl_time, bl_title, bl_contents)
VALUES (SEQ_BLOG.nextval, '이몽룡', '2020-08-14' ,'09:47:01','블로그 축하','블로그를 만들자');

INSERT INTO tbl_blogs(bl_seq,bl_user, bl_date, bl_time, bl_title, bl_contents)
VALUES (SEQ_BLOG.nextval, '성춘향', '2020-08-14' ,'09:47:02','블로그 축하','블로그를 만들자');

SELECT * FROM tbl_blogs;
COMMIT;