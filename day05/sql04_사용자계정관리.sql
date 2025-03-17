/*
 * 
 * 사용자 생성, 기존 사용자 사용 해제, 권한 주기
 */


-- HR 계정 잠금 해제!!
ALTER USER hr account unlock;
ALTER USER hr IDENTIFIED BY 12345;


SELECT *
  FROM employees;

-- PRIVILEGES 권한
-- CREATE SESSION - 접속 권한
-- CREATE TABLE, ALTER ANY TABLE, DROP ANY TABLE, ...
  -- 권한은 하나하나 다 부여해야 함! ; CONNECT / RESOURCE로 주는게 편함 !!



/* 스콧 계정이 없어!!!!!! WHERE IS SCOTT??
-- scott 계정 잠금해제
ALTER USER SCOTT account unlock;

-- scott은 create session 권한 없음. LOGON DENIED.
-- scott에서 접속권한 부여
GRANT CREATE SESSION TO scott;*/



SELECT * FROM jobs;

CREATE VIEW jobs_view
AS
	SELECT *
	  FROM jobs;  -- 이미 view를 만들 수 있는 권한이 있었다!! (sampleuser는 없었어~)
	  
	  
-- hr 계정에 어떤 권한이 있는지 조회
SELECT *
  FROM user_tab_privs;

-- HR로 테이블 생성
CREATE TABLE test(
	id NUMBER PRIMARY KEY,
	name varchar(20) NOT NULL
);


-- Role (역할) 관리
  -- 여러 권한을 묶어 놓은 개념 !!
-- role 확인
-- CONNECT -- DB 접속 및 테이블 생성 조회 권한
-- RESOURCE - PL/SQL 사용권한
-- DBA - 모든 시스템 권한
-- EXP_FULL_DATABASE - DB 익스포트 권한..

SELECT * FROM user_role_privs;
SELECT * FROM dba_role_privs;

-- HR에게 DBA역할 role 부여
GRANT DBA TO hr;

-- 확인
SELECT * FROM sampleuser.MEMBER;


-- HR에게 DBA 역할 권한 해제
REVOKE DBA from hr;

--
COMMIT;