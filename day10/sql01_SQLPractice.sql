
--20250324 sql 10번째 수업!!!! 오늘 코딩테스트 한대 !!!!
 -- 아침엔 연습문제 같이 풀기 !!!

--
COMMIT;

/*
 * 기본 SELECT문
 * */

-- Q1. Employees 테이블에서 사원번호, 이름(이름 성 합쳐서 표시), 급여, 업무, 입사일, 상사의 사원번호로 출력하시오. (107행)
SELECT employee_Id
	 , First_name || ' ' || last_name AS FULL_name
	 , salary
	 , job_id
	 , TO_char(hire_date, 'YYYY-MM-DD') AS hire_date
	 , manager_id
  FROM employees;

-- Q2. Employees 테이블에서 모든 사원의 이름(last_name)과 연봉을 '이름 : 1 year salary = $ 연봉' 형식으로
-- 	   출력하고, 컬럼명의 1 Year Salary로 변경하시오. (107행)  ; 행이 기본 테이블의 행과 같을 경우, Where절은 굳이 쓰지 않아도 된다는 뜻이다 !
SELECT last_name || ': 1 Year salary = ' || TO_char(salary * 12, '$999,999.99') AS "1 Year salary"
  FROM employees;

-- Q3. 부서별로 담당하는 업무를 한 번씩만 출력하시오. (20행)
SELECT DISTINCT department_id, job_id  -- ALL/*/DISTINCT 문법과 용법 알아두기 !!
  FROM employees;


/*
 * WHERE절, ORDER BY절
 * */

-- Q4. employees에서 급여가 7000~10000달러 범위인 사람의 이름과 성을 full_name, 급여를 오름차순으로 출력하시오. (75행)
SELECT *
  FROM employees
 WHERE salary < 7000 
   OR salary > 10000;

SELECT first_name || ' ' || last_name AS "full_name"
	 , salary
  FROM EMPLOYEEs
 WHERE salary NOT BETWEEN 7000 AND 10000
 ORDER BY salary ASC ;

-- Q5. 현재 날짜 타입을 날짜 함수를 통해서 확인하고,
-- 입사일자가 2005년 5월 20일부터 2006년 5월 20일 사이에 입사한 사원의 이름(full_name), 사원번호, 고용일자를 출력하시오.
-- 단, 입사일을 빠른 순으로 정렬하시오. (10행)
SELECT sysdate FROM dual;

SELECT first_name || '  ' || last_name AS full_name
	 , employee_id
	 , to_char(hire_date, 'yyyy-mm-dd') AS hire_date
  FROM EMPLOYEES
 WHERE hire_date BETWEEN '2003-05-20' AND '2004-05-20'
 ORDER BY hire_date ASC;

/*
 * 단일행 함수와 변환 함수
 * 
 * */

-- Q6. 이번 분기, 60번 IT 부서가 지대한 공헌을 했음.
-- IT부서 사원 급여를 15.3% 인상하기로 했다. 정수만 반올림.
-- 출력형식은 사번, 이름과 성(full_name), 급여, 인상된 급여(컬럼명 Increased Salary) 출력 (5행)
SELECT EMPLOYEE_ID
	 , first_name || ' ' || last_name AS full_name
	 , salary
	 , salary + (salary * 0.153) AS "Increased salary(참조)" -- 실제 시험 답변에도 주석 써도 된다 !!
	 , round(salary * 1.153) AS "Increased salary "
  FROM employees
 WHERE job_id = 'IT_PROG';

-- Q7. 모든 사원의 연봉을 표시하는 보고서 작성.
-- 사원 full_name, 급여, 수당여부에 따라 연봉을 표시하시오.
-- 수당이 있으면 salary + commission, 없으면 salary only라고 표시. 연봉이 높은 순으로 정렬 (107행)
SELECT first_name || ' ' || last_name AS full_name
	 , salary
	 , (salary * 12) + (salary * NVL(commission_pct,0)) AS "Annual Salary"
	 , CASE WHEN commission_pct IS NULL THEN 'salary only'
	 		WHEN commission_pct IS NOT NULL THEN 'salary + commission'
	 		END AS "Commission?"
  FROM employees
 ORDER BY 3 DESC; -- "Annual Salary"보다 컬럼 순서인 3을 적는게 훨씬 효율적 !!
 
 /*
  * 
  * 집계함수, MIN, MAX, SUM, AVG, COUNT ...
  * GROUP BY와 같이 사용
  * */
 
 -- Q8. employees에서 각 사원이 소속된 부서별 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하시오.
 -- 출력형식은 여섯자리와 세자리 구분 기호, $를 앞에 표시할 것. 부서번호의 오름차순으로 정렬.
 -- 단, 부서에 소속되지 않은 사원은 제외 (11행)
 
 SELECT department_id
 	  , TO_char(sum(salary), '$999,999') AS "Sum Salary"
 	  , to_char(avg(salary), '$999,999.9') AS "Avg Salary"
 	  , to_char(max(salary), '$999,999') AS "Max Salary"
 	  , to_char(min(salary), '$99,999') AS "Min Salary"
  FROM employees
 WHERE department_id IS NOT NULL 
  GROUP BY department_Id
 ORDER BY department_id ASC;
 
 /*
  * JOIN,
  * */
 
 -- Q9. employees, department, locations 테이블 구조 파악
 -- Oxford에 근문하는 사원 full_name, 업무, 부서명, 도시명을 출력하시오 (34행)
 SELECT e.first_name || '  ' || e.LAST_name AS "full+_name"
 	  , e.JOB_ID
 	  -- e.department_Id
 	  , d.DEPARTMENT_NAME 
 	  , l.city
   FROM employees e, departments d, locations l 
  WHERE e.department_id= d.department_id
    AND d.location_id = l.location_id
    AND l.city = 'Oxford';
 
 
-- Q10. 부서가 없는 직원까지 모두 full_name, 업무, 부서명을 출력하시오. (107행)
-- LEFT OUTER JOIN
 SELECT e.first_name || '  ' || e.LAST_name AS "full+_name"
 	  , e.job_id
 	  , d.department_name
  FROM employees e, departments d
 WHERE e.DEPARTMENT_ID   = d.DEPARTMENT_ID(+);


/*
 * 서브 쿼리
 * */

-- Q11. Tucker 사원보다 급여를 많이 받는 사원의 full_name, 업무, 급여를 출력하시오. (15행)
SELECT salary
  FROM EMPLOYEES
 WHERE last_name = 'Tucker';

SELECT first_name || ' ' || last_name AS full_name
	 , job_id
	 , salary
  FROM EMPLOYEES
 WHERE salary > (SELECT salary
 				   FROM EMPLOYEES
 				  WHERE last_name = 'Tucker');

-- Q12. 부서와 업무별 급여 합계를 구하여서 급여수준 레벨을 지정하고자 함.
-- 부서별, 업무별 급여합계 및 각 부서별 총합, 각 부서별, 업무별 직원수를 출력하시오. 
SELECT department_id, job_id  -- GROUP BY 에 들어가는 컬럼 외에는 절대 들어가면 안 됨 !!
	 , to_char(sum(salary), '$99,999') AS "SUM Salary"
 	 , count(*) AS "Employees cnt"
  FROM employees
 GROUP BY ROLLUP(department_id, job_id) ;

--
COMMIT;

--------------------------------------------------------------

/*
 * 연습
 * */

-- 교재 p210 연습문제 !!

-- emp 테이블을 사용하여 사원중에서 급여(sal)와 보너스(comm)를 합친 금액이 가장 많은 경우와 가장 적은 경우, 평균 금액을 구하세요.
-- 단, 보너스가 없을 경우는 보너스를 0으로 계산하고 출력 금액은 모두 소수점 첫째자리까지만 나오게 하세요.
SELECT max(salary + salary * commission_pct) AS MAX
	 , min(salary + salary * commission_pct) AS MIN
	 , round(avg(salary + salary * COMMISSION_PCT),1) AS AVG
  FROM employees;