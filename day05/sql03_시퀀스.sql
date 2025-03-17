/*
 * 
 * 시퀀스 : 자동 증가되는 값
 * 
 * */

-- 시퀀스를 사용하지 않는 주문 테이블
CREATE TABLE order_noseq(
	order_idx NUMBER PRIMARY KEY,
	ORDER_nm varchar(20) NOT NULL,
	order_prd varchar(100) NOT NULL,
	qty			NUMBER DEFAULT 1
);


-- 시퀀스 사용하는 주문테이블
CREATE TABLE order_seq(
	order_idx NUMBER PRIMARY KEY,
	ORDER_nm varchar(20) NOT NULL,
	order_prd varchar(100) NOT NULL,
	qty			NUMBER DEFAULT 1
);

COMMIT;

-- 시퀀스 생성  ; 대부분의 시퀀스는 1씩 증가함~
CREATE SEQUENCE S_order
INCREMENT BY 1
START WITH 1;


-- 시퀀스 없는 order_noseq
INSERT INTO order_noseq VALUES (1, '홍길동', '망고', 20);
INSERT INTO order_noseq VALUES (2, '홍길동', '망고', 10);
INSERT INTO order_noseq VALUES (3, '홍길슨', '블루베리', 2);

-- 시퀀스 쓰면 order_seq
INSERT INTO order_seq VALUES (S_order.nextval, '홍길동', '애플망고', 10);
INSERT INTO order_seq VALUES (S_order.nextval, '홍길동', '망고', 20);
INSERT INTO order_seq VALUES (S_order.nextval, '홍길순', '오렌지', 10);


-- 시퀀스 개체의 현재 번호를 확인하는 법
SELECT S_order.currval FROM dual;  
  -- cf)
SELECT S_order.nextval FROM dual;  -- 이때 nextval 쓰면 번호가 올라가고, 그 번호는 쓸 수 없게 됨 !!

SELECT * FROM order_noseq;
SELECT * FROM order_seq;


-- 시퀀스 삭제(실행 주의!!)
DROP SEQUENCE S_order;


--
COMMIT;
