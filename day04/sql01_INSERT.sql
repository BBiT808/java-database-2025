/*
 * 20250314 sql 네번째 수업!!! 헉!!! 29번째 수업!!!
 * ----------------------------------------------------
 * 
 * DML 중 SELECT 이외
 * INSERT, UPDATE, DELETE
 * */

-- INSERT
SELECT * FROM NEW_TABLE;


-- INSERT QUERY 기본
INSERT INTO NEW_TABLE  (NO, name, jumin, birth, salary)
VALUES(1, '홍길동', '810205-1825687', '1981-02-05' ,5000);

-- 테이블 컬럼리스트와 동일한 순서, 동일한 값을 넣을 때
-- 단, 컬럼리스트와 순서도 다르고, 값의 리스트 개수도 다르면 컬럼리스트 생략 불가 !!
INSERT INTO NEW_TABLE 
VALUES(2, '홍길순', '830105-2825698', '1983-01-05',4000);

-- 컬럼리스트 순서와 개수가 다를 때는 반드시 적어줘야 함 !
INSERT INTO NEW_TABLE  (jumin, Name, no)
VALUES('760405-1825685', '성유고', 3);


-- 값이 무엇인지 모를 때는 NULL로 삽입 !!
INSERT INTO NEW_TABLE  
VALUES(4, '홍길태', '830105-1825699', NULL, NULL);

-- 한 테이블에 있는 데이터를 모두 옮기면서 새로운 테이블을 생성!
-- PK는 복사 안 됨 !!
CREATE TABLE professor_new
AS
 SELECT * FROM professor;

SELECT * FROM professor_new;

-- 만들어진 테이블에 데이터 한꺼번에 옮기기
INSERT INTO PROFESSOR_NEW
SELECT * FROM professor;

-- 새로 만들어진 테이블 Professor_new 데이터를 삽입 테스트
INSERT INTO professor(profno, name, id, POSITION, pay, hiredate)
VALUES (4008, 'Tom Cruise', 'Cruise', 'instructor', 300, '2025-03-14');


-- PROFESSOR_NEW에는 PK가 없기 때문에 같은 값이 들어감 !!(unique 제약조건이 없음 !!)
INSERT INTO professor (profno, name, id, POSITION, pay, hiredate)
VALUES (4008, 'Tom Holland', 'Holland', 'instructor', 310, '2025-03-14');


-- 대량의 데이터 삽입 !! - Oracle 방식 !
INSERT ALL
	INTO new_table values(5, '홍길평', '810205-1825687', '1981-02-05' ,5000)
	INTO new_table values(6, '홍길똥', '810205-1825687', '1981-02-05' ,5000)
	INTO new_table values(7, '홍길군', '810205-1825687', '1981-02-05' ,5000)
	INTO new_table values(8, '홍길치', '810205-1825687', '1981-02-05' ,5000)
	INTO new_table values(9, '홍길차', '810205-1825687', '1981-02-05' ,5000)
SELECT * FROM dual;	

SELECT * FROM new_table;
