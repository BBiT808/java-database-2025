

UPDATE MADANG.STUDENTS
	SET STD_NAME = :v_std_name
		, STD_MOBILE = :v_std_mobile
		, STD_REGYEAR =  :v_std_regyear
	WHERE STD_ID= :v_std_id
	
-- studentapp과 연결된 프로그램에서 수정했더니 수정됐음 !!!
SELECT * FROM students;

-- Delete 쿼리 만들기!!
DELETE FROM students WHERE std_id = :v_std_id

--
COMMIT;