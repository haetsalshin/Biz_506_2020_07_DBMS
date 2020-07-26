SELECT io_pname,
    MIN(DECODE(io_inout,'매입',io_price,0)) AS 매입단가,
    MAX(DECODE(io_inout,'매출',io_price,0)) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

SELECT io_pname,
    MIN(DECODE(io_inout,'매입',io_price,0)) AS 매입단가,
    MAX(DECODE(io_inout,'매출',io_price,0)) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

CREATE TABLE tbl_product(
        p_code	CHAR(5)		PRIMARY KEY,
        p_name	nVARCHAR2(125)	NOT NULL,	
        p_iprice	NUMBER,		
        p_oprice	NUMBER,		
        p_vat	CHAR(1)		DEFAULT '1'
);

SELECT IO.io_pname,P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
WHERE P.p_name IS NULL AND IO.io_pname IS NULL;

ALTER TABLE tbl_iolist ADD io_pcode CHAR(5);

ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) NOT NULL);

ALTER TABLE tbl_iolist ADD ( io_pcode CHAR(5) DEFAULT ' ' );
ALTER TABLE tbl_iolist MODIFY (io_pcode CONSTRAINT io_pcode NOT NUll);

ALTER TABLE tbl_iolist MODIFY ( io_pcode CHAR(10));

UPDATE tbl_iolist IO
SET io_pcode =
(    SELECT p_code
    FROM tbl_product P
    WHERE p_name = IO.io_pname
);

SELECT * FROM tbl_iolist;


SELECT io_pname, 
    MIN(DECODE(io_inout,'매입',io_amt,0)) AS 매입가격,
    MAX(DECODE(io_inout,'매출',io_amt,0)) AS 매출가격,
FROM tbl_iolist
GROUP BY io_pname;
    
    
SELECT io_pname,
MIN(DECODE(io_inout,'매입',io_price,0)) AS 매입단가,
MAX(DECODE(io_inout,'매출',io_price,0)) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

SELECT io_dname, io_dceo
FROM tbl_iolist
GROUP BY io_dname, io_dceo
ORDER BY io_dname;

CREATE TABLE tbl_buyer
(	
    b_code	CHAR(4)		PRIMARY KEY,
    b_name	nVARCHAR2(125)	NOT NULL,	
    b_ceo	nVARCHAR2(50)	NOT NULL,	
    b_tel	VARCHAR2(20)		

);

    