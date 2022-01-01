-- [������ �����Լ�]
SELECT �Լ� FROM DUAL;

--  1. ���� �Լ�
--      ABS(����) : ���밪 ���
--      ROUND(����, m) : ���� �ݿø�, m�� �ݿø� ���� �ڸ���
--      POWER(����, n) : �� ������ n������ ���
--      TRUNC(123.45, n) : n��° �ڸ����� ����� ���� ����
--      MOD(m, n) : m�� n���� ���� ������
--      SQRT(����) : ������ �������� ���(���ڴ� ���!)

--  2. ���� �Լ�
--      CONCAT(s1, s2) : �� ���ڿ��� ����
--      SUBSTR(s1, n, k) : ���ڿ��� n��°���� k��ŭ�� ���̸� ��ȯ
--      INSTR(s1, s2, n, k) : ���ڿ� s1�� n��°���� �����Ͽ� ã�����ϴ�
--                            ���ڿ� s2�� k������ ��Ÿ���� ���ڿ��� ��ġ�� ��ȯ
--      LPAD(s, n, c) : ���ڿ� s�� ���ʺ��� ������ �ڸ��� n���� ������ ���� c�� ä��
        ex) LPAD('ABC', 5, '*') = **ABC
--      LPAD(s, n, c) : ���ڿ� s�� �����ʺ��� ������ �ڸ��� n���� ������ ���� c�� ä��
        ex) RPAD('ABC', 5, '*') = ABC**
--      LTRIM(s1, s2) : ���ڿ� s1 �������� ���ʿ� �ִ� ������ ���� s2�� ����
        ex) LIRIM('*ABC', '*') = ABC
--      RTRIM(s1, s2) : ���ڿ� s1 �������� �����ʿ� �ִ� ������ ���� s2�� ����
        ex) RIRIM('ABC*', '*') = ABC
        SELECT RTRIM('ABC*', '*') FROM DUAL;    -- ABC
        SELECT RTRIM('*ABC', '*') FROM DUAL;    -- *ABC
--      REPLACE(s1, s2, s3) : s1���� ������ ���ڸ� s2�� ���ϴ� ���� s3�� ��ȯ
        select replace('JACK AND JUE', 'J', 'BL') FROM DUAL;  -- BLACK AND BLUE
--      LENGTH : ���� ���� �����ִ� �Լ�
--      LENGTHB : ������ �뷮(����Ʈ)�� �����ִ� �Լ�

--  3. ��¥ / �ð� �Լ�
--  [��¥ ����]
--  YYYY : 4�ڸ� ����
--  MM : ��
--  DD : ��
--  DAY : ���� (������~�Ͽ���)
--  DY : ���� (��~��)
--  AM/PM : ����/����
--  HH : 12�ð�
--  HH24 : 24�ð�
--  MI : ��
--  SS : ��

--      TO_DATE(s1, DATETIME ����) : ������������ -> ��¥��
--      TO_CHAR(SYSDATE, DATETIME ����) : ��¥�� -> ������
--      ADD_MONTH(DATE, ����) : ��¥���� ������ �޸�ŭ ���� (1 : ������, -1 : ������)

-- ����1) ���ó�¥ ���� ���� ��ȸ (���̺� ��� '����' / �÷��� '2021��'�̶�� ������)
SELECT TO_CHAR(SYSDATE, 'YYYY') || '��' ���� FROM DUAL;

-- ����2) ���ó�¥ ���� �� ��ȸ (���̺� ��� '��' / �÷��� '12��'�̶�� ������)
SELECT TO_CHAR(SYSDATE, 'MM') || '��' �� FROM DUAL;

-- ����3) ���ó�¥ ���� �� ��ȸ (���̺� ��� '��' / �÷��� '31��'�̶�� ������)
SELECT TO_CHAR(SYSDATE, 'DD') || '��' �� FROM DUAL;

-- ����4) ���ó�¥ ���� ��/�� ��ȸ (���̺� ��� ���� '��' '��' / �÷��� '20��21��'�̶�� ������)
SELECT TO_CHAR(SYSDATE, 'HH24') || '��' ��,
        TO_CHAR(SYSDATE, 'MI') || '��' �� FROM DUAL;
        
-- ����5) ���ڿ� '2021-12-31 ���� 06:00'�� 2021.12.31�� ��ȸ
SELECT TO_CHAR(TO_DATE('2021-12-31 ���� 06:00', 'YYYY-MM-DD AM HH:MI'), 'YYYY.MM.DD') FROM DUAL;

-- ����6) ���ó�¥ ���� 3���� ������ ���� ��� ��ĥ����
SELECT TO_CHAR(LAST_DAY(ADD_MONTH(SYSDATE, -3)), 'MM-DD') FROM DUAL;   
-- -> �� �̰� ���� �´µ� ��Ŭ�������� ADD_MONTH �ȸ���,,

--  4. ���� / �м� �Լ� : SELECT �ʵ�� / HAVING ������ ���!
--      - AVG(�ʵ��) : ���
--      - COUNT(�ʵ��) : �˻��Ǵ� ������ ��
--      - MAX(�ʵ��) : �ִ밪
--      - MIN(�ʵ��) : �ּҰ�
--      - SUM(�ʵ��) : �� ��
--      - RANK(�ʵ��) : �ߺ� ������ŭ ���� �������� ���� ��Ŵ
--      - DENSE_RANK(�ʵ��) : �ߺ� ������ �����ص� ���� �������� ǥ����

--  5. NULL ���� �Լ�
--      -NVL�Լ� : NULL�� ��츸 ������ ������ ��ġ�ϴ� �Լ�
--          NVL(��, NULL�� �� ��ü�� ��)
--      -NVL2�Լ� : NULL�� ���ο� ���� ������ ������ ��ġ�ϴ� �Լ�
--          NVL2(��, ���� ������ ��ü�� ��, NULL�� �� ��ü�� ��)
--------------------------------------------------------------------------------