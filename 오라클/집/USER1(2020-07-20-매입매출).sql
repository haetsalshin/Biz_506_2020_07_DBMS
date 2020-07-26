CREATE TABLE tbl_iolist(
    io_seq	NUMBER		PRIMARY KEY,
    io_date	VARCHAR2(10)	NOT NULL,
    io_pname	nVARCHAR2(125)	NOT NULL,	
    io_dname	nVARCHAR2(125)	NOT NULL,	
    io_dceo	nVARCHAR2(125)	NOT NULL,	
    io_inout	nVARCHAR2(2)	NOT NULL,	
    io_qty	NUMBER		DEFAULT 0,
    io_price	NUMBER		DEFAULT 0,
    io_amt	NUMBER		DEFAULT 0
);

SELECT COUNT(*) FROM tbl_iolist;

SELECT io_inout, COUNT(*)
FROM tbl_iolist
GROUP BY io_inout;

SELECT * FROM tbl_iolist
WHERE io_price = 0 OR io_amt = 0;

SELECT * FROM tbl_iolist
WHERE io_pname IN ( '투니스','7+8칫솔','레종블루');
-- 투니스 5번1000원 칫솔 10번 2500원 레종블로 28번4500

UPDATE tbl_iolist
SET io_price = 1000,
    io_amt = io_qty * 1000
WHERE io_seq = 5;

UPDATE tbl_iolist
SET io_price = 2500,
    io_amt = io_qty * 2500
WHERE io_seq = 10;

UPDATE tbl_iolist
SET io_price = 4500,
    io_amt = io_qty * 4500
WHERE io_seq = 28;

SELECT 

    SUM(DECODE (io_inout,'매입',io_amt,0)) AS 매입합계,
    SUM(DECODE (io_inout,'매출',io_amt,0)) AS 매출합계,
    SUM(DECODE (io_inout,'매출',io_amt,0))- SUM(DECODE (io_inout,'매입',io_amt,0)) AS 이익
FROM tbl_iolist
--WHERE (io_seq > 0 AND io_seq <=10) OR ( io_seq >= 300 AND io_seq <310)
ORDER BY io_dname;
    
    
    
    
    
    
