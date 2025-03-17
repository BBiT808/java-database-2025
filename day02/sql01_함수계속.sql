-- 20250312 27번째 수업!!! 그리고 sql 수업 2번째 !!!

SELECT concat('Hello', ' Oracle')   -- 한 행에 한 열만 출력되는 값을 스칼라(Scalar)값이라 부름 !!
  FROM dual;

-- SUBSTR(변환할 값, 인덱스, 길이)  -- 파이썬 substring 함수와 동일. ** 많이 씀!!!
-- DB의 인덱스는 1부터 시작한다 !!! (일반 프로그래밍 언어는 0부터 시작함 !)
-- (-인덱스) : 뒤에서부터 위치
SELECT substr(email, 1, 2)
	 , substr(email, -2, 2)
	 , email
  FROM employees;

-- 전화번호 자를 때, 주민번호 자를 때 SUBSTR() 활용 cf) SUBSTRB() ; 잘못하면 글자가 잘림 ~

-- INSTR(체크할 문자열, 찾는 글자, 시작 위치, 몇 번째)
SELECT '010-9999-8888'
	 , instr('010-9999-8888', '-', 1, 1)
	 , instr('010-9999-8888', '-', 5, 1)
  FROM dual;

-- LPAD(문자열, 자리수, 채울 문자), RPAD(문자열, 자리수, 채울 문자)
-- 자리열을 맞추는 데 특화되어 있다 !!
SELECT LPAD('100', 7, '0')  -- 많이 쓴다 !!
	 , RPAD('ABC',7,'-')    -- 많이 안 씀 ..
  FROM dual;

-- TRIM() 함수 트리플. == 파이썬 strip() 함수와 동일 ; 자르고 정리.
-- LTRIM(), RTRIM(), TRIM()
SELECT '<<<' || '     Hello Oracle     ' || '>>>'
	 , '<<<' || ltrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || rtrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || trim('     Hello Oracle     ') || '>>>'  -- ** 많이 씀 !! 
  FROM dual;

-- REPLACE(), 파이썬에도 동일하게 존재
SELECT phone_number
	 , REPLACE(phone_number, '123', '786')  -- ** 많이 씀 !!
  FROM employees;

/*
 * 숫자함수, 집계함수와 같이 사용 많이 됨 !!
 * */

-- ROUND() 반올림 함수 ; 파이썬 존재
-- CEIL() 올림함수 / FLOOR() 내림함수 / TRUNC() 내림함수 소수점
-- MOD() 나누기 나머지값 ; 파이썬의 mode(), % 연산과 동일
-- POWER() 파이썬 math.pow(), power(), 2^10 승수 계산 동일 !

SELECT 786.5427 AS res1
	 , round(786.5427) AS round0      -- 소수점 없음
	 , round(786.5427, 1) AS round0   -- 소수점 첫째 자리
	 , round(786.5427, 2) AS round0   -- 소수점 둘째 자리
	 , ceil(786.5427) AS ceilRes 
	 , floor(786.5427) AS floorREs
	 , trunc(786.5427, 3) AS truncRes
	 , mod(10, 3) AS "나머지"
	 , power(2, 10) AS "2의 10승"
  FROM dual;

/*
 * 날짜함수, 나라마다 표현방식 다름
 * 
 * 2025-03-12 아시아 ... 
 * March/12/2025 미국, 캐나다 ...
 * 12/March/2025 유럽, 인도, 베트남 ...
 * 포맷팅을 많이 함 ! 
 * 
 * */

-- 오늘 날짜
SELECT sysdate  AS 오늘 -- 그리니치 표준시간(GMT)을 따름 (우리나라와 9시간 차이 !!; GMT+09)
	-- 날짜 포맷팅 사용되는 YY, YYYY, MM, DD, DAY 년월일
	-- AM/PM, HH, HH24, MI, SS, W, Q(분기)
	 , TO_CHAR(sysdate, 'YYYY-MM-DD') AS 날짜 
	 , TO_CHAR(sysdate, 'AM/PM HH24:MI:SS') AS 시간
	 , TO_CHAR(sysdate, 'MON/DD/YYYY') AS 미국식
	 , TO_CHAR(sysdate, 'DD/MON/YYYY') AS 영국식
  FROM dual;

-- ADD_MONTHS() 월을 추가해주는 함수 !!
SELECT hire_date
	-- 항상 원본 데이터를 남겨두자 !! 그래야 알아보기 쉽다~
	 , to_char(hire_date, 'yyyy-mm-dd') AS 입사_일자 
	 , add_months(hire_date,3) AS 정규직_일자
	 , next_day(hire_date , '월') AS 돌아오는_월요일 -- 'MON' == '월'
	 , last_day('2025-02-01') AS 달_마지막_날
  FROM employees;

-- GMT + 9
-- 인터벌 숫자 뒤 HOUR, DAY, MONTH, YEAR
SELECT to_char(sysdate + INTERVAL '9' HOUR, 'YYYY-MM-DD HH24:MI:SS') AS seoul_time
	 , to_char(sysdate + INTERVAL '9' YEAR, 'YYYY-MM-DD HH24:MI:SS') AS future_time
  FROM dual;

/*
 * 형 변환 함수
 * 
 * */

-- TO_CHAR() : 숫자형을 문자형으로 변경
SELECT 12345 AS 원본
	 , to_char(12345, '9999999') AS "원본+두자리"
	 , to_char(12345, '0999999') AS "원본+두자리0"
	 , to_char(12345, '$999999') AS "통화단위+원본"
	 , to_char(12345, '99999.99') AS 소수점
	 , to_char(12345, '99,999') AS "천 단위 쉼표"   -- **진짜 많이 씀 !! ; 자리수만큼 9를 써줘야 적용됨 !!
  FROM dual;

-- TO_NUMBER() 문자형된 데이터를 숫자로
SELECT '5.0' * 5  AS 계산 -- 오라클은 문자 숫자 계산도 되네 ?!
	 , to_number('5.0') AS 숫자형변환
--   , to_number('Hello') : 숫자로 변경할 수 없는 형태 !!!
  FROM dual;

-- TO_DATE() 날짜 형태를 문자형으로
SELECT '2025-03-12'
	 , to_date('2025-03-12')  + 10 AS 날짜계산  -- 날짜형으로 바꾸면 연산가능 !!
  FROM dual;


/*
 * 일반함수
 * */

-- NVL(컬럼|데이터, 바꿀 값) 널(NULL)값을 다른 값으로 치환 !!
SELECT commission_pct
	 , nvl(commission_pct, 0.0)
  FROM employees;

SELECT nvl(hire_date, 'sysdate') -- 입사 일자가 비어있으면 오늘 날짜로 대체 ; 지금은 안 돼 !!
  FROM employees;

SELECT commission_pct
	 , salary
	 , nvl2(commission_pct, salary + (salary * commission_pct), salary) AS 커미션급여
  FROM employees;

-- DECODE(A, B, '1', '2') A가 B일 경우 1 아니면 2 !
  -- 오라클만 있는 특징적인 함수 ~
SELECT email, phone_number, job_id
	 , DECODE(job_id, 'IT_PROG', '개발자 만쉐이!!', '나머지는.. 나머지.') AS 캐치프레이즈
  FROM employees
 --WHERE job_id = 'IT_PROG';
  
/*
 * CASE 구문, 정말 중요!!
 * if, elif의 중복된 구문과 유사 
 * */
  
SELECT CASE job_id WHEN 'AD_PRES' THEN '사장'
				   WHEN 'AD_VP' THEN '부사장'
				   WHEN 'IT_PROG' THEN '프로그래머'
				   WHEN 'SA_MAN'    THEN '영업사원'
				   ELSE '미분류'
		 END AS 직급
	 , employee_id
	 , job_id  
  FROM employees;
  
/*
 * 정규식(Requla Expression) : 문자열 패턴을 가지고, 동일한 패턴 데이터 추출 사용
 * 
 * ^, $, \., *, [], [^] 패턴인식할 때 필요한 키워드.
 * 
 * */


SELECT *
  FROM employees
 WHERE phone_number LIKE '%.%.%'  -- 세자리 전화, 네자리 전화번호가 구분 안 됨 !

 
-- 전화번호가 .로 구분되는 세 자리 전화번호만 필터링 !!
 -- '[1-9]{6}-[1-9]{7}' 주민번호 정규식 패턴
SELECT *
  FROM employees
 WHERE regexp_like(phone_number, '[0-9]{3}.[0-9]{3}.[0-9]{4}');

-- first_name이 J(대문자 j)로 시작하고, 두 번째 글자가 a나 o인 사람을 출력하시오 !!
--   : like로 하면 힘들지만, 정규식으로 하면 이렇게 쉽게 가능하다 !! 
SELECT *
  FROM employees
 WHERE regexp_like(first_name, '^J(a|o)');

--
COMMIT;
 