-- 여기는 user2화면입니다.

-- 아래와 같이 각 번호와 코드들이 중복값이 올 수 있어서 PK가 될 수 없다
-- 따라서 새로운 SEQ만든다.
-- 주문번호,  고객번호, 상품코드
-- O00001     C0032      P00001
-- O00001     C0032      P00002
-- O00001     C0032      P00003

SELECT * FROM tbl_주문서원장
ORDER BY 주문번호;

--------------------------------------------------
--주문서 원장
--------------------------------------------------
CREATE TABLE tbl_order(
        O_SEQ	NUMBER		PRIMARY KEY,
        O_NUM	CHAR(6)	NOT NULL,	
        O_DATE	CHAR(10)	NOT NULL,	
        O_CNUM	CHAR(5)	NOT NULL,	
        O_PCODE	CHAR(6)	NOT NULL,	
        O_PNAME	nVARCHAR2(125),		
        O_PRICE	NUMBER,		
        O_QTY	NUMBER,		
        O_TOTAL	NUMBER		
);

-- tbl_order Table을 만들면서 여기에 추가될 데이터들 중에 1개의 칼럼으로는 PK를 만들수 없어서
-- 임의의 일련번호 칼럼을 하나 추가하고 이 칼럼을 PK로 선언했다.
-- 이 상황이 되면 데이터를 추가할 때 일일이 O_SEQ 칼럼에 저장된 데이터들을 살펴보고
-- 등록되지 않은 숫자를 만든다음 그 값으로 SEQ값을 정하고 INSERT를 수행해야 한다.
-- 이런 방식은 코드를 매우 불편하게 만드는 결과를 낳게 된다.

-- 이러한 불편을 방지하기 위해 SEQUENCE라는 객체를 사용하여, 자동으로 일련번호를 만드는 방법을 사용한다.
CREATE SEQUENCE seq_order
START WITH 1 INCREMENT BY 1;

-- 표준 SQL에서 간단한 계산을 할 때 
-- SELECT 3 + 4; 라고 코딩을 하면 3+4의 결과를 확인할 수 있다.
-- 그런데 오라클에서는 SELECT 명령문에  FROM [table] 절이 없으면 문법 오류가 난다.
-- 이러한 코드가 필요할 때 시스템에 이미 준비되어 있는 DUAL이라는 DUMMY 테이블을 사용해서 코딩을 한다.
SELECT 3 +4 FROM DUAL;

-- seq_order 객체의 NECTVAL 이라는 모듈(함수역할)을 호출하여
-- 변화되는 일련번호를 보여달라 라는 코드
-- 호출할 때마다 1씩 증가됨을 확인 할 수 있다.
SELECT seq_order.NEXTVAL FROM DUAL;

-- 이 seq order 의 NEXTVAL 모듈을 사용하여 INSERT를 수행할 때 일련번호를 자동으로 부여할 수 있다.

INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00001');
INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00002');
INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00003');
-- 주문번호,  고객번호, 상품코드
-- O00001     C0032      P00001
-- O00001     C0032      P00002
-- O00001     C0032      P00003
SELECT o_num, o_cnum, o_pcode FROM tbl_order;

-- 지금 tbl_order 테이블에 위와 같은 테이블이 있을 때
-- O00001     C0032      P00001 이러한 데이터를 추가한다면 아무런 제약 없이 값이 추가 되어 버린다.

INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00001');

SELECT o_num, o_cnum, o_pcode FROM tbl_order;

-- 주문번호, 고객번호, 상품코드 이 3개의 칼럼묶음에 값이 중복되면 INSERT가 되지 않도록 제약조건을 설정해야 한다.
-- UNIQUE : 칼럼의 값이 중복되어서 INSERT가 되는 것을 방지하는 제약조건
-- 주문테이블에 UNIQUE 제약조건을 추가하자
ALTER TABLE tbl_order ADD CONSTRAINT UQ_ORDER UNIQUE (o_num, o_cnum, o_pcode);

-- UNIQUE를 추가하는데 이미 UNIQUE조건에 위배되는 값이 있으면 제약조건이 추가되지 않는다.
-- ORA-02299: cannot validate (USER2.UQ_ORDER) - duplicate keys found :
--      PK, UNIQUE에 설정된 칼럼에 값을 추가하거나, 이미 중복된 값이 있는데,
--      PK, UNIQUE를 설정하려 할 때 발생을 한다.
-- UNIQUE 제약조건을 추가하기 위해 마지막에 추가된 데이터를 제거하려고 다음과 같은 SQL을 실행한다.
-- 이 SQL을 실행하면 삭제되어서는 안되는 중요한 주문정보가 1건이 같이 삭제된다.(현재 2건이 동일한 레코드가 있으므로)
-- 이 Table의 데이터는 무결성을 잃게 된다 => 삭제이상

DELETE FROM tbl_order
WHERE o_num = 'O00001' AND o_cnum = 'C0032' AND o_pcode = 'P00001';

-- 다행이 일련번호 칼럼이 만들어져 있기 때문에 PK를 기준으로 값을 삭제할 수 있다.
DELETE FROM tbl_order
WHERE o_seq = 7;

SELECT * FROM tbl_order;
ALTER TABLE tbl_order ADD CONSTRAINT UQ_ORDER UNIQUE (o_num, o_cnum, o_pcode);
DESC tbl_order;

-- 후보키 중에 단일칼럼으로 PK를 설정할 수 없는 상황이 발생을 하면
-- 복수의 칼럼으로 PK를 설정하는데
-- UPDATE, DELETE 수행 할 때  WHERE 칼럼1 = 값 AND 칼럼2 = 값 AND 칼럼3 = 값....과 같은 조건을 부여해야 한다.
-- 이것은 데이터 무결성을 유지하는데 매우 좋지 않은 환경이다.
-- 이럴 때 데이터와 상관없는 SEQ 칼럼을 만들어 PK로 설정하자.

SELECT * FROM tbl_order;

DELETE  FROM tbl_order
WHERE o_seq = 9;

INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00022','C0055','P00066');

INSERT INTO tbl_order(o_seq,o_date,o_num,o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL,'2020-07-22','O00022','C0055','P00067');

commit;