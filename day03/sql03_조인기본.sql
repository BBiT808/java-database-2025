/*
 *  JOIN
 * 
 * */

-- 개념
-- 정규화되어 나누어지 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
  FROM employees
 WHERE department_id =20;


-- 키와 DB의 무결성 ..!!
SELECT *
  FROM departments
 WHERE department_id = 100;

SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- 총 데이터 수가 2889개 출력 (모든 경우의 수를 출력!)
-- 카테시안 곱!!
SELECT *
  FROM employees e, departments d;

-- 오라클 방식 ! 표준방식 아님. 편하게 쿼리를 작성하라고 만든 편법 !!
SELECT *
  FROM employees e, departments d    -- 그냥 이름을 쓰기에는 너무 기니까 별명으로 축약해 줌 !!
 WHERE e.department_id = d.department_id;


-- cf)ANSI 표준 문법 ; ..실무할 때는 ..쓰지.. 말자....(오라클 방식보다 복잡!!)
SELECT *
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id;


-- 필요컬럼만 명세
SELECT e.employee_id, e.first_name ||' '|| e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
  FROM employees e, departments d 
 WHERE  e.department_id = d.department_id;


SELECT e.employee_id, e.first_name ||' '|| e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
	 , l.city, l.state_province, l.street_address
  FROM employees e, departments d, locations l 
 WHERE  e.department_id = d.department_id
   AND l.location_id = d.location_id;

-- 내부조인(INNER JOIN)
SELECT e.employee_id, e.first_name ||' '|| e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.DEPARTMENT_ID
	 , d.department_name
	 , l.city, l.state_province, l.street_address
  FROM employees e, departments d, locations l 
 WHERE  e.department_id = d.department_id
   AND l.location_id = d.location_id
   AND d.department_id = 60;

-- 외부조인(OUTER JOIN) ; 내부조인에서 NULL 값으로 인해 나오지 않았던 값도 나올 수 있음 !!
