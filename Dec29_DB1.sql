-- *** SUBQUERY (��������) *** --
-- SELECT�� �ȿ��� �ٽ� SELECT���� ����ϴ� ���
-- �ϳ��� SQL�� �ȿ��� �ٸ� SQL���� ��ø�Ǵ� ���ǹ�
-- ���� �����Ͱ� �븳�϶� �����͸� ��� ���ļ� �����ϴ� ����(JOIN)����
-- �ʿ��� �����͸� ã�Ƽ� �������ִ� SUBQUERY�� ������ �� ����.

-- �� ����(MAIN QUERY)�� �μ� ����(SUBQUERY)�� ������
SELECT S_NAME, S_PRICE      -- ����
    FROM SNACK
    WHERE S_PRICE < (       -- �����ھ�! �񱳿�����
    SELECT AVG(S_PRICE)     -- ����
    FROM SNACK
    );

-- �ְ�
SELECT MAX(S_PRICE) FROM SNACK;

-- ���� ��� ���� �̸�, ������, ����
SELECT S_NAME, S_COMPANY, S_PRICE
    FROM SNACK
    WHERE S_PRICE = (
        SELECT MAX(S_PRICE)
        FROM SNACK
    );
    
-- ���� �� ���ڴ� ��� ������� ��ȸ
SELECT DISTINCT S_COMPANY   -- DISTINCT ���� ���� : ���� �Ѱ��� ���� �̱� ����
    FROM SNACK              -- �ߺ� �ȵǰ�!
    WHERE S_PRICE = (
        SELECT MIN(S_PRICE)
        FROM SNACK
    );

-- ��հ����� ��� ���ڴ� �� ����(��)����
SELECT COUNT(S_NAME) || '��' ����
    FROM SNACK
    WHERE S_PRICE > (
        SELECT AVG(S_PRICE)
        FROM SNACK
    );
    
-- ��������� ���� ���� ���� ������ ��ü ���� ��ȸ
SELECT * FROM SNACK
    WHERE S_DATE = (
        SELECT MAX(S_DATE)
        FROM SNACK
    );
    
-- ����ȸ�� ���̺� -> ȸ���̸�, �ּ�(������), �������� ���� ������
-- �����͵� �����ǵ� -> ���� ���̺��� ȸ�翡 ���缭 �ֱ�
CREATE TABLE COMPANY (
    C_NAME VARCHAR2(10 CHAR) PRIMARY KEY,
    C_ADDRESS VARCHAR2(10 CHAR) NOT NULL,
    C_EMPLOYEE NUMBER(3) NOT NULL
);

DROP TABLE COMPANY;

INSERT INTO COMPANY VALUES('����', '�ѱ�', 150);
INSERT INTO COMPANY VALUES('������', '�̱�', 200);
INSERT INTO COMPANY VALUES('���', '�߱�', 250);
INSERT INTO COMPANY VALUES('ũ���', 'ĳ����', 300);

SELECT * FROM COMPANY;

-- ���� ���� ���� ���� ȸ�翡�� ����� �����̸�, ���� ��ȸ
SELECT S_NAME, S_PRICE
    FROM SNACK
    WHERE S_COMPANY = (
        SELECT C_NAME
        FROM COMPANY
        WHERE C_EMPLOYEE = (
            SELECT MIN(C_EMPLOYEE)
            FROM COMPANY
        )
    );

-- ���� ��� ���ڸ� ����� ȸ��� ��� �ִ��� ��ȸ
SELECT C_NAME ȸ��
    FROM COMPANY
    WHERE C_NAME = (
        SELECT S_COMPANY
        FROM SNACK
        WHERE S_PRICE = (
            SELECT MAX(S_PRICE)
            FROM SNACK
        )
    );

-- �̱��� �ִ� ȸ�翡�� ����� ���� ��հ� ��ȸ
SELECT ROUND(AVG(S_PRICE), 2) || '��' ��հ�
    FROM SNACK
    WHERE S_COMPANY = (
        SELECT C_NAME
        FROM COMPANY
            WHERE C_ADDRESS = '�̱�'
    );

-- ��հ� �̻��� ���ڸ� ����� ȸ���̸�, ��ġ
SELECT C_NAME, C_ADDRESS
    FROM COMPANY
    WHERE C_NAME = (           -- =�� �Ⱦ��� IN�� ���� ����
        SELECT S_COMPANY        -- RETURN �Ǵ� ���� 2���̻� �����µ�
        FROM SNACK              -- =�� ���� 1���� ���� �̾Ƴ��Ƿ� ������ ��
        WHERE S_PRICE >= (      -- (RETURNS MORE THAN ONE ROW)
            SELECT AVG(S_PRICE) -- �׷��� �ټ��� ��� ���� �̾Ƴ��� ����
            FROM SNACK          -- IN�� ���� ����!
        )
    );