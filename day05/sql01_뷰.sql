/*
 * 20250317 sql 다섯번째 수업 !!! 총 30번째 수업 오 마이 지저스 크라이스트
 * 
 * VIEW!!!!  (너무 아름 down down down down view)
 *   ㄴ 제 만들어진 뷰 테이블을 보세요^^
 * */

--sysdba로 실행해서 sampleuser에게 view를 생성할 수 있는 권한을 부여하기 !!
GRANT CREATE VIEW TO sampleuser;


--
SELECT * FROM emp2;


-- 뷰 생성 DDL  --권한이 없으면 만들 수 없음 !!
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, tel, POSITION, pempno, deptno
	  FROM EMP2;


-- 뷰로 select
SELECT *
  FROM V_emp2;
  
  
-- 뷰로 insert
  -- 단, 뷰에 속하지 않는 컬럼 중 NOT NULL 조건이 있으면 데이터 삽입 불가
INSERT INTO v_emp2 VALUES(20000219, 'Tom Halland', 1004, '051)627-9968', 'IT Programmer', 19960303);


 -- NOT NULL인 DEPTNO 컬럼 빼고 뷰 생성
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, tel, POSITION, pempno
	  FROM EMP2;


  -- *deptno컬럼이 not null인데 뷰에는 존재하지 않아 INSERT 불가!!*
INSERT INTO v_emp2 VALUES(20000220, 'Zen Daiya', '051)627-9968', 'IT Programmer', 19960303);


-- 뷰 삭제 (일단 보류)


-- 커밋 해주기!! (우리 자동 커밋 꺼놨으니까 직접 해줘야 함 !!)
COMMIT;


-- CRUD 중 SELECT만 가능하게 만들려면 (읽기만 가능하도록 !!)
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM EMP2
WITH READ ONLY;

-- READ ONLY에는 INSERT 불가!!
INSERT INTO v_emp2 VALUES(20000221, 'Hugo sung', 1024, '051)627-9768', 'IT Programmer', 19960303);


-- 복합 뷰 ; 조인 등으로 여러 테이블을 합쳐서 보여주는 뷰 !!
  -- 복합 뷰는 INSERT, UPDATE, DELETE가 거의 불가 !  ; 가~끔 INSERT 요소의 순서가 비슷~하면 들어갈 수도 있대!!
CREATE OR REPLACE VIEW v_emp3
AS
	SELECT e.empno, e.name, e.deptno, d.dname
	  FROM emp2 e, dept2 d
	 WHERE e.deptno = d.dcode;   -- 조인해준다는 뜻!!  ; 먼저 select문으로 조인해 준 후 조회하자~
	 
	
-- 조회
SELECT * FROM V_emp3;

-- cf) 한 행 한 열에 있는 하나의 값을 스칼라라 부른대~ 