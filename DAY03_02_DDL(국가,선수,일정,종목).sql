-- 실습. Olympics 데이터 베이스
-- 테이블 삭제
DROP TABLE SCHEDULE_TBL CASCADE CONSTRAINTS;
DROP TABLE PLAYER_TBL  CASCADE CONSTRAINTS;
DROP TABLE EVENT_TBL CASCADE CONSTRAINTS;
DROP TABLE NATION_TBL CASCADE CONSTRAINTS;

-- 국가(NATION_TBL) 테이블 생성
CREATE TABLE NATION_TBL(
    N_CODE          NUMBER(3)           NOT NULL, -- NUMBER(4) : 0 ~ 9999
    N_NAME          VARCHAR2(30 BYTE)   NOT NULL,
    N_PARTI_PERSON  NUMBER              NULL,
    N_PARTI_EVENT   NUMBER              NULL,
    N_PREV_RANK     NUMBER              NULL,
    N_CURR_RANK     NUMBER              NULL
);

-- 종목(EVENT_TBL) 테이블 생성
CREATE TABLE EVENT_TBL(
    E_CODE          NUMBER              NOT NULL,
    E_NAME          VARCHAR2(30 BYTE)   NOT NULL,
    E_FIRST_YEAR    NUMBER(4)           NULL,
    E_INFO          VARCHAR2(100 BYTE)  NULL
);

-- 선수(PLAYER_TBL) 테이블 생성
CREATE TABLE PLAYER_TBL(
    P_CODE NUMBER(3)         NOT NULL,
    P_NAME VARCHAR2(30 BYTE) NOT NULL,
    N_CODE NUMBER(3)         NOT NULL,
    E_CODE NUMBER            NOT NULL,
    P_RANK NUMBER            NULL,
    P_AGE  NUMBER(3)         NULL
);

-- 일정(SCHEDULE_TBL) 테이블 생성
CREATE TABLE SCHEDULE_TBL(
    S_NO            NUMBER(3)             NOT NULL,
    N_CODE          NUMBER(3)             NULL,
    E_CODE          NUMBER                NULL,
    S_START_DATE    DATE                  NULL,
    S_END_DATE      DATE                  NULL,
    S_INFO          VARCHAR2(100 BYTE)    NULL
);

-- 기본키 추가하기
ALTER TABLE NATION_TBL      ADD CONSTRAINT   PK_NATION       PRIMARY KEY(N_CODE);
ALTER TABLE EVENT_TBL       ADD CONSTRAINT   PK_EVENT        PRIMARY KEY(E_CODE);
ALTER TABLE PLAYER_TBL      ADD CONSTRAINT   PK_PLAYER       PRIMARY KEY(P_CODE);
ALTER TABLE SCHEDULE_TBL    ADD CONSTRAINT   PK_SCHEDULE     PRIMARY KEY(S_NO);


-- 외래키 추가하기
ALTER TABLE PLAYER_TBL      ADD CONSTRAINT   FK_NATION_PLAYER   FOREIGN KEY(N_CODE)    REFERENCES NATION_TBL(N_CODE)    ON DELETE CASCADE;
-- PLAYER_TBL의 N_CODE가 NOT NULL이므로, ON DELETE SET NULL이 불가능하다.
ALTER TABLE PLAYER_TBL      ADD CONSTRAINT   FK_EVENT_PLAYER    FOREIGN KEY(E_CODE)    REFERENCES EVENT_TBL(E_CODE)     ON DELETE CASCADE;
-- PLAYER_TBL의 E_CODE가 NOT NULL이므로, ON DELETE SET NULL이 불가능하다.
ALTER TABLE SCHEDULE_TBL    ADD CONSTRAINT   FK_NATION_SCHEDULE FOREIGN KEY(N_CODE)    REFERENCES NATION_TBL(N_CODE)    ON DELETE SET NULL;
-- ON DELETE CASCADE도 가능하다.
ALTER TABLE SCHEDULE_TBL    ADD CONSTRAINT   FK_EVENT_SCHEDULE  FOREIGN KEY(E_CODE)    REFERENCES EVENT_TBL(E_CODE)     ON DELETE SET NULL;
-- ON DELETE CASCADE도 가능하다.

-- 국가 테이블의 기본키 삭제하기
-- 국가 테이블의 기본키를 참조하는 외래키를 먼저 삭제해야 한다.
ALTER TABLE PLAYER_TBL      DROP CONSTRAINT FK_NATION_PLAYER;
ALTER TABLE SCHEDULE_TBL    DROP CONSTRAINT FK_NATION_SCHEDULE;
ALTER TABLE NATION_TBL      DROP CONSTRAINT PK_NATION;


-- 선수 테이블의 FK_EVE_PLA 외래키 일시중지하기
ALTER TABLE PLAYER_TBL DISABLE CONSTRAINT FK_EVENT_PLAYER;

-- 선수 테이블의 FK_EVE_PLA 외래키 다시 시작하기
ALTER TABLE PLAYER_TBL ENABLE CONSTRAINT FK_EVENT_PLAYER;