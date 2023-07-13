/*
    프로시저(Procedure)
    1. 여러 쿼리문을 한 번에 수행할 수 있다.
    2. "EXECUTE 프로시저명()" 형식으로 실행할 수 있다. (프로시저 호출)
    3. 형식
        CREATE [OR REPLACE] PROCEDURE 프로시저명
        AS              -- IS를 사용해도 무방
            변수 선언   -- 생략 가능
        BEGIN
            프로시저본문
        [EXCEPTION 예외처리]
        END;
*/

-- 서버 메시지 출력 ON
SET SERVEROUTPUT ON;

-- 프로시저 정의(프로시저 만들기)
CREATE OR REPLACE PROCEDURE MY_PROC_01
AS
    NAME VARCHAR2(20 BYTE);
BEGIN
    NAME := 'tom';
    DBMS_OUTPUT.PUT_LINE(NAME || '님 환영합니다.');
END;

-- 프로시저 호출(프로시저 실행하기)
EXECUTE MY_PROC_01();

-- 사원번호가 100인 사원의 이름을 출력하는 프로시저
CREATE OR REPLACE PROCEDURE MY_PROC_02
IS
    FIRSTNAME EMPLOYEES.FIRST_NAME%TYPE;
    LASTNAME  EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME, LAST_NAME
      INTO FIRSTNAME, LASTNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = 100;
     DBMS_OUTPUT.PUT_LINE(FIRSTNAME || ' ' || LASTNAME);
END;

EXECUTE MY_PROC_02();


-- 사원번호를 전달하면 해당 사원의 이름을 출력하는 프로시저
CREATE OR REPLACE PROCEDURE MY_PROC_03(EMPLOYEEID IN EMPLOYEES.EMPLOYEE_ID%TYPE)   -- 프로시저로 전달된 인수를 저장하는 입력 파라미터
IS
    FIRSTNAME EMPLOYEES.FIRST_NAME%TYPE;
    LASTNAME  EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME, LAST_NAME
      INTO FIRSTNAME, LASTNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMPLOYEEID;
     DBMS_OUTPUT.PUT_LINE(FIRSTNAME || ' ' || LASTNAME);
END;

EXECUTE MY_PROC_03(206);    -- 프로시저로 전달하는 인수 206







