-- [�������� �� �ܷ�Ű!]

-- ������Ʈ���� �Խ��ǰ� �̸�  [�����ϴ�] �Խ��� ��� ���̺� ����
-- �Խ��� ���̺� : [�ۼ��� / �Խ��� �� ���� / �ۼ��ð�]
-- ��� ���̺� : [�ۼ��� / ��� ���� / �ۼ��ð�]

DROP TABLE BOARD;
DROP SEQUENCE BOARD_SEQ;
DROP TABLE BCOMMENT;
DROP SEQUENCE BCOMMNET_SEQ;

CREATE TABLE BOARD(
    B_NO NUMBER(4) PRIMARY KEY,
    B_NAME VARCHAR2(10 CHAR) NOT NULL,
    B_COMMENT VARCHAR2(100 CHAR) NOT NULL,
    B_TIME DATE NOT NULL
);

CREATE SEQUENCE BOARD_SEQ;
INSERT INTO BOARD VALUES (BOARD_SEQ.NEXTVAL, '����', '������ 1�� 2��', TO_DATE('2022-01-02 23:46:58', 'YYYY-DD-MM HH24:MI:SS'));
INSERT INTO BOARD VALUES (BOARD_SEQ.NEXTVAL, '����', '������ 1�� 3��', TO_DATE('2022-01-02 23:46:58', 'YYYY-DD-MM HH24:MI:SS'));
SELECT * FROM BOARD;


CREATE TABLE BCOMMENT(
    C_NO NUMBER(4) PRIMARY KEY,
    C_NAME VARCHAR2(10 CHAR) NOT NULL,
    C_COMMNET VARCHAR2(100 CHAR) NOT NULL,
    C_TIME DATE NOT NULL,
    C_NUM NUMBER(4),
    CONSTRAINT FK_C_NUM FOREIGN KEY(C_NUM)      -- FK_�ڿ� ���� ���� �ƹ����� ���൵ ����
        REFERENCES BOARD(b_NO)                  -- FK_ �� �յڷ� ���°� ��ȭ�����ž�!
        ON DELETE CASCADE
);

CREATE SEQUENCE BCOMMENT_SEQ;
INSERT INTO BCOMMENT VALUES (BOARD_SEQ.NEXTVAL, '����', '�� �������� �ϴµ�', SYSDATE , 1);
INSERT INTO BCOMMENT VALUES (BOARD_SEQ.NEXTVAL, 'ȣ��', '������ 1�� 2���ε�', SYSDATE, 2);
INSERT INTO BCOMMENT VALUES (BOARD_SEQ.NEXTVAL, '����', '���ش� ������ ������', SYSDATE, 1);
INSERT INTO BCOMMENT VALUES (BOARD_SEQ.NEXTVAL, '����', '����ȭ����', SYSDATE, 2);

SELECT * FROM BCOMMENT;

-- �Խñ� 1���� ������ �� ��۵� ���� �������°�?
DELETE FROM BOARD WHERE B_NO = 1;
--------------------------------------------------------------------------------