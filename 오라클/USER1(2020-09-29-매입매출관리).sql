-- 여기는 Loo9 샵의 매입매출 관리 간편장부 입니다

CREATE TABLE tbl_iolist(
    seq	NUMBER		PRIMARY KEY,
    IO_DATE	VARCHAR2(10),		
    IO_TIME	VARCHAR2(10),		
    IO_PNAME	nVARCHAR2(30)	NOT NULL,	
    IO_INPUT	CHAR(1)	NOT NULL,	
    IO_PRICE	NUMBER	NOT NULL,	
    IO_QUAN	NUMBER	NOT NULL,	
    IO_TOTAL	NUMBER		
);

SELECT * FROM tbl_iolist;

CREATE SEQUENCE SEQ_IOLIST
START WITH 1 INCREMENT BY 1;


INSERT INTO tbl_iolist(
    seq,
    IO_DATE,
    IO_TIME,
    IO_PNAME,
    IO_INPUT,
    IO_PRICE,
    IO_QUAN,	
    IO_TOTAL
)VALUES(
    SEQ_IOLIST.nextval,
    '2020-09-29',
    '12:53:21',
    '후드티',
    1,
    12000,
    5,	
    12000*5
    );

INSERT INTO tbl_iolist(
    seq,
    IO_DATE,
    IO_TIME,
    IO_PNAME,
    IO_INPUT,
    IO_PRICE,
    IO_QUAN,	
    IO_TOTAL
)VALUES(
    SEQ_IOLIST.nextval,
    '2020-03-24',
    '19:22:21',
    '롱팬츠',
    2,
    49000,
    5,	
    49000*5
    );
    
COMMIT;