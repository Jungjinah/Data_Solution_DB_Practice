-- *** SUBQUERY (서브쿼리) *** --
-- SELECT문 안에서 다시 SELECT문을 사용하는 기술
-- 하나의 SQL문 안에서 다른 SQL문이 중첩되는 질의문
-- 보통 데이터가 대립일때 데이터를 모두 합쳐서 연산하는 조인(JOIN)보다
-- 필요한 데이터만 찾아서 공급해주는 SUBQUERY의 성능이 더 좋음.

-- 주 질의(MAIN QUERY)와 부속 질의(SUBQUERY)로 구성된
SELECT S_NAME, S_PRICE      -- 메인
    FROM SNACK
    WHERE S_PRICE < (       -- 연산자야! 비교연산자
    SELECT AVG(S_PRICE)     -- 서브
    FROM SNACK
    );

-- 최고가
SELECT MAX(S_PRICE) FROM SNACK;

-- 제일 비싼 과자 이름, 제조사, 가격
SELECT S_NAME, S_COMPANY, S_PRICE
    FROM SNACK
    WHERE S_PRICE = (
        SELECT MAX(S_PRICE)
        FROM SNACK
    );
    
-- 제일 싼 과자는 어디서 만드는지 조회
SELECT DISTINCT S_COMPANY   -- DISTINCT 쓰는 이유 : 오직 한개의 값만 뽑기 위해
    FROM SNACK              -- 중복 안되게!
    WHERE S_PRICE = (
        SELECT MIN(S_PRICE)
        FROM SNACK
    );

-- 평균가보다 비싼 과자는 몇 종류(개)인지
SELECT COUNT(S_NAME) || '개' 종류
    FROM SNACK
    WHERE S_PRICE > (
        SELECT AVG(S_PRICE)
        FROM SNACK
    );
    
-- 유통기한이 가장 오래 남은 과자의 전체 정보 조회
SELECT * FROM SNACK
    WHERE S_DATE = (
        SELECT MAX(S_DATE)
        FROM SNACK
    );
    
-- 과자회사 테이블 -> 회사이름, 주소(지역명), 직원수의 값을 가지게
-- 데이터도 넣을건데 -> 과자 테이블의 회사에 맞춰서 넣기
CREATE TABLE COMPANY (
    C_NAME VARCHAR2(10 CHAR) PRIMARY KEY,
    C_ADDRESS VARCHAR2(10 CHAR) NOT NULL,
    C_EMPLOYEE NUMBER(3) NOT NULL
);

DROP TABLE COMPANY;

INSERT INTO COMPANY VALUES('해태', '한국', 150);
INSERT INTO COMPANY VALUES('오리온', '미국', 200);
INSERT INTO COMPANY VALUES('농심', '중국', 250);
INSERT INTO COMPANY VALUES('크라운', '캐나다', 300);

SELECT * FROM COMPANY;

-- 직원 수가 제일 적은 회사에서 만드는 과자이름, 가격 조회
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

-- 제일 비싼 과자를 만드는 회사는 어디 있는지 조회
SELECT C_NAME 회사
    FROM COMPANY
    WHERE C_NAME = (
        SELECT S_COMPANY
        FROM SNACK
        WHERE S_PRICE = (
            SELECT MAX(S_PRICE)
            FROM SNACK
        )
    );

-- 미국에 있는 회사에서 만드는 과자 평균가 조회
SELECT ROUND(AVG(S_PRICE), 2) || '원' 평균가
    FROM SNACK
    WHERE S_COMPANY = (
        SELECT C_NAME
        FROM COMPANY
            WHERE C_ADDRESS = '미국'
    );

-- 평균가 이상의 과자를 만드는 회사이름, 위치
SELECT C_NAME, C_ADDRESS
    FROM COMPANY
    WHERE C_NAME = (           -- =를 안쓰고 IN을 쓰는 이유
        SELECT S_COMPANY        -- RETURN 되는 값이 2개이상 나오는데
        FROM SNACK              -- =를 쓰면 1개의 값만 뽑아내므로 오류가 뜸
        WHERE S_PRICE >= (      -- (RETURNS MORE THAN ONE ROW)
            SELECT AVG(S_PRICE) -- 그래서 다수의 모든 값을 뽑아내기 위해
            FROM SNACK          -- IN을 쓰는 것임!
        )
    );