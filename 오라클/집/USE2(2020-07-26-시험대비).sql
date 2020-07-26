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

CREATE TABLE tbl_score(
    sc_scode	CHAR(4)		PRIMARY KEY,
    sc_num	CHAR(5)	NOT NULL,	
    sc_dept	nVARCHAR2(20),		
    sc_score	NUMBER		
);

CREATE TABLE tbl_dept(
d_dcode	CHAR(4)		PRIMARY KEY,
d_num	CHAR(5)	UNIQUE,
d_dept	CHAR(3)	NOT NULL	
);

SELECT * FROM tbl_student;

-- 바꿔야 할 데이터
-- st_dept , st_dname , st_prof

-- st_dept => tbl_dept 기준으로 변경 o
-- st_dname, st_prof = >tbl_dinfo 기준으로 변경

UPDATE tbl_student ST
SET st_dept =
(
SELECT d_dept  
FROM tbl_dept D
WHERE ST.st_num = D.d_num
);

SELECT * FROM tbl_student;

UPDATE tbl_student ST
SET st_dname =
(
SELECT di_dname
FROM tbl_dinfo DI
WHERE ST.st_dept = di.di_dcode
);

SELECT * FROM tbl_student;


UPDATE tbl_student ST
SET st.st_prof =
(
SELECT di.di_prof
FROM tbl_dinfo DI
WHERE ST.st_dept = di.di_dcode
);

SELECT * FROM tbl_student;

CREATE VIEW view_score
AS
(
SELECT st_num AS 학번 , 
    SUM(DECODE(sc_dept,'국어',sc_score,0)) AS 국어점수,
    SUM(DECODE(sc_dept,'영어',sc_score,0)) AS 영어점수,
    SUM(DECODE(sc_dept,'수학',sc_score,0)) AS 수학점수,
    SUM(DECODE(sc_dept,'미술',sc_score,0)) AS 미술점수,
    
    SUM(DECODE(sc_dept,'국어',sc_score,0)) 
    +SUM(DECODE(sc_dept,'영어',sc_score,0))
    +SUM(DECODE(sc_dept,'수학',sc_score,0)) 
    +SUM(DECODE(sc_dept,'미술',sc_score,0)) AS 합계,
    
    ROUND((SUM(DECODE(sc_dept,'국어',sc_score,0)) 
    +SUM(DECODE(sc_dept,'영어',sc_score,0))
    +SUM(DECODE(sc_dept,'수학',sc_score,0)) 
    +SUM(DECODE(sc_dept,'미술',sc_score,0)))/4) AS 평균
    
    FROM tbl_student ST
        LEFT JOIN tbl_score S
            ON ST.st_num = S.sc_num
GROUP BY st_num
);

DROP VIEW view_score;

SELECT * FROM view_score
ORDER BY 학번;

SELECT st_num, st_dept, st_dname,st_prof, 국어점수, 영어점수, 수학점수, 미술점수, 합계, 평균
    FROM tbl_student ST
        LEFT JOIN view_score S
         ON ST.st_num = S."학번"
ORDER BY st_num;
        
