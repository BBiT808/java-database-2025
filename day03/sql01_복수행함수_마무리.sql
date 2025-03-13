-- 쿼리는 많이 만들어 놓을 수록 유리하대~~ 참고하자 !!
-- 20250313 sql 3번째 수업!!!! 총 28번째 수업!! 허걱~~!

/*
 * 복수행 함수 마무리 !
 * cf) 서버는 24/7 365 꺼진 적이 없대... 정말 대단해 ~!
 * */

-- GROUP BY
-- 그룹핑 시 GROUP BY에 들어가는 컬럼만 SELECT 절에 사용 가능 !!!
SELECT *
  FROM employees
 GROUP BY department_id;
-- >> 실행 안 됨 !!

-- WHERE 절은 일반적 조건만 비교, HAVING 집계함수를 조건에 사용할 때 !
-- 그룹핑 시 SELECT 절에 함수는 쓸 수 있다~
-- 쓸 때 순서 1) SELECT 2) FROM 3) GROUP BY 쓰고 SELCET에 컬럼 올리고 함수 넣고 4) WHERE 5) HAVING
SELECT department_id
	 , sum(salary)
  FROM employees
 WHERE department_id <= 70
 GROUP BY department_id
HAVING sum(salary) <= 20000
 ORDER BY 2 ASC;

-- RANK() 1, 2, 2, 4, 5 순
-- DENSE_RANK() 1, 2, 2, 3 순
-- ROW_NUMBER() 행번호

-- 전체 employees 에서 급여가 높은 사람부터 순위를 매길 때
SELECT first_name || ' ' || last_name AS "full_name"
	 , department_id
	 , salary
	 , rank() OVER (ORDER BY salary desc) AS "RANK"
	 , dense_rank() OVER (ORDER BY salary desc) AS "DENSE_RANK" -- 일상에서는 DENSE_RANK를 더 많이 씀 !
	 , row_number() OVER (ORDER BY salary desc) AS "ROW_NUM"
  FROM employees
 WHERE salary IS NOT NULL;
 --ORDER BY salary DESC;

-- 부서별(department_id), 급여 높은 사람부터 랭킹을 매길 때
SELECT first_name || ' ' || last_name AS "full_name"
	 , department_id
	 , salary
	 , rank() OVER (PARTITION BY department_id ORDER BY salary desc) AS "RANK"
	    -- partition by를 이용해 department_id만으로 순서 매길 수 있음 !
	 , dense_rank() OVER (ORDER BY salary desc) AS "DENSE_RANK" -- 일상에서는 DENSE_RANK를 더 많이 씀 !
	 , row_number() OVER (ORDER BY salary desc) AS "ROW_NUM"  --PARTITION BY 잘 사용 안 함 !
  FROM employees
 WHERE salary IS NOT NULL
 ORDER BY department_id;