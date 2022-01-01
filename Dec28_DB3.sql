-- [쓸만한 내장함수]
SELECT 함수 FROM DUAL;

--  1. 숫자 함수
--      ABS(숫자) : 절대값 계산
--      ROUND(숫자, m) : 숫자 반올림, m은 반올림 기준 자릿수
--      POWER(숫자, n) : 이 숫자의 n제곱을 계산
--      TRUNC(123.45, n) : n번째 자리까지 남기고 값을 버림
--      MOD(m, n) : m을 n으로 나눈 나머지
--      SQRT(숫자) : 숫자의 제곱근을 계산(숫자는 양수!)

--  2. 문자 함수
--      CONCAT(s1, s2) : 두 문자열은 연결
--      SUBSTR(s1, n, k) : 문자열의 n번째부터 k만큼의 길이를 반환
--      INSTR(s1, s2, n, k) : 문자열 s1의 n번째부터 시작하여 찾고자하는
--                            문자열 s2가 k번쨰에 나타나는 문자열의 위치를 반환
--      LPAD(s, n, c) : 문자열 s의 왼쪽부터 지정한 자릿수 n까지 지정한 문자 c로 채움
        ex) LPAD('ABC', 5, '*') = **ABC
--      LPAD(s, n, c) : 문자열 s의 오른쪽부터 지정한 자릿수 n까지 지정한 문자 c로 채움
        ex) RPAD('ABC', 5, '*') = ABC**
--      LTRIM(s1, s2) : 문자열 s1 기준으로 왼쪽에 있는 지정한 문자 s2를 제거
        ex) LIRIM('*ABC', '*') = ABC
--      RTRIM(s1, s2) : 문자열 s1 기준으로 오른쪽에 있는 지정한 문자 s2를 제거
        ex) RIRIM('ABC*', '*') = ABC
        SELECT RTRIM('ABC*', '*') FROM DUAL;    -- ABC
        SELECT RTRIM('*ABC', '*') FROM DUAL;    -- *ABC
--      REPLACE(s1, s2, s3) : s1에서 지정한 문자를 s2를 원하는 문자 s3로 변환
        select replace('JACK AND JUE', 'J', 'BL') FROM DUAL;  -- BLACK AND BLUE
--      LENGTH : 글자 수를 세어주는 함수
--      LENGTHB : 글자의 용량(바이트)를 세어주는 함수

--  3. 날짜 / 시간 함수
--  [날짜 형식]
--  YYYY : 4자리 연도
--  MM : 월
--  DD : 일
--  DAY : 요일 (월요일~일요일)
--  DY : 요일 (월~일)
--  AM/PM : 오전/오후
--  HH : 12시간
--  HH24 : 24시간
--  MI : 분
--  SS : 초

--      TO_DATE(s1, DATETIME 형식) : 문자형데이터 -> 날짜형
--      TO_CHAR(SYSDATE, DATETIME 형식) : 날짜형 -> 문자형
--      ADD_MONTH(DATE, 숫자) : 날짜에서 지정한 달만큼 더함 (1 : 다음달, -1 : 이전달)

-- 예제1) 오늘날짜 기준 연도 조회 (테이블 헤더 '연도' / 컬럼에 '2021년'이라고 나오게)
SELECT TO_CHAR(SYSDATE, 'YYYY') || '년' 연도 FROM DUAL;

-- 예제2) 오늘날짜 기준 월 조회 (테이블 헤더 '월' / 컬럼에 '12월'이라고 나오게)
SELECT TO_CHAR(SYSDATE, 'MM') || '월' 월 FROM DUAL;

-- 예제3) 오늘날짜 기준 일 조회 (테이블 헤더 '일' / 컬럼에 '31일'이라고 나오게)
SELECT TO_CHAR(SYSDATE, 'DD') || '일' 일 FROM DUAL;

-- 예제4) 오늘날짜 기준 시/분 조회 (테이블 헤더 각각 '시' '분' / 컬럼에 '20시21분'이라고 나오게)
SELECT TO_CHAR(SYSDATE, 'HH24') || '시' 시,
        TO_CHAR(SYSDATE, 'MI') || '분' 분 FROM DUAL;
        
-- 예제5) 문자열 '2021-12-31 오전 06:00'을 2021.12.31로 조회
SELECT TO_CHAR(TO_DATE('2021-12-31 오전 06:00', 'YYYY-MM-DD AM HH:MI'), 'YYYY.MM.DD') FROM DUAL;

-- 예제6) 오늘날짜 기준 3달전 마지막 날은 몇월 며칠인지
SELECT TO_CHAR(LAST_DAY(ADD_MONTH(SYSDATE, -3)), 'MM-DD') FROM DUAL;   
-- -> 아 이거 답은 맞는데 이클립스에서 ADD_MONTH 안먹힘,,

--  4. 집계 / 분석 함수 : SELECT 필드명 / HAVING 절에서 사용!
--      - AVG(필드명) : 평균
--      - COUNT(필드명) : 검색되는 데이터 수
--      - MAX(필드명) : 최대값
--      - MIN(필드명) : 최소값
--      - SUM(필드명) : 총 합
--      - RANK(필드명) : 중복 순위만큼 다음 순위값을 증가 시킴
--      - DENSE_RANK(필드명) : 중복 순위가 존재해도 다음 순위값을 표시함

--  5. NULL 관련 함수
--      -NVL함수 : NULL인 경우만 지정한 값으로 대치하는 함수
--          NVL(값, NULL일 때 대체할 값)
--      -NVL2함수 : NULL의 여부에 따라서 지정한 값으로 대치하는 함수
--          NVL2(값, 값이 있을때 대체할 값, NULL일 때 대체할 값)
--------------------------------------------------------------------------------