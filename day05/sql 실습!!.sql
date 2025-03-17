/*
 * 
 * 문제 실습!!!!
 * Ctrl + ] 하면 새로운 sql 만들 수 있음~ 기억해 두기!!
 * 
 */

-- 연습문제 교재 p420쪽 View 생성 !!
-- Q1
SELECT *
  FROM professor;

SELECT * 
  FROM department;

SELECT p.profno, p.name, d.dname
  FROM professor p, department d
 WHERE p.deptno = d.deptno;


CREATE OR REPLACE VIEW v_prof_dept2
AS
	SELECT p.profno, p.name, d.dname
	  FROM professor p, department d
	 WHERE p.deptno = d.deptno;

SELECT * FROM v_prof_dept2

--Q2
SELECT * FROM student;
SELECT * FROM department;

SELECT d.DNAME, s.MAX_HEIGHT, s.MAX_WEIGHT
  from(SELECT deptno1, Max(height) AS MAX_HEIGHT
  	 		 ,max(weight) AS MAX_WEIGHT
  	 	 FROM STUDENT
  	 	 GROUP BY deptno1) s, department d
 WHERE s.DEPTNO1 = d.DEPTNO;
  	 		 
--Q3
SELECT d.dname, s.max_height, s.name, s.max_height AS height
  FROM (SELECT name, 
  			 , max(height) AS max_height
   		  FROM student
   		  GROUP by name) s, department d
 WHERE s.deptno1 =d.deptno;