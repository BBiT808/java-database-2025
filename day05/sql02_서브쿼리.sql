/*
 * 서브쿼리 
 * 
 * */

SELECT * FROM student;

SELECT * FROM department;


-- join으로 두 테이블을 합쳐서 검색 !!
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.DEPTNO1 = d.deptno
   AND s.deptno1 = 103;    -- 조인과 학과 번호를 이용해서 도출한 값 !! ; 103은 고정된 값
   
-- Anthony Hopkins 학생과 같은 학과에 다니는 학생을 모두 조회
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.DEPTNO1 = d.deptno
   AND s.deptno1 = (SELECT deptno1 
  					  FROM STUDENT  
 					 WHERE name = 'Anthony Hopkins');  -- 학생의 이름에 따라 학과 번호를 변경할 수 있다 ! (서브쿼리)

 					 
-- WHERE절 서브쿼리에서 '='로 비교할 때 주의할 점 !!
  -- WHERE절 서브쿼리는 다중행이 되면 안 됨 !! (more than one row XX)
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.DEPTNO1 = d.deptno
   AND s.deptno1 = (SELECT deptno1 
  					  FROM STUDENT);

-- 특정 교수의 입사일보다 뒤에 입사한 교수들의 정보 출력
SELECT *
  FROM professor;

SELECT *
  FROM department;

--
SELECT * 
  FROM professor
 WHERE name = 'Meg Ryan';


-- 단일행 서브쿼리 [= <> > >= < <=] ; 비교연산자 사용
-- JOIN 후 원하는 값 도출하기
SELECT p.name AS "PROF_NAME"
	 , p.HIREDATE
	 , d.dname AS "DEPT_NAME"
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND p.hiredate > (SELECT hiredate 
  					   FROM professor
 					  WHERE name = 'Meg Ryan');

-- 스칼라값 (서브쿼리가 될 수 있다 !!)
SELECT hiredate
  FROM PROFESSOR
 WHERE name = 'Meg Ryan';  
 

 --
 COMMIT;
 
 
 -- 다중행 서브쿼리
   -- IN 서브쿼리 결과와 같은 값. 여러 개(OR과 동일 !!)
   -- EXISTS 서브쿼리의 값이 있는 경우 메인쿼리를 수행
   -- >ANY 서브쿼리의 최소값보다 큰 값을 조회
   -- <ANY 서브쿼리의 최대값보다 작은 값을 조회
   -- >ALL 서브쿼리의 최대값보다 큰 값을 조회
   -- <ALL 서브쿼리의 최소값보다 작은 값을 조회
     -- ; 실무에서는 잘 안 쓴대 !!! 서브쿼리에서 미리 걸러서 작업하나봐~
 
 -- 지역이 Pohang Main Office인 부서코드에 해당하는 직원들의 사번, 이름, 부서번호를 출력하시오
 SELECT dcode
   FROM dept2
  WHERE area = 'Pohang Main Office';
 
 
 -- 서브쿼리에 다중행이 들어가면 출력 안 됨 !! 그러나 *IN*을 쓰면 출력 가능 !!!!
 SELECT empno, name, deptno
   FROM emp2
  WHERE DEPTNO IN( SELECT dcode
   					 FROM dept2
  					WHERE area = 'Pohang Main Office');
 
 -- emp2 테이블에서 'Section head' 직급의 최소 연봉보다 연봉이 높은 사람의 이름. 직급, 연봉을 출력하시오.
    -- 단, 연봉은 $75,000,000 식으로 출력할 것
 DELETE FROM EMP2
   WHERE empno = '20000220';
 
 COMMIT;
 
SELECT *
  FROM emp2
 WHERE exists(SELECT MIN(pay)
  				FROM emp2
 				WHERE POSITION = 'Section head');  -- *과 별 차이가 없다.

-- 서브쿼리 Min함수 최소값 스칼라에서 비교연산으로..
SELECT name, POSITION, pay
	 , '$' || to_char(pay,'999,999,999') AS "SALARY"   -- 숫자의 크기가 클수록 9를 많이 붙여서 설정해주자 !
  FROM emp2
 WHERE pay > (SELECT MIN(pay)
  				FROM emp2
 				WHERE POSITION = 'Section head');

SELECT *
  FROM emp2
 WHERE POSITION = 'Section head';

-- CF) >ANY로 서브쿼리 다중행에서 최소값
SELECT name, POSITION
	 , to_char(pay,'$999,999,999') AS "SALARY_ANY"
  FROM emp2
 WHERE pay >ANY (SELECT pay
  				   FROM emp2
 				  WHERE POSITION = 'Section head');

SELECT name, POSITION
	 , to_char(pay,'$999,999,999') AS "SALARY_ANY"
  FROM emp2
 WHERE pay >all (SELECT pay
  				   FROM emp2
 				  WHERE POSITION = 'Section head');


-- 다중 컬럼 서브쿼리, 파이썬 튜플과 동일 (튜플은 처음에 없었대~)
  -- 1~4학년 중 몸무게가 가장 많이 나가는 학생의 정보를 출력하라(4행).
SELECT *
  FROM STUDENT
 WHERE (grade,weight) IN(SELECT grade, max(weight)
   						  FROM student 
  						 GROUP BY grade);
 
 SELECT grade, max(weight)
   FROM student 
  GROUP BY grade;
 
 -- 교수professor 테이블과 학과department 테이블의 조회하여 학과별로 입사일이 가장 오래된 교수의
 -- 교수번호, 이름, 학과명을 출력하시오. 입사일 순으로 오름차순. 교재 p436
 
 -- 서브쿼리 준비
 SELECT deptno, min(hiredate)
   FROM professor
  WHERE deptno IS NOT NULL
  GROUP BY deptno; -- GROUP BY를 쓰면 그 항 밖에 볼 수 없음 !! (아마도)
  
-- 전체 조건 설정
  -- 맨 먼저 테이블을 JOIN해주고 하면 편하다!
SELECT p.profno AS "교수번호"
	 , p.name AS "교수명"
	 , d.dname AS "학과명"
	 , TO_char(p.hiredate, 'YYYY-MM-DD') AS "입사일"
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND (p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
   									FROM professor
  								   WHERE deptno IS NOT NULL
  								   GROUP BY deptno)
  ORDER BY p.hiredate ASC;
-- 영역을 드래그 하고 컨트롤 엔터를 누르면 영역 지정된 것만 결과를 볼 수 있음 !!


-- cf)
SELECT p.profno, p.name, d.dname
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND (p.deptno, p.hiredate) IN  (SELECT deptno, min(hiredate)
   									 FROM professor
  									WHERE deptno IS NOT NULL
  									GROUP BY deptno);
--
COMMIT;


-- 상호연관 쿼리 ; 메인쿼리의 컬럼이 서브쿼리의 조건에 들어가는 경우
  -- 전체 20명의 평균 연봉
SELECT AVG(b.pay)
  FROM emp2 b

  -- 각 직급별 평균 연봉
SELECT b.POSITION, AVG(b.pay)
  FROM emp2 b
 GROUP BY b.POSITION;

-- 상호연관 쿼리를 서브쿼리로 설정한 결과값 ; 상호연관쿼리가 자체 내에서 그룹핑을 해준다!
  -- 서브쿼리가 실행되지 않음 !! ; a값은 바깥에 있기 때문에 
SELECT a.name, a.POSITION, a.pay
  FROM emp2 a
 WHERE  a.pay >= (SELECT AVG(b.pay)
  					FROM emp2 b
  				   WHERE b.POSITION = a.position);

-- cf) ANY를 이용한 결과값 ; 포기. 넘 복잡하시대~
/*SELECT a.name, a.POSITION, a.pay
  FROM emp2 a

SELECT name, POSITION, pay
  FROM EMP2
 WHERE (POSITION, pay) >ANY(SELECT b.POSITION, AVG(b.pay)
  							  FROM emp2 b
 							 WHERE b.POSITION IS NOT NULL
 							 GROUP BY b.POSITION);*/

--------------------------- 여기까지가 WHERE절 서브쿼리 ------------------------------


-- 스칼라 서브쿼리, SELECT절 서브쿼리
  -- 부서명을 같이 보려면 JOIN을 해야 함.
SELECT *
  FROM emp2 e;

-- JOIN을 해서 한 번에 처리함 !!
  -- JOIN은 건 수가 몇 십만건 이라도 한 번만 수행한다 !
SELECT e.empno, e.name, e.deptno, d.dname AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode;

-- JOIN 없이 스칼라 서브쿼리로 해결 ; 위와 결과가 동일 !!
  -- JOIN이 되는 값을 서브쿼리로 쓰면 성능에 악영향을 미친대 !! ; 스칼라 서브쿼리는 WHERE 검색을 몇 십만건 수행 !
	-- 개수가 많아질 수록 느려짐
SELECT e.empno, e.name, e.deptno
	,(SELECT dname FROM dept2 WHERE dcode = e.deptno) AS "부서명" -- SELECT * 쓸 수 없다!!!(주의)
	,(SELECT area FROM dept2 WHERE dcode = e.deptno) AS "지역" 
  FROM emp2 e;

--
COMMIT;

----------------------------------- 여기까지 스칼라(SELECT절) 서브쿼리 ---------------------------------------


-- from절 서브쿼리
SELECT *
  FROM emp2;

SELECT e.empno, e.name, e.birthday, e.deptno, e.emp_type, e.tel
  FROM emp2 e;


-- FROM절에 소괄호 내에 서브쿼리를 작성하는 방식 !!
SELECT es.empno, es.name
  FROM (SELECT empno, name, birthday
  			, deptno, emp_type, tel
  		FROM emp2) es  -- 마치 하나의 테이블처럼 사용할 수 있다 !!
  		
  -- FROM절 서브쿼리 작성  		
SELECT deptno, sum(pay)
  FROM EMP2
 GROUP BY deptno;

  -- 최종
    -- 전체 합계
SELECT grpP.deptno, grpP.paysum
  FROM (SELECT deptno, sum(pay) AS paysum
  		  FROM EMP2
 		 GROUP BY deptno) grpP;
    -- 전체 평균
SELECT grpP.deptno, grpP.payAvg
  FROM (SELECT deptno, sum(pay) AS payAvg
  		  FROM EMP2
 		 GROUP BY deptno) grpP;

-- emp2와 위에서 구한 값을 JOIN해서 평균 연봉보다 얼마씩 차이가 나는지 확인
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g.payAvg
	, (e.pay - g.PAYAVG) AS "평균연봉차액"
  FROM emp2 e, (SELECT deptno, avg(pay) AS payAvg
  				  FROM emp2
  				 GROUP BY deptno) g  --g는 가상테이블 !!
 WHERE e.deptno = g.deptno;

--
COMMIT;

-- WITH절로 가상테이블 형태 서브쿼리
WITH g1 AS 
	(SELECT deptno, avg(pay) AS payAvg
			  FROM emp2
			 GROUP BY deptno
			 )
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g1.payavg
	 ,(e.pay - g1.payavg) AS "평균연봉차액"
  FROM emp2 e, g1
 WHERE e.deptno=g1.deptno;
   -- cf) 둘 다 결과에는 차이가 없음 !!

-- WHERE절 서브쿼리 > FROM절 서브쿼리 > SELECT절 서브쿼리(사용자정의함수로 대체)

-- 서브쿼리 사용시 NULL값 처리
INSERT INTO emp2 (empno, name, birthday,deptno, emp_type, tel)
VALUES (20200219, 'Ray Osmond', '1988-03-22', 999,'Intern', '02)909-2345');
COMMIT;

SELECT * FROM emp2;

-- 각 직원의 부서명을 함께 출력하라.
  -- NULL은 출력하지 않는 게 좋다 !!
SELECT name, deptno, nvl((SELECT dname FROM dept2 WHERE dcode=emp2.deptno), '부서명 없음') AS "부서명"
  FROM emp2;

-- 위의 쿼리를 JOIN으로 변경가능!
  -- 위와 아래는 결과값에 차이가 거의 없다! (순서를 조금 다를 수도 있음~)
SELECT e.name, e.deptno, nvl(d.dname, '부서명 없음') AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode(+)
 ORDER BY deptno, name;

COMMIT;