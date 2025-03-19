
-- TRIGGER 학습
-- DEPT 테이블 복사 DEPT_BACKUP
CREATE TABLE DEPT_BACKUP
AS
	SELECT * FROM dept;

--dept_backup 테이블에 logt_date컬럼 추가
ALTER TABLE DEPT_BACKUP
	ADD(log_date DATE);

-- 트리거 작성
CREATE OR REPLACE TRIGGER trg_deptback
AFTER INSERT OR UPDATE OR DELETE ON dept -- dept 테이블 트리거 메뉴에 저장 확인 !!
FOR EACH ROW
BEGIN
	IF inserting THEN                   -- dept 테이블에 데이터가 추가되면
		INSERT INTO dept_backup
		VALUES (:NEW.deptno, :NEW.dname, :NEW.loc, sysdate); -- sysdate로 현재 날짜까지 넣어주기
	ELSIF updating THEN                 --dept 테이블에 데이터가 수정되면
		/*UPDATE dept_backup
			SET dname = :NEW.dname
			  , loc = :NEW.loc
			  , log_date = sysdate
		 WHERE deptno = :OLD.deptno;*/
		INSERT INTO dept_backup
		VALUES (:OLD.deptno, :NEW.dname, :NEW.loc, sysdate);
	/*ELSIF deleting THEN
		DELETE FROM dept_backup
	 	 WHERE deptno = :OLD.deptno;*/-- 원본은 남겨두는 게 좋기 때문에... 일단 주석처리 !!
	END IF;
END;

--
COMMIT ;

-- 원본 확인
SELECT * FROM dept;

-- 백업 테이블 확인
SELECT * FROM dept_backup;  -- log만 남겨주는 것 !!! 내가 dept 테이블에 뭘 했는지 확인할 수 있게 함 !!

-- 삽입
INSERT INTO dept VALUES (50, 'R&D', 'SEOUL');

-- 수정 : BOSTON에서 LOS ANDGELES로 변경.   ; 백업!!!!!
UPDATE dept SET
	   loc = 'LOS ANGELES'
 WHERE deptno = 40;

--
ROLLBACK;
COMMIT;