-- ����� ������ ȭ��.

-- ��α׸� ���� tablespace ����
CREATE TABLESPACE blogTS
DATAFILE 'C:/bizwork/oracle_dbms/blogTS.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K; 

-- user1 ����� ����
CREATE USER user1 IDENTIFIED BY user1
DEFAULT TABLESPACE blogTS;

-- user1�� ���� �ο�
GRANT DBA TO user1;