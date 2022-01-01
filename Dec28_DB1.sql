-- [옵션]
-- 제약조건(CONSTRAINT)이라고 부름
-- 데이터 무결성을 보장하기 위해서 사용
--          데이터 무결성 : 데이터베이스에 저장된 데이터의 일관성, 정확성을 지키는 것
--  1. 도메인 무결성 제약조건
--      도메인 제약 (DOMAIN CONSTRAINT)이라고도 하며,
--      릴레이션 내의 튜플들이 도메인에 지정된 값만 가져야한다는 조건
--      자료형(TYPE), 널(NULL / NOT NULL), 기본값(DEFAULT), 체크(CHECK)
--  2. 개체 무결성 제약조건
--      기본키 제약(PRIMARY KEY CONSTRAINT)이라고 함
--      릴레이션은 기본키를 지정하고, NULL값을 가져서는 안되며,
--      릴레이션 내에 오직 하나의 값만 존재해야 한다는 조건
--  3. 참조 무결성 제약조건
--      외래키 제약(FOREIGN KEY CONSTRAINT)이라고 함
--      참조 받는 릴레이션의 외래키는 참조하는 릴레이션의 기본키와 도메인이 동일해야 하며,
--      참조 받는 릴레이션의 값이 변경될 때, 참조하는 릴레이션의 제약을 받는다

-- => NOT NULL / PRIMARY KEY / FOREIGN KEY

--  1. NOT NULL : (NULL은 값이 비어있다 / 0도 아니고 띄어쓰기도 아닌 값을 넣지 않은 상태)
--                  NULL 을 허용하지 않는다 -> 필수적으로 값을 넣어줘라! (가장 많이 사용)
-- [2가지 예시]
CREATE TABLE EXAMPLE(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR) NOT NULL
);

-- CONTRAINT 키워드를 사용해서 제약조건명을 따로 부여함
CREATE TABLE EXAMPLE2(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR)
    CONSTRAINT COL2_NOTNULL NOT NULL
);
-- CONSTRAINT 키워드 써서 사용한 구조는 기본키 할 때 설명!

--  2. UNIQUE : 해당 컬럼에 들어가는 값이 테이블 전체에서 유일해야 한다!는 의미 (존재자체만 알아둬,,)
--              NOT NULL과 함께 사용이 가능하지만, UNIQUE는 잘 사용되지 않음
CREATE TABLE EXAMPLE3(
    COL1 VARCHAR2(10 CHAR) UNIQUE,
    COL2 VARCHAR2(10 CHAR) UNIQUE NOT NULL,
    COL3 VARCHAR2(10 CHAR),
    CONSTRAINT COL3_UNIQUE UNIQUE(COL3)
);

--  3. PRIMARY KEY(기본 키) : NULL을 허용하지 않고, 중복된 데이터를 허용하지 않음
--                          ( NOT NULL       +       UNIQUE          = PRIMARY KEY)    
--  데이터의 특정 조건을 검색하거나, 수정 등의 작업을 할 때 기본키로 구분한다.
--  EX) ID, 주민등록번호, 회원번호, 글 번호, ...
--  가급적이면 한 테이블 당 PK는 하나였으면..!
CREATE TABLE EXAMPLE4(
    COL1 VARCHAR2(10 CHAR) PRIMARY KEY,
    COL2 VARCHAR2(10 CHAR),
    COL3 VARCHAR2(10 CHAR)
);

/* PK를 2개 이상 줘야하는 경우 CONSTRAINT 키워드 사용 */
CREATE TABLE EXAMPLE5(
    COL1 VARCHAR2(10 CHAR),
    COL2 VARCHAR2(10 CHAR),
    COL3 VARCHAR2(10 CHAR),
    CONSTRAINT PK_EXAMPLE5 PRIMARY KEY (COL1, COL2)
);

--  4. foreign key(외래 키) : 다른 테이블의 특정 컬럼을 조회해서
--                           동일한 데이터가 있는 경우에만 입력, 수정, ... 가능!
--  참조하는(두개 연결된) 테이블은 PK나 UNIQUE로 지정된 컬럼만을 FK로 지정할 수 있다
--  외래키 설정을 위해서는 참조받는 컬럼이 먼저 생성되어야 하고,
--      외래키를 심을 테이블이 이후에 생성되어야 함!

-- 외래키 테이블 구조
CREATE TABLE 테이블명(
        컬럼명 자료형,    -- 아래 FK명은 너가 짓고 싶은대로 짓는거에요
        CONSTRAINT FK명 FOREIGN KEY(컬럼명)     -- '컬럼명'들 넣을때 괄호 필수
            REFERENCES 대상테이블명(대상테이블의 기본키(OR 고유키) 컬럼명)
            [ON DELETE SET NULL || ON DELETE CASCADE] -- (선택 옵션)
            -- 참조하는 테이블에서 행 부분을 지웠을 때,
            -- 이 테이블에서 연결되어 있는 행에 대해서 NULL 값을 먹일지
            -- 아니면 같이 지울지에 대한 옵션
);

-- 외래키 예제1 (EXAMPLE6 와 EXAMPLE7 테이블 만듬)
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
INSERT INTO EXAMPLE7 VALUES('40');  -- EXAMPLE6에는 40이라는 값이 없으므로 외래키가 먹히지 않는 상황!
SELECT * FROM EXAMPLE7;
-- EXAMPLE6에 '10'인 값을 지우면 어떻게 될까?
DELETE FROM EXAMPLE6 WHERE COL1 = '10'; -- EXAMPLE7의 '10'의 값은 외래키 안먹히는 상황 됨!

-- 외래키 예제2
-- 학과 테이블과 이것을 참조하는 학생 테이블을 만들어보자.
-- 학과테이블 : 학과코드(4자리 숫자), 학과명
-- 학생테이블 : 학생번호(3자리 숫자), 학생이름, 학과코드
-- 학과테이블의 학과 코드를 지우면 학생정보도 지워지게
CREATE TABLE MAJOR(
    M_CODE NUMBER(4) PRIMARY KEY,
    M_NAME VARCHAR2(10 CHAR) NOT NULL           -- 값이 웬만하면 다 넣어줘 라는 말이 있어 'NOT NULL'집어넣음
);                                              -- 대신, NOT NULL을 넣으면 무조건 값을 넣어줘야함

INSERT INTO MAJOR VALUES (1001, '산업경영공학과');
INSERT INTO MAJOR VALUES (1002, '기계공학과');
INSERT INTO MAJOR VALUES (1003, '법학과');
SELECT * FROM MAJOR;

CREATE TABLE STUDENT(
    S_NUM NUMBER(3) PRIMARY KEY,
    S_NAME VARCHAR2(10 CHAR) NOT NULL,
    S_CODE NUMBER(4) NOT NULL,
    CONSTRAINT FK_CODE FOREIGN KEY (S_CODE)     -- 외래키를 이용하여 참조해보기 위해 CONSTRAINT 사용
        REFERENCES MAJOR(M_CODE)
        ON DELETE CASCADE                       -- FOREIGN키 값도 같이 지우겠다!
);

INSERT INTO STUDENT VALUES (111, '진아', 1001);
INSERT INTO STUDENT VALUES (222, '진아', 1002);
INSERT INTO STUDENT VALUES (333, '진아', 1003);
INSERT INTO STUDENT VALUES (444, '진아', 1004); 
INSERT INTO STUDENT VALUES (555, '', 1004);     -- 얘는 NOT NULL을 안넣으면 돌아감.
SELECT * FROM STUDENT;
DELETE FROM MAJOR WHERE M_CODE = '1001';    -- 이거 실행하면 MAJOR랑 STUDENT 2개 다 1001 없어짐!
-- 이거 실행해보는 이유 : MAJOR에 한 행을 지우면 참조된 STUDENT 같은 행이 지워지나 확인 하기 위해
                           
--  5. CHECK : 데이터의 '값의 범위나 조건을 설정'하여 조건에 해당하는 데이터만 허용한다.
CREATE TABLE EXAMPLE8(
    COL1 NUMBER(10)
    CONSTRAINT EX8_CHECK CHECK (COL1 BETWEEN 1 AND 9)
);      -- 값이 1부터 9까지의 숫자만 들어갈 수 있게 CHECK 씀!
        -- CHECK조건에 대한 이름 : EX8_
INSERT INTO EXAMPLE8 VALUES (5);    -- 실행 O
INSERT INTO EXAMPLE8 VALUES (10);   -- 실행 X
SELECT * FROM EXAMPLE8;

--  6. DEFAULT : 아무런 데이터를 입력하지 않았을 경우, 지정한 데이터가 자동으로 입력됨
CREATE TABLE EXAMPLE9(
    COL1 NUMBER(3) DEFAULT 999
);
INSERT INTO EXAMPLE9 VALUES (DEFAULT);  -- 999 / DEFAULT와 함께 명시해놓으면 주어진 숫자 나옴!
INSERT INTO EXAMPLE9 VALUES (NULL);     -- 0
INSERT INTO EXAMPLE9 VALUES (0);        -- NULL
INSERT INTO EXAMPLE9 VALUES (11);       -- 11

SELECT * FROM EXAMPLE9;

-- 커피 메뉴에 대한 테이블
-- 커피의 이름, 가격, 칼로리, 판매개시한 날짜 값이 들어갈 수 있게
-- 테이블에 PK가 하나 꼭 있어야 하고, 비어있는 값이 없었으면..!(비어 있지 않은 값 : NULL)
CREATE TABLE COFFEE(
    C_NAME VARCHAR2(10 CHAR) PRIMARY KEY,
    C_PRICE NUMBER(5) NOT NULL,
    C_KCAL NUMBER(5) NOT NULL,
    C_START DATE NOT NULL
);
INSERT INTO COFFEE VALUES ('딸기라떼', 5000, 350, TO_DATE('2021-12-31','YYYY-MM-DD'));
--------------------------------------------------------------------------------
-- DDL - ALTER, DROP(비교적 쉬움)

-- 데이터 타입 변경 / 컬럼의 크기(용량) 변경
ALTER TABLE [테이블명] MODIFY [컬럼명] [데이터타입(용량)];
ALTER TABLE COFFEE MODIFY C_NAME NUMBER(3); -- 값이 있는 상태에서 데이터타입 변경하면 에러!

-- 값이 있는 상태에서 용량을 적게 변경하면 에러!
ALTER TABLE COFFEE MODIFY C_NAME VARCHAR(2 CHAR);

-- 컬럼명 변경
ALTER TABLE [테이블명] RENAME COLUMN [이전 컬럼명] TO [새로운 컬럼명];
ALTER TABLE COFFEE RENAME COLUMN C_NAME TO C_NAME2;

-- 컬럼 추가
ALTER TABLE [테이블명] AND [컬럼명] [데이터타입(용량)] [제약조건(생략가능)];
ALTER TABLE COFFEE AND C_TASTE VARCHAR2(10 CHAR) NOT NULL;

-- 컬럼 삭제
ALTER TABLE [테이블명] DROP COLUMN [컬럼명];
ALTER TABLE COFFEE DROP COLUMN C_TASTE;

-- 테이블명 변경
ALTER TABLE [테이블명] RENAME TO [변경할 테이블명];
ALTER TABLE COFFEE AND RENAME TO COFFEE1;
--------------------------------------------------------------------------------
-- DROP

-- 테이블을 삭제! (휴지통에 넣기)
DROP TABLE [테이블명] CASCADE CONSTRAINT;
DROP TABLE COFFEE CASCADE CONSTRAINT;
SELECT * FROM COFFEE;   -- 삭제됐는지 확인!

-- 휴지통에 있는 테이블 복원
FLASHBACK TABLE [테이블명] TO BEFORE DROP;
FLASHBACK TABLE COFFEE TO BEFORE DROP;
SELECT * FROM COFFEE;

-- 휴지통 비우기
PURGE RECYCLEBIN;

-- 휴지통넣기 + 비우기 => 테이블을 완전 삭제
DROP TABLE [테이블명] CASCADE CONSTRAINT PURGE;
DROP TABLE COFFEE CASCADE CONSTRAINT PURGE;

/* DDL 끝! */
--------------------------------------------------------------------------------