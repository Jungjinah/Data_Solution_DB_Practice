-- ���� ���̺�
-- �����̸�, ����ȸ��, ���ڰ���

CREATE TABLE SNACK (
    S_NO NUMBER(4) PRIMARY KEY,
    S_NAME VARCHAR2(10 CHAR) NOT NULL,
    S_COMPANY VARCHAR2(10 CHAR) NOT NULL,
    S_PRICE NUMBER(5) NOT NULL,
    
    S_DATE DATE NOT NULL        -- ��¥�� �� �־��ֱ� (83���� ����)
);

DROP TABLE SNACK;
--------------------------------------------------------------------------------
-- DML (DATA MANIPULATION LANGUAGE) : ������ ���۾�
-- �����͸� �˻�, ����, ����, �����ϴµ� ���Ǵ� ����
-- SELECT, INSERT, UPDATE, DELETE, ...
-- �ٿ��� CRUD!
-- C (INSERT)
INSERT INTO [���̺��](�÷���, �÷���, ...) VALUES(��, ��, ...);

INSERT INTO SNACK(S_NO, S_NAME, S_COMPANY, S_PRICE) VALUES (1, '��������', '������', 500);
-- => �÷����� ������ִ°� ��Ģ!

-- �÷������� �ٲ㼭 �ֱ�? -> ����
INSERT INTO SNACK(S_NO, S_NAME, S_PRICE, S_COMPANY) VALUES (1, '���޴���', 500, '�Ե�');
-- => �÷����� ���� �����ϳ�, ����� �÷��� ���� ���� �־����

-- �÷��� ��� ���ϰ� ������� ���� �ֱ�? -> ����
INSERT INTO SNACK VALUES (3, '����������', '�Ե�', 3500);
-- => ���̺� ������� �־��ֱ⸸ �ϸ� �÷��� �Ƚᵵ ��!

-- 4~5�� �־�ô�!
INSERT INTO SNACK VALUES(1, '����', '������', 500);
INSERT INTO SNACK VALUES(2, 'Ȩ����', '����', 2500);
INSERT INTO SNACK VALUES(3, '�ζ���', '����', 1500);
INSERT INTO SNACK VALUES(4, '�������ݷ�', '�Ե�', 800);
SELECT * FROM SNACK;
-- => �̰� ����µ� ��ȣ �����ϴ°� ������ ����? SO, �Ʒ��� ���� GO

-- FACTORY PATTERN!
-- MY SQL : AUTOINCREMENT �ɼ�
-- ORACLE : SEQUENCE
--      ��ȣ�� ������ �°� �ڵ����� �������ִµ�..
--      ���̺���� �����ϰ�, INSERT�� �����ص� SEQUENCE ���� �ö�

-- SEQUENCE ����
CREATE SEQUENCE ��������; -- �����ϰ� �����
CREATE SEQUENCE SNACK_SEQ;
-- ��ȭó��, ���̺�� �ڿ� _SEQ�� �ٿ��ִ� ��ȭ�� ����

-- ��ü���� ������ (�̰� �׳� �ʱ�,, �����ϰ� �� ���� ����)
CREATE SEQUENCE ��������
    INCREMENT BY 1 -- ������(1�� ����)
    START WITH 1   -- ���۰�
    MINVALUE       -- �ּҰ�
    MAXVALUE       -- �ִ밪
    NOCYCLE/CYCLE  -- �ִ밪�� �����ϸ� ���۰����� �ٽ� �ݺ�����/����
    NOCACHE/CACHE  -- �������� �̸� �������� �޸𸮿��� ������ ����/����
    NOORDER/ORDER  -- N�� �ݺ�����/����
    ;
-- SEQUENCE ����
DROP SEQUENCE [��������];
DROP SEQUENCE SNACK_SEQ;

-- SEQUENCE ���
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '��������', '�Ե�', 5000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '��������', '������', 5000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '������', '�Ե�', 800);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '��Ϲ���Ĩ', '����', 3000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '��Ϲ���Ĩ(�̰ǽ���)', '����', 5000000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '���޴���', 'ũ���', 500);
SELECT * FROM SNACK;
-- 5�� �����ؼ� �� �������·� ������� ����! (S_NO�κ���)

-- => ������ ������ ���� ���� INSERT ��ǰ�� ������ ��ȣ���� �浹�ϹǷ� �ȵ��� ���·� �������� ��������!
-- => �ٵ� ���� INSERT �̹� �������� ���̺����, ���������� ��� �����ؾ���!

-- �ð� / ��¥
--      SYSDATE : ���ó�¥ / ����ð�
SELECT SYSDATE FROM DUAL;

INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '���޴��� �����', 'ũ���', 500, SYSDATE);

-- Ư���ð� / ��¥
--      �����Լ� - TO_DATE('��', '����')
--          ����(�빮��) - YYYY, MM, DD, AM/PM, HH, HH24(��õ), MI(��), SS(��)

insert into snack values(snack_seq.nextval, '���޴��� ������', 'ũ���', 500, to_date('2022-02-15 17', 'YYYY-MM-DD HH24')
);
-- ���� ������ ��! �־��ּ���! (�����ʹ� ������ �������� ����!)
insert into snack values(snack_seq.nextval, '����', '������', 1000, to_date('2022-02-15 17', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, 'Ȩ����', '����', 1500, to_date('2022-03-15 13', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�ζ���', '����', 1000, to_date('2022-04-15 14', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�ֹֽ�', '����', 400, to_date('2022-02-16 19', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '��Ĩ', 'ũ���', 1500, to_date('2022-02-17 21', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '���ڼ���', '������', 1000, to_date('2022-02-18 05', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, 'ĭ��', '�Ե�', 1000, to_date('2023-02-15 22', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '��¡����', '���', 1200, to_date('2022-06-15 11', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '����', '������', 4500, to_date('2022-02-13 16', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '���ĸ�', '���', 1300, to_date('2022-09-15 10', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�ٳ���ű', '���', 1300, to_date('2022-12-18 07', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '������', '����', 3500, to_date('2022-07-14 02', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '������', '����', 2000, to_date('2022-05-10 01', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '��Ϲ���Ĩ', '����', 1500, to_date('2024-03-11 18', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�����', '���', 1200, to_date('2022-11-16 05', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '��Ű', '����', 1500, to_date('2022-12-05 06', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�ڰ���', '����', 1500, to_date('2023-10-04 23', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '��īĨ', '������', 1500, to_date('2022-08-01 12', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '������ ������', 'ũ���', 800, to_date('2025-06-27 10', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '�����', '����', 1000, to_date('2024-03-21 23', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, 'ī��Ÿ��', '������', 2500, to_date('2024-03-21 17', 'YYYY-MM-DD HH24')
);
SELECT * FROM SNACK;
--------------------------------------------------------------------------------
-- ���� �����͸� ��ȸ�غ���!
-- R (READ)
SELECT [DISTINCT] [�÷���], [�÷��� AS ��Ī || �÷��� ��Ī], [������ ���], [����Լ�], ...
    FORM [���̺��]
    WHERE [���ǽ�]
    GROUP BY [�׷���]
    HAVING [�Լ� ������ ����]
    ORDER BY [���Ĵ��] [ASC / DESC(��������/��������)] -- �⺻���� ��������
    
-- �������̺� ��ü ��ȸ
SELECT * FROM SNACK;
SELECT S_COMPANY FROM SNACK;          -- ���� �������� ȸ�簪�� �����µ�,, �ߺ������ϰ�;�!
SELECT DISTINCT S_COMPANY FROM SNACK; -- �ߺ� ���ŵǰ� �ϳ����� ������ ��!

-- ���� ����� �����ѵ�..
-- �÷��� ��ü�� S_PRICE/100
--      -> �÷��� ��Ī�� �ο��ؼ� � ������ ���� ���̰� ���
SELECT S_PRICE / 100 FROM SNACK;
-- ��Ī �ο� ��� 2����
SELECT S_PRICE / 100 AS "����" FROM SNACK;   -- AS�� ��Ī �ο� 1  
SELECT S_PRICE / 100 PRICE FROM SNACK;      -- ����� ��Ī �ο� 2
--------------------------------------------------------------------------------
-- ������ (��� ������)
-- DUAL ���̺�     (SYSDATE�� ���� DUAL���̺� ��!)
--  1. ����Ŭ ��ü���� �����ϴ� �������̺�
--  2. �����ϰ� �Լ��� �̿��ؼ� ��� ������� Ȯ���� �� ���

-- ��κ��� ������ ���� �켱�ż� 13�̶�� ������� �����µ�
-- ����Ŭ������ �ݴ�� ���ڰ� �켱�� ��!
SELECT 1 + '3' FROM DUAL;   -- 4����

-- ���ڸ� �������� -> ���� + ���ڰ� �ƴѹ��� => ����!
SELECT 1 + 'A' FROM DUAL;       -- ��������ǥ�� ���ڸ� ��Ÿ���� �� �ȿ� ���ڰ� ���� ������� ����

-- ���ڸ� �����ֱ� ���� ������(||)
SELECT '3' || 10 FROM DUAL; --  310
--------------------------------------------------------------------------------
-- WHERE (���ǽ�)
-- ��ü ������ �� ������ ���ǿ� �´� �����͸� ã���ִ� ����
-- ���ǽĿ� ����� ������ (�񱳿�����)
-- = , != , ^=, <>, > , <, >=, <=, ...
-- 2��°�� 4��°�� ǥ��ȭ �ϱ� ���ؼ� ����
-- 3������ ����ȭ�� �α� ���ؼ� ����
-- => �ٵ� �츮�� 2��° ���ϱ� 2��°�� �˾Ƶֵ� ��!

-- ����1) ������ 3000���� ������ ��� ������ ��ȸ
SELECT * FROM SNACK
    WHERE S_PRICE >= 3000;
    
-- ����2) ��� �����̸�(����)���� ��ȸ (EX : ��Ĩ(2000)) + ���̺� ����� �̸�(����) ������
-- ��Ʈ) �̸�(����) �����ϸ� �ȳ���! -> "�̸�(����)" �����ؾ���
SELECT S_NAME || '(' || S_PRICE || ')��' AS "�̸�(����)" FROM SNACK;

-- ����3) 2000�� ������ ���� �߿��� �ּҰ����� ������
SELECT MIN(S_PRICE) �ּҰ���
    FROM SNACK
    WHERE S_PRICE <= 2000;

-- ����4) ��� ������ ��հ��� ������
SELECT ROUND(AVG(S_PRICE),2) ��հ� FROM SNACK;
    
-- ����5) ������ �̸�, ������ 30% ���ε� �ݾ�
SELECT S_NAME �̸�, S_PRICE * 0.7 ���ΰ� FROM SNACK;     -- ��Ī'��' �ο��Ҷ� ���� �ٷ� �ڿ� ��Ī �ο�!

-- ����6) 3000�� ������ ������ �̸�, ȸ���̸� ��ȸ
SELECT S_NAME �̸�, S_COMPANY ȸ��
    FROM SNACK
    WHERE S_PRICE <= 3000;




