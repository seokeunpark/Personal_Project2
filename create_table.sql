-- address 테이블 생성
CREATE TABLE address ( 
	zip_code		  VARCHAR(6),
	address_detail	  VARCHAR(20));
	
-- 기본키 지정
-- CONSTRAINT PK_이름 PRIMARY KEY (적용 컬럼)
-- PK_이름으로 PK를 생성합니다.
ALTER TABLE address 
ADD 
CONSTRAINT pk_zip_code PRIMARY KEY (zip_code);


-- customer 테이블 생성
CREATE TABLE customer ( 
	customer_id		  VARCHAR(10),
	customer_name	  VARCHAR(20),
	phone_number	  VARCHAR(15),
	email			  VARCHAR(20),
	first_reg_date	  DATE,
	sex_code		  VARCHAR(2),
	birth			  VARCHAR(8),
	job               VARCHAR(20),
	zip_code		  VARCHAR(6));

ALTER TABLE customer ADD CONSTRAINT pk_customer PRIMARY KEY (customer_id);
-- customer 테이블의 zip_code를 customer_zip_code이름으로 FOREIGN KEY로 지정하고, 이는 address 테이블의 (zip_code)를 참조한다.
ALTER TABLE customer ADD CONSTRAINT fk_customer_zip_code FOREIGN KEY (zip_code) REFERENCES address (zip_code);


-- item 테이블 생성
-- NUMBER(10,0) -> INT
-- NUMBER(10,0): 최대 정수 10자리, 소수 0자리 숫자형 데이터
CREATE TABLE item ( 
	item_id			VARCHAR(10),
	product_name	VARCHAR(30),
	product_desc	VARCHAR(50),
	category_id		VARCHAR(10),
	price			INT);
	
ALTER TABLE item ADD CONSTRAINT pk_item PRIMARY KEY (item_id);


-- reservation 테이블 생성
-- ??? CONSTRAINT nn_reservation_customer_id NOT NULL enable -> NOT NULL
CREATE TABLE reservation ( 
	reserv_no	    VARCHAR(30),
	reserv_date	    VARCHAR(8),
	reserv_time	    VARCHAR(4),
	customer_id	    VARCHAR(10) NOT NULL,
	branch		    VARCHAR(20),
	visitor_cnt	    TINYINT,
    cancel 		    VARCHAR(1));

ALTER TABLE reservation ADD CONSTRAINT pk_reservation PRIMARY KEY (reserv_no);
ALTER TABLE reservation ADD CONSTRAINT fk_reservation_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id);


-- order_info 테이블 생성
-- NUMBER(3, 0) -> TINYINT
-- NUMBER(3, 0): 최대 정수 3자리, 소수 0자리 숫자형 데이터
CREATE TABLE order_info ( 
	order_no	    VARCHAR(30),
	item_id		    VARCHAR(10),
	reserv_no	    VARCHAR(30),
	quantity	    TINYINT,
    sales           INT);

ALTER TABLE order_info ADD CONSTRAINT pk_order_info PRIMARY KEY (order_no, item_id);
ALTER TABLE order_info ADD CONSTRAINT fk_order_info_item_id FOREIGN KEY (item_id) REFERENCES item (item_id);
ALTER TABLE order_info ADD CONSTRAINT fk_order_info_reserv_no FOREIGN KEY (reserv_no) REFERENCES reservation (reserv_no);	