/*
 * 인덱스 - DB 검색을 효율적으로 빠르게 처리하는 기술
 * 
 * */

-- 기본 테이블 생성
CREATE TABLE test_noindex(
	id NUMBER NOT NULL,
	name varchar(20) NOT NULL, 
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);  -- PK를 만들지 않고 테이블을 만들면 INDEX가 없다 !!


-- 인덱스 테이블 생성
CREATE TABLE test_index(
	id NUMBER NOT NULL PRIMARY KEY,
	name varchar(20) NOT NULL, 
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);


-- 유니크 인덱스 테이블 생성(유니크인덱스)  -- UNIQUE에 자동으로 INDEX가 걸림 !!
CREATE TABLE test_uniqueindex(
	id NUMBER NOT NULL,
	name varchar(20) NOT NULL UNIQUE, 
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);


-- 인덱스 생성 쿼리 테스트용 테이블 생성
CREATE TABLE test_index2(
	id NUMBER NOT NULL,
	name varchar(20) NOT NULL, 
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);

CREATE INDEX idx_id ON test_index2(id);
-- 수동으로 만들 때는 언제나 이름을 붙여주자 ~
CREATE INDEX idx_name_PHONE ON test_index2(name, phone);

CREATE INDEX idx_id_name2 ON test_index2(id, name);
-- 인덱스가 추가되면 용량이 늘어난다 (인덱스 테이블이 계속 추가됨 !)

/*
 * 인덱스 테스트. 인덱스가 없을 때 검색 쿼리 실행 소요 시간,
 * 인덱스 구성 후 검색 쿼리 실행 소요 시간 비교!! 
 * 
 * */

-- 인덱스 테스트 sample_t
-- 번호가 중복된 게 있는지 확인 쿼리 !!
SELECT COUNT(ID1)
  FROM sample_t
 GROUP BY ID1
HAVING COUNT(ID1) > 1;

-- 검색
-- INDEX를 걸면 시간이 확 단축된다!! 최고!! (대신 용량이 늘어남~)
SELECT *
  FROM sample_t
 WHERE ID1 = 976453;

SELECT *
  FROM sample_t WHERE ID1 = 10000000;

SELECT *
  FROM SAMPLE_T
 WHERE id1 IN (976453, 934564, 174555, 6785, 146789, 897554);

SELECT *
  FROM SAMPLE_T
 WHERE id1 BETWEEN 100000 AND 300000;

SELECT *
  FROM sample_t
 WHERE date3 BETWEEN '2011-01-01' AND '2016-12-31'
 
 SELECT *
  FROM sample_t;
 
-- sample_t에 PK 추가
ALTER TABLE sample_t ADD PRIMARY KEY(id1);
-- 인덱스 테이블 생성으로 30초 정도 시간 소요 !

-- date1번에서 조회
SELECT *
  FROM SAMPLE_T
 WHERE date1 = '20171206';
-- 원래는 0.45초 소요 !! ; 이것도 빠른 시간은 아님 !!
-- INDEX를 생성해주니까 0.019초 걸렸다 !! 와 빠르다~


-- date1에 대해서 인덱스를 생성해 줌 !!
CREATE INDEX idx_date1 ON sample_t(date1);


-- test3 컬럼 값 조회
SELECT *
  FROM sample_t 
 WHERE test3 = 'A678';


-- autocommit을 끄고 나면 DDL, DML(SELECT 이외) 작업 후 필히 commit; 수행 후 파일 저장 !!
COMMIT;
