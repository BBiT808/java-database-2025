/* 내장함수
 * 
 * */

/* 문자(열) 함수 */

-- INITCAP() : 단어의 첫글자를 대문자로 바꿔주겠다.
SELECT initcap('hello oracle')  AS "result"
  FROM dual; -- 실재하지 않는 가상의 테이블(Oracle만!)
  
-- LOWER() : 모든 글자 소문자, UPPER() : 모든 글자 대문자
SELECT lower(first_name) AS "first_name"  --AS를 붙이지 않으면 함수가 테이블의 컬럼이 된다!
	 , upper(last_name) AS "last_name"
	 , first_name AS "Original first_name"
  FROM employees ;

-- LENGTH()/ LENGTHB() 함수
SELECT LENGTH('hello oracle')      -- 영어는 글자길이 12
	 , lengthb('hello oracle')     -- 12bytes
	 , LENGTH('반가워요 오라클')   -- 한글 글자길이 8
	 , lengthb('반가워요 오라클')  
	   -- 22bytes  ; 한글은 1byte로 표현 못함(multibyte lang), 한글 7자*3bytes = 21bytes + 공백 1byte
	 , ASCII('A')
	 , ASCII('a')
	 , ASCII('가')
  FROM dual;

-- CONCAT()  : 두개를 합쳐주기 !! == || 와 동일기능 !!
SELECT concat(concat(first_name,' '), last_name) AS "full_name"
  FROM employees;