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

-- ANSI 표준은 오라클방식보다 복잡.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
     , e.email, e.phone_number
     , e.hire_date, e.job_id
     , d.DEPARTMENT_ID
     , d.department_name
     , l.city, l.STATE_PROVINCE, l.STREET_ADDRESS
  FROM employees e
 INNER JOIN departments d
    ON e.DEPARTMENT_ID artment_id = d.department_id
 INNER JOIN locations l
    ON l.location_id = d.location_id
 WHERE d.department_id = 60;

-- 외부조인(OUTER JOIN) ; 내부조인에서 NULL 값으로 인해 나오지 않았던 값도 나올 수 있음 !!
-- 내부조인 : 보통 PK와 FK간의 일치하는 조건의 데이터를 찾는 것
-- 외부조인 : PK와 FK간의 일치하지 않는 조건의 데이터도 찾는 것
-- 테이블 1 OUTER JOIN 테이블 2
-- 테이블 1번을 기준으로 외부조인 LEFT OUTER JOIN
-- 테이블 2번을 기준으로 외부조인 RIGHT OUTER JOIN

SELECT *
  FROM employees e
 inner JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;



-- ANSI 표준문법
-- employees테이블에는 있는데 departments테이블에는 없는 데이터를 같이 출력해줘
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;

-- departments테이블에는 있는데 employees 테이블에 없는 데이터를 같이 출력해줘
SELECT *
  FROM employees e
 RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;


-- Oracle 문법
-- (+) 만족하지 않는 조건도 더 나오게 한다는 뜻
-- LEFT OUTER JOIN
SELECT * 
  FROM employees e, departments d
 WHERE e.department_id = d.DEPARTMENT_ID(+);

--RIGHT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- INNER JOIN은 INNER를 생략가능
-- OUTER JOIN에만 LEFT, RIGHT 존재하므로 OUTER 생략가능

-- 셀프조인 : 자기자신을 두 번 사용하는 조인
SELECT e1.first_name || ' '|| e1.last_name AS "full_emp_name"
	 , e1.job_id
	 , e1.MANAGER_ID 
	 , e2.FIRSt_name || ' ' || e2.last_name AS "full_mng_name"
	 , e2.job_id
  FROM employees e1, employees e2
 WHERE e1.manager_id = e2.employee_id(+)
 ORDER BY e1.manager_id;
 
