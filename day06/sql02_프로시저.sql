

-- PROCEDURE
-- 부서번호가 30번인 사람들의 job을 MANAGER로 변경하는 프로시저
-- SELECT * FROM emp;
CREATE OR REPLACE PROCEDURE UPDATE_30  -- 파라미터 없음~
IS
BEGIN
		UPDATE emp SET
			   job = 'MANAGER'
		 WHERE deptno = 30;
END;


-- 확인작업
SELECT * FROM emp;

COMMIT;
ROLLBACK;

-- 프로시저 실행 !
CALL UPDATE_30();