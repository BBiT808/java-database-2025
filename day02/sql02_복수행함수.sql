/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(), SUM(), AV(ERA)G(E)(), MIN/MAX(), STDDEV(), ...
 * ROLLUP, CUBE, RANK, DENSE_RANK ...
 * */

-- COUNT() 개수 세기 !!    *** 엄청 많이 씀 !!!!
SELECT count(*)  AS 결과      -- scalar value(한줄로 나오는 값!!! 기억하자)
  FROM employees;

SELECT count(employee_id)
  FROM employees;



-- SUM(숫자형 컬럼) 합계.
-- employees 206 salary 8300 삭제
SELECT sum(salary)
  FROM employees;

-- AVG(숫자형 컬럼) 평균
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출된다 !!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
SELECT avg(salary)
  FROM employees;

SELECT count(salary)     -- null은 계산하지 않음 !! : 파이썬에 널값 들어가면 큰일나 ~
  FROM employees;

-- MIN(숫자형 칼럼|문자형도 가능 !! MAX()
SELECT max(first_name)
	 , min(salary)
	 , max(salary)
  FROM employees;

/* 
 * GROUP B 연계, 그룹화
 * GROUP BY를 사용하면 SELECT 절에는 GROUP BY 사용한 컬럼과 집계함수 및 일반함수만 사용할 수 있음 !!
 */*/
 
 -- 아래의 경우 department_id 이외의 컬럼은 사용불가
 
 
 SELECT department_id
	  , avg(salary) AS 부서별평균급여
	  , to_char(round(avg(salary) ,1), '99,999.9') AS "부서별 평균 급여"
	  , sum(salary) AS 부서별급여총액
   FROM employees 
 GROUP BY department_id
 ORDER BY avg(salary) desc;
 
 -- employees에서 부서와 직군별 급여총액과 직원수를 출력
 SELECT department_id, job_id , sum(salary) AS 부서직군별급여총액
 	  , count(*)
   FROM employees 
  GROUP BY department_id, job_id
  ORDER BY department_id;
 
 
 -- employees에서 부서와 직군별 급여총액과 직원수를 출력하는데,
 -- department_id가 30에서 90 사이이고, 부서직군별급여총액이 20000달러 이상인 데이터만 보일 것 !  
  SELECT department_id, job_id , sum(salary) AS 부서직군별급여총액
 	  , count(*)
   FROM employees 
  WHERE department_id BETWEEN 30 AND 90
--  AND sun(salary) >= 20000 : 집계 함수는 where에 사용 불가 !! 
  GROUP BY department_id, job_id
 HAVING sum(salary)>=20000
  ORDER BY department_id;
 
-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체 가능 !! 
SELECT department_id, job_id , sum(salary) AS 부서직군별급여총액
 	  , count(*)
  FROM employees 
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY department_id, job_id
HAVING sum(salary)>=20000
  ORDER BY 3 DESC;   -- 3번째 컬럼을 정렬하겠다는 의미~
  
  
SELECT department_id, job_id , sum(salary) AS 부서직군별급여총액
 	  , count(*)
  FROM employees 
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY ROLLUP (department_id, job_id);  -- oracle이 자동으로 행을 만들어준다 !!
 
-- PIVOT() 엑셀에 동일한 기능 ; oracle에만 있음 !!
--PIVOT 안 쓰고 각 달별로 입사한 사원의 수를 표시. 12행
 -- 각 입사일자에서 달만 추출
 SELECT to_char(hire_date, 'MM')
   FROM employees;

-- 입사 달별로 그룹핑
SELECT TO_char(hire_date,'MM'), count(*)
  FROM employees 
 GROUP BY to_char(hire_date, 'MM');

--1월 달에 입사한 사람 카운팅
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM');

-- 옆으로 각 달 별로 스프레드
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
	 , CASE to_char(hire_date, 'MM') WHEN '02' THEN count(*) ELSE 0 END AS "2월"
	 , CASE to_char(hire_date, 'MM') WHEN '03' THEN count(*) ELSE 0 END AS "3월"
	 , CASE to_char(hire_date, 'MM') WHEN '04' THEN count(*) ELSE 0 END AS "4월"
	 , CASE to_char(hire_date, 'MM') WHEN '05' THEN count(*) ELSE 0 END AS "5월"
	 , CASE to_char(hire_date, 'MM') WHEN '06' THEN count(*) ELSE 0 END AS "6월"
	 , CASE to_char(hire_date, 'MM') WHEN '07' THEN count(*) ELSE 0 END AS "7월"
	 , CASE to_char(hire_date, 'MM') WHEN '08' THEN count(*) ELSE 0 END AS "8월"
	 , CASE to_char(hire_date, 'MM') WHEN '09' THEN count(*) ELSE 0 END AS "9월"
	 , CASE to_char(hire_date, 'MM') WHEN '10' THEN count(*) ELSE 0 END AS "10월"
	 , CASE to_char(hire_date, 'MM') WHEN '11' THEN count(*) ELSE 0 END AS "11월"
	 , CASE to_char(hire_date, 'MM') WHEN '12' THEN count(*) ELSE 0 END AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM')
 ORDER BY to_char(hire_date, 'MM') ;


-- decode
SELECT decode(to_char(hire_date, 'MM'), '01', count(*), 0) AS "1월"
	 , decode(to_char(hire_date, 'MM'), '02', count(*), 0) AS "2월"
	 , decode(to_char(hire_date, 'MM'), '03', count(*), 0) AS "3월"
	 , decode(to_char(hire_date, 'MM'), '04', count(*), 0) AS "4월"
	 , decode(to_char(hire_date, 'MM'), '05', count(*), 0) AS "5월"
	 , decode(to_char(hire_date, 'MM'), '06', count(*), 0) AS "6월"
	 , decode(to_char(hire_date, 'MM'), '07', count(*), 0) AS "7월"
	 , decode(to_char(hire_date, 'MM'), '08', count(*), 0) AS "8월"
	 , decode(to_char(hire_date, 'MM'), '09', count(*), 0) AS "9월"
	 , decode(to_char(hire_date, 'MM'), '10', count(*), 0) AS "10월"
	 , decode(to_char(hire_date, 'MM'), '11', count(*), 0) AS "11월"
	 , decode(to_char(hire_date, 'MM'), '12', count(*), 0) AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM')
 ORDER BY to_char(hire_date, 'MM') ;

-- RANK() 등수 ; 공동 등수 이후 번호가 넘어감, DENSE_RANK() ; 등수 번호가 순차적으로 올라감
-- ROW_NUMBER() 현재 데이터 행번호 출력
SELECT employee_id, last_name, salary
	 , rank() OVER (ORDER BY salary desc) AS "랭크"
	 , dense_rank() OVER (ORDER BY salary desc) AS "덴스랭크"  -- dense는 빽빽한, 조밀한의 뜻 !! ** 많이 사용!
	 , row_number() OVER (ORDER BY salary desc) AS "행번호" 
  FROM employees; 
