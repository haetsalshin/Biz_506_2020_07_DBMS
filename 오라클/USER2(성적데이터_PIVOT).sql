-- 여기는 user2 화면입니다.

CREATE table tbl_성적(
    학번 char(5),
    과목명 nvarchar2(20),
    점수 number
);

select * from tbl_성적;

-- 표준 sql 이용한 pivot
-- 1. 어떤 칼럼을 기준칼럼으로 할 것인가 : 학번 칼럼을 기준으로 삼는다.
-- 2. 어떤 칼럼을 group by로 설정을 하게 되면 나지 칼럼은
--    통계함수로 감싸거나, 아니면 group by에 칼럼을 포함해 주어야 한다.

-- 3. 점수를 sum 함수를 묶어주는 이유와 결과
-- 4. 학번을 group by로 묶어서 여러개로 저장된 학번을 1개만 보이도록 하기 위해
--    계산되는 각 과목의 점수를 sum() 묶어준다.
--    현재 테이블 구조에서 한번 + 과목의 점수는 전체 데이터에서 1개의 레코드만 존재한다.
--    따라서 sum()함수는 무언가 합산을 하는 용도가 아니라, 단순히 group by를 사용할 수 있도록 하는 용도일 뿐이다.

-- MySQL으로 만들 때는 이렇게 만들어준다.
select 학번,
    sum(case when 과목명 = '국어' then 점수 else 0 end) as 국어, -- sum을 쓰는 용도는 group by를 할 수 있게 해주는 용도
    sum(case when 과목명 = '영어' then 점수 else 0 end) as 영어,
    sum(case when 과목명 = '수학' then 점수 else 0 end) as 수학
from tbl_성적
group by 학번;

SELECT  학번,
    SUM(DECODE(과목명,'국어',점수,0)) AS 국어,
    SUM(DECODE(과목명,'영어',점수,0)) AS 영어,
    SUM(DECODE(과목명,'수학',점수,0)) AS 수학
FROM tbl_성적
GROUP BY 학번;


-- 오라클 11g부터 지원하는 PIVOT 기능을 사용하는 방법
-- PIVOT() : 특정한 칼럼을 기준으로 데이터를 PIVOT View로 나타내는 내장 함수
-- PIVOT( sum(값)) : PIVOT으로 나열할 데이터 값이 들어있는 칼럼을 sum()으로 묶어서 표시
-- FOR 칼럼 (칼럼값들) : '칼럼'에 '칼럼값'으로 가로(COULUM) 방향 나열하여 가상칼럼으로 만들기

SELECT 학번, 국어, 영어, 수학
FROM tbl_성적
PIVOT (
    SUM (점수)
    FOR 과목명 IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학)
);    

CREATE TABLE tbl_학생정보(
    학번	CHAR(5) PRIMARY KEY,
    학생이름	nVARCHAR2(30) NOT NULL,
    전화번호	VARCHAR2(20),
    주소	nVARCHAR2(125),
    학년	NUMBER,
    학과  CHAR(3)
);

SELECT * FROM tbl_학생정보;

-- 학번 칼럼명을 사용했는데 이 칼럼이 어떤 table에 있는 칼럼인지 모르겠다.
-- JOIN을 수행하여 다수의 Table이 Relation되었을 떄
--      다수의 talbe에 같은 이름의 칼럼이 있을 때 발생하는 오류
-- 영문으로 작성 할 때는 칼럼에 prefix를 붙여서 이런 오류를 막지만
-- 실제 프로젝트에서 여러 테이블에 DOMAIN 설정(같은 정보를 담는 칼럼)을 만들 경우
-- prefix를 통일하는 경우도 많다.
-- 이 때는 아래 오류를 매우 자주 접하게 된다.
-- 학번 = > SC.학번
-- ORA-00918: column ambiguously defined
-- 00918. 00000 -  "column ambiguously defined

-- 이 오류를 방지하기 위해 2개 이상의 table을 join 할 때는 table에 Alias를 설정하고
-- AS.칼럼 형식으로 어떤 Table의 칼럼인지 명확히 지정을 해 주는 것이 좋다.
-- JOIN, SUBQUERY를 만들 떄 한개의 테이블에 여러번 사용할 경우 반드시 Alias를 설정하고
--      명확히 칼럼을 지정해 주어야 한다.

-- 통계함수로 감싸지 않은 칼럼을 반드시 GROUP BY에 명시
SELECT  SC.학번, ST.학생이름, st.전화번호,
    SUM(DECODE(SC.과목명,'국어',SC.점수,0)) AS 국어,
    SUM(DECODE(SC.과목명,'영어',SC.점수,0)) AS 영어,
    SUM(DECODE(SC.과목명,'수학',SC.점수,0)) AS 수학
FROM tbl_성적 SC
    LEFT JOIN tbl_학생정보 ST
        ON SC.학번 = ST.학번
GROUP BY SC.학번, ST.학생이름, st.전화번호;


CREATE VIEW view_성적PIVOT
AS
(
    SELECT 학번, 국어, 영어, 수학
    FROM tbl_성적
    PIVOT (
        SUM (점수)
        FOR 과목명 IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학)
    )  
);

SELECT * FROM "VIEW_성적PIVOT";

SELECT SC.학번, ST.학생이름, SC.국어, SC.영어, SC.수학
FROM "VIEW_성적PIVOT" SC
    LEFT JOIN "TBL_학생정보" ST
        ON st."학번" = sc."학번"
ORDER BY 학번;

SELECT SC.학번, ST.학생이름, SC.국어, SC.영어, SC.수학
FROM
(
    SELECT 학번, 국어, 영어, 수학
        FROM tbl_성적
        PIVOT (
            SUM (점수)
            FOR 과목명 IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학)
    )
) SC
    LEFT JOIN tbl_학생정보 ST
        ON ST.학번 = SC.학번
ORDER BY SC.학번;










