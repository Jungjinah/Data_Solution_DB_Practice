-- [�ɼ�]
-- ��������(CONSTRAINT)�̶�� �θ�
-- ������ ���Ἲ�� �����ϱ� ���ؼ� ���
--          ������ ���Ἲ : �����ͺ��̽��� ����� �������� �ϰ���, ��Ȯ���� ��Ű�� ��
--  1. ������ ���Ἲ ��������
--      ������ ���� (DOMAIN CONSTRAINT)�̶�� �ϸ�,
--      �����̼� ���� Ʃ�õ��� �����ο� ������ ���� �������Ѵٴ� ����
--      �ڷ���(TYPE), ��(NULL / NOT NULL), �⺻��(DEFAULT), üũ(CHECK)
--  2. ��ü ���Ἲ ��������
--      �⺻Ű ����(PRIMARY KEY CONSTRAINT)�̶�� ��
--      �����̼��� �⺻Ű�� �����ϰ�, NULL���� �������� �ȵǸ�,
--      �����̼� ���� ���� �ϳ��� ���� �����ؾ� �Ѵٴ� ����
--  3. ���� ���Ἲ ��������
--      �ܷ�Ű ����(FOREIGN KEY CONSTRAINT)�̶�� ��
--      ���� �޴� �����̼��� �ܷ�Ű�� �����ϴ� �����̼��� �⺻Ű�� �������� �����ؾ� �ϸ�,
--      ���� �޴� �����̼��� ���� ����� ��, �����ϴ� �����̼��� ������ �޴´�

-- => NOT NULL / PRIMARY KEY / FOREIGN KEY

--  1. NOT NULL : (NULL�� ���� ����ִ� / 0�� �ƴϰ� ���⵵ �ƴ� ���� ���� ���� ����)
--                  NULL �� ������� �ʴ´� -> �ʼ������� ���� �־����! (���� ���� ���)
-- [2���� ����]
CREATE TABLE EXAMPLE(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR) NOT NULL
);

-- CONTRAINT Ű���带 ����ؼ� �������Ǹ��� ���� �ο���
CREATE TABLE EXAMPLE2(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR)
    CONSTRAINT COL2_NOTNULL NOT NULL
);
-- CONSTRAINT Ű���� �Ἥ ����� ������ �⺻Ű �� �� ����!

--  2. UNIQUE : �ش� �÷��� ���� ���� ���̺� ��ü���� �����ؾ� �Ѵ�!�� �ǹ� (������ü�� �˾Ƶ�,,)
--              NOT NULL�� �Բ� ����� ����������, UNIQUE�� �� ������ ����
CREATE TABLE EXAMPLE3(
    COL1 VARCHAR2(10 CHAR) UNIQUE,
    COL2 VARCHAR2(10 CHAR) UNIQUE NOT NULL,
    COL3 VARCHAR2(10 CHAR),
    CONSTRAINT COL3_UNIQUE UNIQUE(COL3)
);

--  3. PRIMARY KEY(�⺻ Ű) : NULL�� ������� �ʰ�, �ߺ��� �����͸� ������� ����
--                          ( NOT NULL       +       UNIQUE          = PRIMARY KEY)    
--  �������� Ư�� ������ �˻��ϰų�, ���� ���� �۾��� �� �� �⺻Ű�� �����Ѵ�.
--  EX) ID, �ֹε�Ϲ�ȣ, ȸ����ȣ, �� ��ȣ, ...
--  �������̸� �� ���̺� �� PK�� �ϳ�������..!
CREATE TABLE EXAMPLE4(
    COL1 VARCHAR2(10 CHAR) PRIMARY KEY,
    COL2 VARCHAR2(10 CHAR),
    COL3 VARCHAR2(10 CHAR)
);

/* PK�� 2�� �̻� ����ϴ� ��� CONSTRAINT Ű���� ��� */
CREATE TABLE EXAMPLE5(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR),
    COL3 VARCHAR2(10 CHAR),
    CONSTRAINT PK_EXAMPLE5 PRIMARY KEY (COL1, COL2)
);

--  4. foreign key(�ܷ� Ű) : �ٸ� ���̺��� Ư�� �÷��� ��ȸ�ؼ�
--                           ������ �����Ͱ� �ִ� ��쿡�� �Է�, ����, ... ����!
--  �����ϴ�(�ΰ� �����) ���̺��� PK�� UNIQUE�� ������ �÷����� FK�� ������ �� �ִ�
--  �ܷ�Ű ������ ���ؼ��� �����޴� �÷��� ���� �����Ǿ�� �ϰ�,
--      �ܷ�Ű�� ���� ���̺��� ���Ŀ� �����Ǿ�� ��!

-- �ܷ�Ű ���̺� ����
CREATE TABLE ���̺��(
        �÷��� �ڷ���,    -- �Ʒ� FK���� �ʰ� ���� ������� ���°ſ���
        CONSTRAINT FK�� FOREIGN KEY(�÷���)     -- '�÷���'�� ������ ��ȣ �ʼ�
            REFERENCES ������̺��(������̺��� �⺻Ű(OR ����Ű) �÷���)
            [ON DELETE SET NULL || ON DELETE CASCADE] -- (���� �ɼ�)
            -- �����ϴ� ���̺��� �� �κ��� ������ ��,
            -- �� ���̺��� ����Ǿ� �ִ� �࿡ ���ؼ� NULL ���� ������
            -- �ƴϸ� ���� �������� ���� �ɼ�
);

-- �ܷ�Ű ����1 (EXAMPLE6 �� EXAMPLE7 ���̺� ����)
CREATE TABLE EXAMPLE6(
        COL1 VARCHAR2(10 CHAR) PRIMARY KEY
);
INSERT INTO EXAMPLE6 VALUES('10');
INSERT INTO EXAMPLE6 VALUES('20');
INSERT INTO EXAMPLE6 VALUES('30');
SELECT * FROM EXAMPLE6;

CREATE TABLE EXAMPLE7(
        COL1 VARCHAR2(10 CHAR),
        CONSTRAINT FK_COL1 FOREIGN KEY(COL1)
            REFERENCES EXAMPLE6(COL1)
            ON DELETE CASCADE
);
DROP TABLE EXAMPLE7 CASCADE CONSTRAINT PURGE;
INSERT INTO EXAMPLE7 VALUES('10');
INSERT INTO EXAMPLE7 VALUES('20');
INSERT INTO EXAMPLE7 VALUES('30');
INSERT INTO EXAMPLE7 VALUES('40');  -- EXAMPLE6���� 40�̶�� ���� �����Ƿ� �ܷ�Ű�� ������ �ʴ� ��Ȳ!
SELECT * FROM EXAMPLE7;
-- EXAMPLE6�� '10'�� ���� ����� ��� �ɱ�?
DELETE FROM EXAMPLE6 WHERE COL1 = '10'; -- EXAMPLE7�� '10'�� ���� �ܷ�Ű �ȸ����� ��Ȳ ��!

-- �ܷ�Ű ����2
-- �а� ���̺�� �̰��� �����ϴ� �л� ���̺��� ������.
-- �а����̺� : �а��ڵ�(4�ڸ� ����), �а���
-- �л����̺� : �л���ȣ(3�ڸ� ����), �л��̸�, �а��ڵ�
-- �а����̺��� �а� �ڵ带 ����� �л������� ��������
CREATE TABLE MAJOR(
    M_CODE NUMBER(4) PRIMARY KEY,
    M_NAME VARCHAR2(10 CHAR) NOT NULL           -- ���� �����ϸ� �� �־��� ��� ���� �־� 'NOT NULL'�������
);                                              -- ���, NOT NULL�� ������ ������ ���� �־������

INSERT INTO MAJOR VALUES (1001, '����濵���а�');
INSERT INTO MAJOR VALUES (1002, '�����а�');
INSERT INTO MAJOR VALUES (1003, '���а�');
SELECT * FROM MAJOR;

CREATE TABLE STUDENT(
    S_NUM NUMBER(3) PRIMARY KEY,
    S_NAME VARCHAR2(10 CHAR) NOT NULL,
    S_CODE NUMBER(4) NOT NULL,
    CONSTRAINT FK_CODE FOREIGN KEY (S_CODE)     -- �ܷ�Ű�� �̿��Ͽ� �����غ��� ���� CONSTRAINT ���
        REFERENCES MAJOR(M_CODE)
        ON DELETE CASCADE                       -- FOREIGNŰ ���� ���� ����ڴ�!
);

INSERT INTO STUDENT VALUES (111, '����', 1001);
INSERT INTO STUDENT VALUES (222, '����', 1002);
INSERT INTO STUDENT VALUES (333, '����', 1003);
INSERT INTO STUDENT VALUES (444, '����', 1004); 
INSERT INTO STUDENT VALUES (555, '', 1004);     -- ��� NOT NULL�� �ȳ����� ���ư�.
SELECT * FROM STUDENT;
DELETE FROM MAJOR WHERE M_CODE = '1001';    -- �̰� �����ϸ� MAJOR�� STUDENT 2�� �� 1001 ������!
-- �̰� �����غ��� ���� : MAJOR�� �� ���� ����� ������ STUDENT ���� ���� �������� Ȯ�� �ϱ� ����
                           
--  5. CHECK : �������� '���� ������ ������ ����'�Ͽ� ���ǿ� �ش��ϴ� �����͸� ����Ѵ�.
CREATE TABLE EXAMPLE8(
    COL1 NUMBER(10)
    CONSTRAINT EX8_CHECK CHECK (COL1 BETWEEN 1 AND 9)
);      -- ���� 1���� 9������ ���ڸ� �� �� �ְ� CHECK ��!
        -- CHECK���ǿ� ���� �̸� : EX8_
INSERT INTO EXAMPLE8 VALUES (5);    -- ���� O
INSERT INTO EXAMPLE8 VALUES (10);   -- ���� X
SELECT * FROM EXAMPLE8;

--  6. DEFAULT : �ƹ��� �����͸� �Է����� �ʾ��� ���, ������ �����Ͱ� �ڵ����� �Էµ�
CREATE TABLE EXAMPLE9(
    COL1 NUMBER(3) DEFAULT 999
);
INSERT INTO EXAMPLE9 VALUES (DEFAULT);  -- 999 / DEFAULT�� �Բ� ����س����� �־��� ���� ����!
INSERT INTO EXAMPLE9 VALUES (NULL);     -- 0
INSERT INTO EXAMPLE9 VALUES (0);        -- NULL
INSERT INTO EXAMPLE9 VALUES (11);       -- 11

SELECT * FROM EXAMPLE9;

-- Ŀ�� �޴��� ���� ���̺�
-- Ŀ���� �̸�, ����, Į�θ�, �ǸŰ����� ��¥ ���� �� �� �ְ�
-- ���̺� PK�� �ϳ� �� �־�� �ϰ�, ����ִ� ���� ��������..!(��� ���� ���� �� : NULL)
CREATE TABLE COFFEE(
    C_NAME VARCHAR2(10 CHAR) PRIMARY KEY,
    C_PRICE NUMBER(5) NOT NULL,
    C_KCAL NUMBER(5) NOT NULL,
    C_START DATE NOT NULL
);
INSERT INTO COFFEE VALUES ('�����', 5000, 350, TO_DATE('2021-12-31','YYYY-MM-DD'));
--------------------------------------------------------------------------------
-- DDL - ALTER, DROP(���� ����)

-- ������ Ÿ�� ���� / �÷��� ũ��(�뷮) ����
ALTER TABLE [���̺��] MODIFY [�÷���] [������Ÿ��(�뷮)];
ALTER TABLE COFFEE MODIFY C_NAME NUMBER(3); -- ���� �ִ� ���¿��� ������Ÿ�� �����ϸ� ����!

-- ���� �ִ� ���¿��� �뷮�� ���� �����ϸ� ����!
ALTER TABLE COFFEE MODIFY C_NAME VARCHAR(2 CHAR);

-- �÷��� ����
ALTER TABLE [���̺��] RENAME COLUMN [���� �÷���] TO [���ο� �÷���];
ALTER TABLE COFFEE RENAME COLUMN C_NAME TO C_NAME2;

-- �÷� �߰�
ALTER TABLE [���̺��] AND [�÷���] [������Ÿ��(�뷮)] [��������(��������)];
ALTER TABLE COFFEE AND C_TASTE VARCHAR2(10 CHAR) NOT NULL;

-- �÷� ����
ALTER TABLE [���̺��] DROP COLUMN [�÷���];
ALTER TABLE COFFEE DROP COLUMN C_TASTE;

-- ���̺�� ����
ALTER TABLE [���̺��] RENAME TO [������ ���̺��];
ALTER TABLE COFFEE AND RENAME TO COFFEE1;
--------------------------------------------------------------------------------
-- DROP

-- ���̺��� ����! (�����뿡 �ֱ�)
DROP TABLE [���̺��] CASCADE CONSTRAINT;
DROP TABLE COFFEE CASCADE CONSTRAINT;
SELECT * FROM COFFEE;   -- �����ƴ��� Ȯ��!

-- �����뿡 �ִ� ���̺� ����
FLASHBACK TABLE [���̺��] TO BEFORE DROP;
FLASHBACK TABLE COFFEE TO BEFORE DROP;
SELECT * FROM COFFEE;

-- ������ ����
PURGE RECYCLEBIN;

-- ������ֱ� + ���� => ���̺��� ���� ����
DROP TABLE [���̺��] CASCADE CONSTRAINT PURGE;
DROP TABLE COFFEE CASCADE CONSTRAINT PURGE;

/* DDL ��! */
--------------------------------------------------------------------------------