
-- 사원번호 입력으로 급여를 인상하는 프로시저
--SELECT * FROM WHERE empno = 7900;
	--c_empno		emp.empno%TYPE;
	--count		number(1,0);
--EXCEPTION

CREATE OR REPLACE PROCEDURE up_sal
(
	v_empno		emp.empno%TYPE
)
IS
	cnt_emp		number(1,0);
BEGIN
	SELECT count(*) INTO cnt_emp
	  FROM emp
	 WHERE empno = v_empno;

	IF cnt_emp > 0 THEN
		DBMS_OUTPUT.PUT_LINE('업데이트 하면 된대~');
	ELSE
		DBMS_OUTPUT.PUT_LINE('데이터 없음 !!');
	END IF;
END;
/

-- 실행은 같은 sql문에 넣으면 안 된대!!!!


CREATE OR REPLACE PROCEDURE SAMPLEUSER.UP_SAL
(
	v_empno		emp.empno%TYPE
)
IS
	cnt_emp		number(1,0);
BEGIN
	SELECT count(*) INTO cnt_emp
	  FROM emp
	 WHERE empno = v_empno;

	IF cnt_emp > 0 THEN
		UPDATE emp SET
			sal = sal + (sal * 0.1)
		 WHERE empno = v_empno;
	
		DBMS_OUTPUT.PUT_LINE('업데이트 성공');
	ELSE
		DBMS_OUTPUT.PUT_LINE('업데이트 불가');
	END IF;
END UP_SAL;

-- procedure에서 우클릭으로 새로운 프로시저를 만들어서 내용을 적자 !!!

--
COMMIT;