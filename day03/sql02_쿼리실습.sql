--
SELECT * FROM emp;

SELECT empno, ename
FROM emp;

SELECT profno AS "Prof's No"
	 , name AS "Prof's NAME"
	 , pay AS "Prof's Pay"
  FROM professor;

SELECT deptno
  FROM emp;

SELECT DISTINCT deptno
  FROM emp ;

SELECT ename 
	 , job
  FROM emp ;

SELECT ename ||' ''s job is ' ||  job AS "NAME AND JOB"
  FROM emp ;

SELECT name ||'''s ID : '|| Id ||' , '||'WEIGHT is ' ||weight||'kg' AS "ID AND WEIGHT"
  FROM student;

SELECT ename || '('|| job||')'||', '|| ename||''''||job||'''' AS "NAME AND JOB"
  FROM emp;

SELECT ename ||'''s sal is $'||sal AS "Name And Sal"
  FROM emp;

SELECT empno, ename
  FROM emp
 WHERE empno=7900;

SELECT ename, sal
  FROM emp	
 WHERE sal < 900;

SELECT empno, ename, sal
  FROM emp
 WHERE ename = 'SMITH';

SELECT ename, hiredate
  FROM emp
 WHERE ename = 'SMITH';
 
 SELECT empno, ename, hiredate
  FROM emp
 WHERE hiredate = '1980-12-17';
 
 SELECT ename, sal, sal+100, sal*1.1
   FROM emp
  WHERE deptno = 10;
 
 SELECT empno, ename,sal 
   FROM emp
  WHERE sal >= 4000;
 
 SELECT empno, ename, sal
   FROM emp
  WHERE ename >= 'W';
 
 SELECT ename, hiredate
   FROM emp
  WHERE hiredate >= '81-12-25'

SELECT empno, ename, sal
  FROM emp 
 WHERE sal BETWEEN 2000 AND 3000;

SELECT empno, ename, sal
  FROM EMP
 WHERE sal >= 2000
   AND sal <= 3000;

SELECT ename
  FROM EMP
 WHERE ename BETWEEN 'JAMES' AND 'MARTIN' 
 ORDER BY ename;

SELECT empno, ename, deptno