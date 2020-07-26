CREATE TABLE tbl_student(

    st_num	CHAR(5)		PRIMARY KEY,
    st_name	nVARCHAR2(20)	NOT NULL,	
    st_tel	nVARCHAR2(13),		
    st_addr	nVARCHAR2(125),		
    st_grade	CHAR(1),		
    st_dept	CHAR(3),		
    st_dname	nVARCHAR2(20),		
    st_prof	nVARCHAR2(20)		
);

DESC tbl_student;


CREATE TABLE tbl_score(
    sc_scode	CHAR(4)		PRIMARY KEY,
    sc_num	CHAR(5)	NOT NULL,	
    sc_dept	nVARCHAR2(20),		
    sc_score	NUMBER		
	
);

DESC tbl_score;


SELECT st_num, st_name, st_tel, st_addr, sc_dept, sc_score 
FROM tbl_student ST
    LEFT JOIN tbl_score S
        ON st.st_num = s.sc_num;
        
SELECT * FROM tbl_score;
DROP TABLE tbl_score;

SELECT sc_dept
FROM tbl_score
GROUP BY sc_dept;
소프트웨어공학
음악
데이터베이스
수학
국어
미술
영어

SELECT sc_num, sc_dept, sc_score
FROM tbl_score;


SELECT *
FROM tbl_student;

SELECT sc_num,
    DECODE(sc_dept,'국어', sc_score,0) AS 국어점수,
    DECODE(sc_dept,'영어', sc_score,0) AS 영어점수,
    DECODE(sc_dept,'수학', sc_score,0) AS 수학점수,
    DECODE(sc_dept,'미술', sc_score,0) AS 미술점수
FROM tbl_score
ORDER BY sc_num;

    
SELECT st_num,
    SUM(DECODE(sc_dept,'국어', sc_score,0)) AS 국어점수,
    SUM(DECODE(sc_dept,'영어', sc_score,0)) AS 영어점수,
    SUM(DECODE(sc_dept,'수학', sc_score,0)) AS 수학점수,
    SUM(DECODE(sc_dept,'미술', sc_score,0)) AS 미술점수,
   
    SUM(DECODE(sc_dept,'국어', sc_score,0))+SUM(DECODE(sc_dept,'영어', sc_score,0))
    +SUM(DECODE(sc_dept,'수학', sc_score,0))+SUM(DECODE(sc_dept,'미술', sc_score,0)) AS 합계,
    
    (SUM(DECODE(sc_dept,'국어', sc_score,0))+SUM(DECODE(sc_dept,'영어', sc_score,0))
    +SUM(DECODE(sc_dept,'수학', sc_score,0))+SUM(DECODE(sc_dept,'미술', sc_score,0)))/4 AS 평균
FROM tbl_student ST
    LEFT JOIN tbl_score SC
        ON ST.st_num = SC.sc_num
GROUP BY st_num
ORDER BY st_num;


