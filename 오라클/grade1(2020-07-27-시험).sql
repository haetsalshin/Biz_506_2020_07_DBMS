-- 여기는 grade1 화면입니다.

CREATE TABLE tbl_student(
    st_num	CHAR(5)		PRIMARY KEY,
    st_name	nVARCHAR2(20)	NOT NULL,	
    st_tel	VARCHAR2(13)	NOT NULL,	
    st_addr	nVARCHAR2(125),		
    st_grade	CHAR(1)	NOT NULL,	
    st_dept	CHAR(3)	NOT NULL	
);

CREATE TABLE  tbl_dept(
    d_dcode	CHAR(3)		PRIMARY KEY,
    d_dname	nVARCHAR2(20)	NOT NULL,	
    d_prof	nVARCHAR2(20)		
);

CREATE TABLe tbl_score(
    sc_scode	CHAR(4)		PRIMARY KEY,
    sc_num	CHAR(5) NOT NULL,		
    sc_subname	nVARCHAR2(20) NOT NULL,		
    sc_score	NUMBER NOT NULL
);

DESC tbl_student;
DESC tbl_dept;
DESC tbl_score;

DROP TABLE tbl_student;
DROP TABLE tbl_dept;
DROP TABLe tbl_score;


-- 학생정보 테이블 데이터 INSERT
INSERT INTO tbl_student ( st_num,st_name,st_tel,st_addr,st_grade,st_dept)
VALUES ('20001','갈한수','010-2217-7851','경남 김해시 어방동 1088-7','3','008');

INSERT INTO tbl_student ( st_num,st_name,st_tel,st_addr,st_grade,st_dept)
VALUES ('20002','강이찬','010-4311-1533','강원도 속초시 대포동 956-5','1','006');

INSERT INTO tbl_student ( st_num,st_name,st_tel,st_addr,st_grade,st_dept)
VALUES ('20003','개원훈','010-6262-7441','경북 영천시 문외동 38-3','1','009');

INSERT INTO tbl_student ( st_num,st_name,st_tel,st_addr,st_grade,st_dept)
VALUES ('20004','경시현','010-9794-9856','서울시 구로구 구로동 3-35','1','006');

INSERT INTO tbl_student ( st_num,st_name,st_tel,st_addr,st_grade,st_dept)
VALUES ('20005','공동영','010-8811-7761','강원도 동해시 천곡동 1077-3','2','010');


SELECT * FROM tbl_student;

-- 학과 정보 테이블 데이터 INSERT
INSERT INTO tbl_dept ( d_dcode, d_dname, d_prof)
VALUES ('001','컴퓨터공학','토발즈');

INSERT INTO tbl_dept ( d_dcode, d_dname, d_prof)
VALUES ('002','전자공학','이철기');

INSERT INTO tbl_dept ( d_dcode, d_dname, d_prof)
VALUES ('003','법학','킹스필드');

SELECT * FROM tbl_dept;

-- 학생 성적 테이블 데이터 INSERT

INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S001','20001','데이터베이스',71);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S002','20001','수학',63);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S003','20001','미술',50);
--------------------------------------
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S004','20002','데이터베이스',80);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S005','20002','음악',75);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S006','20002','국어',52);
----------------------------------------
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S007','20003','수학',89);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S008','20003','영어',63);
INSERT INTO tbl_score ( sc_scode, sc_num, sc_subname, sc_score)
VALUES ('S009','20003','국어',70);
-----------------------------------------
SELECT * FROM tbl_score;

-- 학생정보 전체 데이터 조회
SELECT * 
FROM tbl_student;

-- 학생성적에서 성적이 60점 미만인 학생들의 학번 조회
SELECT sc_num
FROM tbl_score
WHERE sc_score < 60;

-- 공동영 학생 주소를 광주광역시 북구 중흥로 경양로 170번으로 변경하시오
-- 공동영 학생 20005
SELECT *
FROM tbl_student
WHERE st_name = '공동영';

UPDATE tbl_student
SET st_addr = '광주광역시 북구 중흥로 경양로 170번'
WHERE st_num = '20005';

-- 개원훈 학생이 자퇴를 하고 캐나다 이민을 떠났습니다. 해당 학생의 데이터를 삭제하시오
-- 개원훈 학생 학번 20003
SELECT *
FROM tbl_student
WHERE st_name = '개원훈';

DELETE FROM tbl_student
WHERE st_num = '20003';

SELECT * FROM tbl_student;

--4.1 학생정보 테이블을 조회했을 때 “학과명”과 “교과교수”를 함께 볼 수 있도록 SQL을 작성하시오.
SELECT ST.st_num, ST.st_name, ST.st_tel, ST.st_addr, ST.st_grade, ST.st_dept, D.d_dname, D.d_prof
FROM tbl_student ST
    LEFT JOIN tbl_dept D
        ON ST.st_dept = D.d_dcode;
--4.2 학생성적테이블에서 학생의 학번별 총점과 평균을 구하시오
SELECT sc_num AS 학번,
    SUM(sc_score) AS 총점,
    TRUNC((AVG(sc_score)), 2) AS 평균
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;

-- 4.3 학생성적 테이블에서 학생의 학번별 총점과 평균을 구하고, “학생이름”,“전화번호”를 포함하여 조회하시오.
SELECT sc_num AS 학번, ST.st_name AS 이름, ST.st_tel AS 전화번호,
    SUM(sc_score) AS 총점,
    TRUNC((AVG(sc_score)), 2) AS 평균
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num
GROUP BY sc_num,  ST.st_name, ST.st_tel
ORDER BY sc_num;

-- 5-1. 학생성적 테이블에서 다음 결과를 작성하시오.
SELECT sc_num AS 학번,
    SUM(DECODE(sc_subname,'국어',sc_score,0)) AS 국어,
    SUM(DECODE(sc_subname,'영어',sc_score,0)) AS 영어,
    SUM(DECODE(sc_subname,'수학',sc_score,0)) AS 수학,
    SUM(DECODE(sc_subname,'음악',sc_score,0)) AS 음악,
    SUM(DECODE(sc_subname,'미술',sc_score,0)) AS 미술,
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) AS 소프트웨어공학,
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 데이터베이스,
    
    SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 총점,
    
    TRUNC((SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)))/7, 2) AS 평균

FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;
-- 5.2 학생정보, 학생성적 테이블을 이용하여 다음 결과를 작성하시오.
SELECT sc_num AS 학번, ST.st_name AS 이름, ST.st_tel AS 전화번호, ST.st_dept AS 학과코드, 
    SUM(DECODE(sc_subname,'국어',sc_score,0)) AS 국어,
    SUM(DECODE(sc_subname,'영어',sc_score,0)) AS 영어,
    SUM(DECODE(sc_subname,'수학',sc_score,0)) AS 수학,
    SUM(DECODE(sc_subname,'음악',sc_score,0)) AS 음악,
    SUM(DECODE(sc_subname,'미술',sc_score,0)) AS 미술,
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) AS 소프트웨어공학,
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 데이터베이스,
    
    SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 총점,
    
    TRUNC((SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)))/7, 2) AS 평균

FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num
GROUP BY sc_num, ST.st_name, ST.st_tel, ST.st_dept
ORDER BY sc_num;  

-- 5.3 다음과 같이 성적정보를 조회하는 SQL을 작성하시오
SELECT sc_num AS 학번, ST.st_name AS 이름, ST.st_tel AS 전화번호, ST.st_dept AS 학과코드, D.d_dname  AS 학과명,
    SUM(DECODE(sc_subname,'국어',sc_score,0)) AS 국어,
    SUM(DECODE(sc_subname,'영어',sc_score,0)) AS 영어,
    SUM(DECODE(sc_subname,'수학',sc_score,0)) AS 수학,
    SUM(DECODE(sc_subname,'음악',sc_score,0)) AS 음악,
    SUM(DECODE(sc_subname,'미술',sc_score,0)) AS 미술,
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) AS 소프트웨어공학,
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 데이터베이스,
    
    SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)) AS 총점,
    
    TRUNC((SUM(DECODE(sc_subname,'국어',sc_score,0)) +
    SUM(DECODE(sc_subname,'영어',sc_score,0)) +
    SUM(DECODE(sc_subname,'수학',sc_score,0)) +
    SUM(DECODE(sc_subname,'음악',sc_score,0)) +
    SUM(DECODE(sc_subname,'미술',sc_score,0)) +
    SUM(DECODE(sc_subname,'소프트웨어공학',sc_score,0)) +
    SUM(DECODE(sc_subname,'데이터베이스',sc_score,0)))/7, 2) AS 평균

FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num
    LEFT JOIN tbl_dept D
        ON sT.st_dept = D.d_dcode
GROUP BY sc_num, ST.st_name, ST.st_tel, ST.st_dept, D.d_dname
ORDER BY sc_num;