/*
    기초데이터 준비
    HR계정의 EMPLOYEES 테이블을 GD 계정으로 복사해서 사용
*/

DROP TABLE EMPLOYEES;
CREATE TABLE EMPLOYEES AS (
    SELECT *
      FROM HR.EMPLOYEES
);
-- 기본키/외래키 제약 조건은 복사가 되지 않는다.
ALTER TABLE EMPLOYEES ADD CONSTRAINT PK_EMP PRIMARY KEY(EMPLOYEE_ID);

/*
    PL/SQL
    1. 오라클 문법이다.
    2. 프로그래밍이 가능한 SQL문 작성 방법이다.
    3. 프로시저, 사용자 함수 등의 기반이 되는 언어이다.
    4. 항상 블록을 잡고 실행한다.
    5. 형식
        [DECLARE 변수 선언]
        BEGIN
            실행문
        END;
*/

/*
    변수 선언하기
    1. 값을 저장할 때 대입 연산자(:=)를 사용한다.
    2. 타입을 선언하는 방식
        1) 스칼라 변수 : 타입을 직접 지정한다.
        2) 참조 변수   : 특정 칼럼의 타입을 그대로 사용한다.
*/


/*
    서버 메시지 출력하기
    1. 기본적으로 서버 메시지는 출력되지 않는다.
    2. 서버 메시지 출력을 위해서 최초 1회 아래 쿼리문을 실행한다.
        SET SERVEROUTPUT ON;
    3. 출력하는 방법
        DBMS_OUTPUT.PUT_LINE(출력할 내용);
*/

-- 서버 메시지 출력 ON
SET SERVEROUTPUT ON;

-- Hello World 출력하기
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;


-- 1. 스칼라 변수(직접 타입을 명시하는 방법)
DECLARE
    NAME VARCHAR2(20 BYTE);
    AGE  NUMBER(3);
BEGIN
    NAME := 'tom';
    AGE  := 30;
    DBMS_OUTPUT.PUT_LINE('이름은 ' || NAME || '입니다.');
    DBMS_OUTPUT.PUT_LINE('나이는 ' || AGE  || '살입니다.');
END;


-- 2. 참조 변수(특정 칼럼의 타입을 명시)
DECLARE
    EMPLOYEEID EMPLOYEES.EMPLOYEE_ID%TYPE;
    FIRSTNAME  EMPLOYEES.FIRST_NAME%TYPE;
    LASTNAME   EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
      INTO EMPLOYEEID, FIRSTNAME, LASTNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = 100;
    DBMS_OUTPUT.PUT_LINE(EMPLOYEEID || ',' || FIRSTNAME || ',' || LASTNAME);
END;

/*
    IF 구문
    
    IF 조건식1 THEN
        실행문1
    ELSIF 조건식2 THEN
        실행문2
    ...
    ELSE
        실행문N
    END IF;
*/

-- 1. 스칼라 변수를 이용한 IF문 처리하기
DECLARE
    SCORE NUMBER(3);
    GRADE VARCHAR2(1 BYTE);
BEGIN
    SCORE := 80;   -- 임의의 점수 저장
    IF SCORE >= 90 THEN
        GRADE := 'A';
    ELSIF SCORE >= 80 THEN
        GRADE := 'B';
    ELSIF SCORE >= 70 THEN
        GRADE := 'C';
    ELSIF SCORE >= 60 THEN
        GRADE := 'D';
    ELSE
        GRADE := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE(SCORE || '점은 ' || GRADE || '학점입니다.');
END;


-- 2. 참조 변수를 이용한 IF문 처리
DECLARE
    EMPLOYEEID EMPLOYEES.EMPLOYEE_ID%TYPE;
    SAL        EMPLOYEES.SALARY%TYPE;
BEGIN
    EMPLOYEEID := 150;  -- 임의의 사원번호 저장
    SELECT SALARY
      INTO SAL
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMPLOYEEID;
    IF SAL >= 10000 THEN
        DBMS_OUTPUT.PUT_LINE('고액연봉');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보통연봉');
    END IF;
END;