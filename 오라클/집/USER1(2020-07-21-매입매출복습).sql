SELECT * FROM tbl_buyer;

SELECT b_tel, COUNT(*) 
FROM tbl_buyer
GROUP BY b_tel
HAVING COUNT(*) >1;

ALTER TABLE tbl_iolist add ( io_bcode CHAR(4) DEFAULT ' ');
ALTER TABLE tbl_iolist MODIFY ( io_bcode CONSTRAINT io_bcode NOT NULL);

DESC tbl_iolist;

UPDATE tbl_iolist IO
SET IO.io_bcode =
(
    SELECT b_code
    FROM tbl_buyer B
    WHERE IO.io_dname = B.b_name AND B.b_ceo = IO.io_dceo
);

SELECT io_bcode, io_dname, b_code, b_name
FROM tbl_iolist IO
    LEFT JOIN tbl_buyer B
        ON IO.io_bcode = B.b_code;

ALTER TABLE tbl_iolist DROP COLUMN io_pname;
ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;


CREATE VIEW view_iolist
AS
(
SELECT io_seq, io_date,
        io_pcode, p_name, p_iprice, p_oprice,
        io_inout,
        DECODE(io_inout,'매입',io_price,0) AS 매입단가,
        DECODE(io_inout,'매출',io_price,0) AS 매출단가,
        DECODE(io_inout,'매입',io_amt,0) AS 매입금액,
        DECODE(io_inout,'매출',io_amt,0) AS 매출금액
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
    LEFT JOIN tbl_buyer B
        ON IO.io_bcode = B.b_code
);        
        
SELECT * FROM view_iolist;