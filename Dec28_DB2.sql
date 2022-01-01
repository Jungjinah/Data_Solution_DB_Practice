-- 과자 테이블
-- 과자이름, 과자회사, 과자가격

CREATE TABLE SNACK (
    S_NO NUMBER(4) PRIMARY KEY,
    S_NAME VARCHAR2(10 CHAR) NOT NULL,
    S_COMPANY VARCHAR2(10 CHAR) NOT NULL,
    S_PRICE NUMBER(5) NOT NULL,
    
    S_DATE DATE NOT NULL        -- 날짜일 때 넣어주기 (83행을 위해)
);

DROP TABLE SNACK;
--------------------------------------------------------------------------------
-- DML (DATA MANIPULATION LANGUAGE) : 데이터 조작어
-- 데이터를 검색, 삽입, 수정, 삭제하는데 사용되는 문장
-- SELECT, INSERT, UPDATE, DELETE, ...
-- 줄여서 CRUD!
-- C (INSERT)
INSERT INTO [테이블명](컬럼명, 컬럼명, ...) VALUES(값, 값, ...);

INSERT INTO SNACK(S_NO, S_NAME, S_COMPANY, S_PRICE) VALUES (1, '초코파이', '오리온', 500);
-- => 컬럼명을 명시해주는게 원칙!

-- 컬럼순서를 바꿔서 넣기? -> 가능
INSERT INTO SNACK(S_NO, S_NAME, S_PRICE, S_COMPANY) VALUES (1, '새콤달콤', 500, '롯데');
-- => 컬럼순서 변경 가능하나, 변경된 컬럼에 맞춰 값을 넣어야함

-- 컬럼명 명시 안하고 순서대로 값을 넣기? -> 가능
INSERT INTO SNACK VALUES (3, '엄마손파이', '롯데', 3500);
-- => 테이블 순서대로 넣어주기만 하면 컬럼명 안써도 돼!

-- 4~5개 넣어봅시다!
INSERT INTO SNACK VALUES(1, '미쯔', '오리온', 500);
INSERT INTO SNACK VALUES(2, '홈런볼', '해태', 2500);
INSERT INTO SNACK VALUES(3, '부라보콘', '해태', 1500);
INSERT INTO SNACK VALUES(4, '가나초콜렛', '롯데', 800);
SELECT * FROM SNACK;
-- => 이거 만드는데 번호 지정하는거 귀찮지 않음? SO, 아래꺼 실행 GO

-- FACTORY PATTERN!
-- MY SQL : AUTOINCREMENT 옵션
-- ORACLE : SEQUENCE
--      번호를 순서에 맞게 자동으로 생성해주는데..
--      테이블과는 무관하고, INSERT에 실패해도 SEQUENCE 값은 올라감

-- SEQUENCE 생성
CREATE SEQUENCE 시퀀스명; -- 간단하게 만들기
CREATE SEQUENCE SNACK_SEQ;
-- 문화처럼, 테이블명 뒤에 _SEQ를 붙여주는 문화가 있음

-- 구체적인 시퀀스 (이건 그냥 필기,, 복잡하게 쓸 생각 ㄴㄴ)
CREATE SEQUENCE 시퀀스명
    INCREMENT BY 1 -- 증가값(1씩 증가)
    START WITH 1   -- 시작값
    MINVALUE       -- 최소값
    MAXVALUE       -- 최대값
    NOCYCLE/CYCLE  -- 최대값에 도달하면 시작값부터 다시 반복할지/말지
    NOCACHE/CACHE  -- 시퀀스를 미리 만들어놓고 메모리에서 가져다 쓸지/말지
    NOORDER/ORDER  -- N번 반복할지/말지
    ;
-- SEQUENCE 삭제
DROP SEQUENCE [시퀀스명];
DROP SEQUENCE SNACK_SEQ;

-- SEQUENCE 사용
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '초코파이', '롯데', 5000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '초코파이', '오리온', 5000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '마이쮸', '롯데', 800);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '허니버터칩', '해태', 3000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '허니버터칩(이건실패)', '해태', 5000000);
INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '새콤달콤', '크라운', 500);
SELECT * FROM SNACK;
-- 5번 실패해서 쏙 빠진상태로 결과값이 나옴! (S_NO부분이)

-- => 시퀀스 돌리기 전에 위에 INSERT 제품들 돌리면 번호끼리 충돌하므로 안돌린 상태로 시퀀스만 돌려야함!
-- => 근데 위에 INSERT 이미 돌렸으면 테이블삭제, 시퀀스삭제 모두 시행해야함!

-- 시간 / 날짜
--      SYSDATE : 오늘날짜 / 현재시간
SELECT SYSDATE FROM DUAL;

INSERT INTO SNACK VALUES(SNACK_SEQ.NEXTVAL, '새콤달콤 딸기맛', '크라운', 500, SYSDATE);

-- 특정시간 / 날짜
--      내장함수 - TO_DATE('값', '패턴')
--          패턴(대문자) - YYYY, MM, DD, AM/PM, HH, HH24(추천), MI(분), SS(초)

insert into snack values(snack_seq.nextval, '새콤달콤 포도맛', '크라운', 500, to_date('2022-02-15 17', 'YYYY-MM-DD HH24')
);
-- 이제 값들을 막! 넣어주세요! (데이터는 많으면 많을수록 좋다!)
insert into snack values(snack_seq.nextval, '미쯔', '오리온', 1000, to_date('2022-02-15 17', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '홈런볼', '해태', 1500, to_date('2022-03-15 13', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '부라보콘', '해태', 1000, to_date('2022-04-15 14', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '쌍쌍바', '해태', 400, to_date('2022-02-16 19', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '콘칩', '크라운', 1500, to_date('2022-02-17 21', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '초코송이', '오리온', 1000, to_date('2022-02-18 05', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '칸초', '롯데', 1000, to_date('2023-02-15 22', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '오징어집', '농심', 1200, to_date('2022-06-15 11', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '오뜨', '오리온', 4500, to_date('2022-02-13 16', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '양파링', '농심', 1300, to_date('2022-09-15 10', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '바나나킥', '농심', 1300, to_date('2022-12-18 07', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '오예스', '해태', 3500, to_date('2022-07-14 02', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '맛동산', '해태', 2000, to_date('2022-05-10 01', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '허니버터칩', '해태', 1500, to_date('2024-03-11 18', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '새우깡', '농심', 1200, to_date('2022-11-16 05', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '포키', '해태', 1500, to_date('2022-12-05 06', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '자가비', '해태', 1500, to_date('2023-10-04 23', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '포카칩', '오리온', 1500, to_date('2022-08-01 12', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '마이쮸 포도맛', '크라운', 800, to_date('2025-06-27 10', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '구운감자', '해태', 1000, to_date('2024-03-21 23', 'YYYY-MM-DD HH24')
);
insert into snack values(snack_seq.nextval, '카스타드', '오리온', 2500, to_date('2024-03-21 17', 'YYYY-MM-DD HH24')
);
SELECT * FROM SNACK;
--------------------------------------------------------------------------------
-- 이제 데이터를 조회해보자!
-- R (READ)
SELECT [DISTINCT] [컬럼명], [컬럼명 AS 별칭 || 컬럼명 별칭], [연산자 사용], [통계함수], ...
    FORM [테이블명]
    WHERE [조건식]
    GROUP BY [그룹대상]
    HAVING [함수 포함한 조건]
    ORDER BY [정렬대상] [ASC / DESC(오름차순/내림차순)] -- 기본값은 오름차순
    
-- 과자테이블 전체 조회
SELECT * FROM SNACK;
SELECT S_COMPANY FROM SNACK;          -- 과자 종류별로 회사값이 나오는데,, 중복제거하고싶어!
SELECT DISTINCT S_COMPANY FROM SNACK; -- 중복 제거되고 하나씩만 나오게 됨!

-- 숫자 계산이 가능한데..
-- 컬럼명 자체가 S_PRICE/100
--      -> 컬럼명에 별칭을 부여해서 어떤 값인지 눈에 보이게 명시
SELECT S_PRICE / 100 FROM SNACK;
-- 별칭 부여 방법 2가지
SELECT S_PRICE / 100 AS "가격" FROM SNACK;   -- AS로 별칭 부여 1  
SELECT S_PRICE / 100 PRICE FROM SNACK;      -- 띄어쓰기로 별칭 부여 2
--------------------------------------------------------------------------------
-- 연산자 (산술 연산자)
-- DUAL 테이블     (SYSDATE할 때도 DUAL테이블 씀!)
--  1. 오라클 자체에서 제공하는 더미테이블
--  2. 간단하게 함수를 이용해서 계산 결과값을 확인할 때 사용

-- 대부분의 언어들은 문자 우선돼서 13이라는 결과값이 나오는데
-- 오라클에서는 반대로 숫자가 우선시 됨!
SELECT 1 + '3' FROM DUAL;   -- 4나옴

-- 숫자만 연산해줌 -> 숫자 + 숫자가 아닌문자 => 에러!
SELECT 1 + 'A' FROM DUAL;       -- 작은따옴표로 문자를 나타내도 그 안에 숫자가 들어가야 숫자출력 가능

-- 문자를 더해주기 위한 연산자(||)
SELECT '3' || 10 FROM DUAL; --  310
--------------------------------------------------------------------------------
-- WHERE (조건식)
-- 전체 데이터 중 지정한 조건에 맞는 데이터를 찾아주는 문장
-- 조건식에 사용할 연산자 (비교연산자)
-- = , != , ^=, <>, > , <, >=, <=, ...
-- 2번째와 4번째는 표준화 하기 위해서 만듬
-- 3번쨰는 차별화를 두기 위해서 만듬
-- => 근데 우리는 2번째 쓰니까 2번째만 알아둬도 돼!

-- 예제1) 가격이 3000원인 과자의 모든 정보를 조회
SELECT * FROM SNACK
    WHERE S_PRICE >= 3000;
    
-- 예제2) 모든 과자이름(가격)으로 조회 (EX : 콘칩(2000)) + 테이블 헤더에 이름(가격) 나오게
-- 힌트) 이름(가격) 실행하면 안나옴! -> "이름(가격)" 지정해야함
SELECT S_NAME || '(' || S_PRICE || ')원' AS "이름(가격)" FROM SNACK;

-- 예제3) 2000원 이하의 과자 중에서 최소가격이 얼마인지
SELECT MIN(S_PRICE) 최소가격
    FROM SNACK
    WHERE S_PRICE <= 2000;

-- 예제4) 모든 과자의 평균가가 얼마인지
SELECT ROUND(AVG(S_PRICE),2) 평균가 FROM SNACK;
    
-- 예제5) 과자의 이름, 가격의 30% 할인된 금액
SELECT S_NAME 이름, S_PRICE * 0.7 할인가 FROM SNACK;     -- 별칭'들' 부여할때 내용 바로 뒤에 별칭 부여!

-- 예제6) 3000원 이하인 과자의 이름, 회사이름 조회
SELECT S_NAME 이름, S_COMPANY 회사
    FROM SNACK
    WHERE S_PRICE <= 3000;




