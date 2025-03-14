/*
 *  UPDATE/DELETE
 *  데이터 변경 / 데이터 삭제 
 * 
 * */


-- 삭제

SELECT count(*) FROM professor_new;
SELECT * FROM professor_new;

DELETE FROM professor_new
 WHERE profno = 1001;

-- 삭제 시 WHERE절 빼는 것은 극히!!! 극히 주의!!!!
-- TRUNCATE와 기능은 비슷 (TRUNCATE는 데이터 초기화, DELETE는 데이터 삭제!(테이블 초기화는 없음))
-- 요새는 DELETE 잘 안 씀 / UPDATE로 안 보이게 한대 !!!
DELETE FROM professor_new;

-- 변경
-- PROFNO 4002번인 수잔 서랜든의 아이디를 기존 Sarandon에서 SusanS으로, 급여를 330에서 350으로 올리시오.
-- 키값에 맞춰서 한 건만 변경됨 !!
UPDATE professor_new SET
	   ID = 'SusanS'
	 , PAY = 350;
 WHERE PROFNO = 4002;


/*
 * 트랜잭션, COMMIT, ROLLBACK
 * 
 * */

-- CF)


-- 윈도우 - 환경설정 - 연결- 연결유형에서 Auto-commint by default 를 체크 해제해주기 !!!
--  >> 이후 한번 데이터베이스를 껐다 켜주거나 리셋을 시켜줘야 트랜잭션과 롤백을 할 수 있게 됨 !!!!
SET TRANSACTION READ WRITE;
-- 안 써도 무방하긴 하지만 !!! 그래도 한 번 써놓자.

UPDATE professor_new SET
	   ID = 'SusanS'
	 , PAY = 350;

SELECT * FROM professor_new;

ROLLBACK;

CREATE TABLE REGIONS_NEW
AS
 SELECT * FROM REGIONS;

INSERT INTO REGINOS_NEW
SELECT * FROM REGIONS;

SELECT * FROM REGIONS_NEW;

DELETE FROM REGIONS_NEW;

ROLLBACK;   -- 원상복귀, 트랜잭션은 종료 안 됨 !
COMMIT;     -- 확정짓고 트랜잭션 종료 !

UPDATE REGIONS_NEW SET 
  REGION_NAME = 'North America' ;

