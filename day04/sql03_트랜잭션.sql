SET TRANSACTION READ WRITE;
-- 안 써도 무방하긴 하지만 !!! 그래도 한 번 써놓자.

-- 테이블 복사
CREATE TABLE REGIONS_NEW
AS
 SELECT * FROM REGIONS;

-- 커밋
COMMIT;

-- 데이터 조회
SELECT * FROM REGIONS_NEW;

-- 실수로 전부삭제
DELETE FROM REGIONS_NEW;

ROLLBACK; -- 원상복귀, 트랜잭션은 종료안됨
COMMIT; -- 확정짓고 트랜잭션이 종료!

-- 실수로 모두 동일값으로 변경
UPDATE REGIONS_NEW SET
  REGION_NAME = 'North America';

-- 데이터 조회
SELECT * FROM REGIONS_NEW;

ROLLBACK;   -- 원상복귀, 트랜잭션은 종료 안 됨 !
COMMIT;     -- 확정짓고 트랜잭션 종료 !

UPDATE REGIONS_NEW SET 
  REGION_NAME = 'North America' ;

