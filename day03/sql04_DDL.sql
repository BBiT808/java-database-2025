/*
 * DDL - 데이터 조작언어
 * CREATE, ALTER, DROP, TRUNCATE...
 * 객체를 생성하고, 수정하고, 삭제하거나, 데이터를 초기화...
 * */


-- no, name, birth 컬럼의 테이블 new_table을 생성하시오. 
-- create table new_table ();
CREATE TABLE new_table (
	NO number(5, 0) PRIMARY KEY, -- (5,0)까지 쓴 것은 만 단위까지 쓰겠다는 의미 !! / PK를 항상 기본으로 지정하자!!
	NAME varchar2(20) NOT NULL,
	jumin char(14) NULL, -- null은 기본 !!
	birth DATE
);


-- 기본값을 설정하면서 테이블 생성 
CREATE TABLE new_table (
	NO number(5, 0) PRIMARY KEY, 
	NAME varchar2(20) NOT NULL,
	jumin char(14) NULL, 
	birth DATE,
	salary number(7,0) DEFAULT 0 -- 아무값도 넣지 않고 INSERT하면 NULL 0으로 대체
);
-- 테이블컬럼에 주석추가
COMMENT ON COLUMN new_table.name IS '사원이름';


-- 기본키가 두개인 테이블 생성
CREATE TABLE DOUBLEKEYTBL(
	ID NUMBER(5,0),
	NAME VARCHAR(20) NOT NULL,
	CODE CHAR(4),
	JUMIN CHAR(14) UNIQUE,  -- NULL값도 들어갈 수 있음!!
	CONSTRAINT PK_DOUBLEKEYTBL PRIMARY KEY(ID, CODE)
);

-- NEW_MEMBER 부모테이블과 NEW_BOARD 자식테이블간의 관계가 성립된 테이블을 생성하시오.
CREATE TABLE NEW_MEMBER(
	IDX NUMBER PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	ID VARCHAR2(20) NOT NULL,
	PASS VARCHAR2(256) NOT NULL
);

-- NEW BOARD는 NEW_MEMBER의 PK IDX를 외래키로 사용.
CREATE TABLE NEW_BOARD(
	BIDX NUMBER PRIMARY KEY,
	TITLE VARCHAR2(125) NOT NULL,
	CONTENT LONG NOT NULL,
	REG_DATE DATE DEFAULT SYSDATE,
	COUNT NUMBER(6,0) DEFAULT 0,
	MIDX NUMBER NOT NULL,
	CONSTRAINT FK_memberidx FOREIGN KEY(midx) REFERENCES new_member(idx)
);

--ALTER 기존 테이블을 수정할 때 사용
ALTER TABLE NEW_TABLE ADD (address varchar2(200));

-- ALTER 기존 테이블에 전화번호 컬럼 추가
-- 이미 데이터가 존재하는 테이블에 NOT NULL 컬럼은 추가 불가 !! ***
ALTER TABLE new_table ADD (tel varchar2(20)  NOT NULL);  -- 이러면 안 돼 ~~!

-- 컬럼 수정
ALTER TABLE NEW_TABLE modify (address varchar2(100));


-- DROP 테이블 삭제
-- purge 휴지통 !!  ; 다시 살릴 수 있음 ~
-- TRUNCATE 테이블 초기화
-- id(자동으로 증가하는) 1, 2, 3, 4, 5,
DROP TABLE new_table purge;
TRUNCATE TABLE new_table;  -- 번호가 아무리 많이 있어도 삭제 가능 ~


