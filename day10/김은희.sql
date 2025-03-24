--sql 코딩 테스트

--
COMMIT;



--1.
SELECT email, mobile, names, addr
  FROM MEMBERTBL;



--2.
SELECT names AS 도서명
	 , author AS 저자
	 , ISBN
	 , PRICE AS 정가
  FROM bookstbl;



--3.
SELECT DISTINCT m.names AS 비대여자명
			  , m.levels AS 등급
			  , m.addr AS 주소
			  , NULL AS 대여일
  FROM RENTALTBl r, membertbl m
 WHERE m.idx NOT IN (SELECT distinct memberidx
  					   FROM rentaltbl)
 ORDER BY 비대여자명 ASC


 
--4.
SELECT *
  FROM bookstbl;

SELECT *
  FROM divtbl;

  -- 첫번째 방법
SELECT nvl(d.NAMES, '--합계--') AS 장르
	 , to_char(sum(b.price), '9,999,999') AS 총합계금액	 	
  	  FROM bookstbl b, divtbl d
 	 WHERE b.DIVISION = d.DIVISION
 	 GROUP BY ROLLUP(d.names);

  
  

  -- 두번째 방법
CREATE TABLE genre_sum
as
	SELECT d.NAMES AS 장르
	 	 , sum(b.price) AS 총합계금액
  	  FROM bookstbl b, divtbl d
 	 WHERE b.DIVISION = d.DIVISION
 	 GROUP BY d.names;

SELECT sum(총합계금액)
  FROM genre_sum;

 INSERT INTO genre_sum
 values('--합계--', 1028200)
 
 SELECT *
  FROM genre_sum;
