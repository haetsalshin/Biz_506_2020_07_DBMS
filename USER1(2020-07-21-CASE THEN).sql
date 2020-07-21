-- 여기는 user1 화면입니다.


-- MySQL에서 작성한 SELECT문
-- 이렇게 해도 똑같이 호출은 된다.

-- 썜) 표준 SQL
-- CASE WHEN  조건문 then true 일 때 값 ELSE false일 때 값 END
-- DECODE (칼럼, 조건값, true 일 때, false일 때)
SELECT io_bcode,
	SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS 매입합계,
	SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) AS 매출합계
FROM tbl_iolist
group by io_bcode
ORDER BY io_bcode;

-- 오라클에서 차후에 PK를 생성하는 방법
-- 기존의 PK가 있으면 중복 생성되지 않는다
-- PK_iolist : 오라클에서만 사용되는 PK를 찾는 별명
--      혹시 PK를 삭제할 일이 있을 때 필요한 이름
ALTER TABLE tbl_iolist ADD CONSTRAINT PK_iolist PRIMARY KEY (io_seq, io_date);