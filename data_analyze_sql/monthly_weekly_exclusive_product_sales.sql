-- 분석9. 월별 전용 상품 매출액을 일요일부터 월요일까지 구분해 출력

-- oracle
-- TO_DATE("문자열", "날짜 포맷"): 문자열을 날짜 데이터로 변경 (A.reserv_date는 varchar 타입이다)
-- TO-CHAR("날자 데이터", '반환'): 날자 데이터에서 특정 포맷을 반환
SELECT  SUBSTR(reserv_date,1,6) 날짜,  
          A.product_name 상품명,
          SUM(case A.WEEK when '1' then A.sales else 0 end) 일요일,
          SUM(case A.WEEK when '2' then A.sales else 0 end) 월요일,
          SUM(case A.WEEK when '3' then A.sales else 0 end) 화요일,
          SUM(case A.WEEK when '4' then A.sales else 0 end) 수요일,
          SUM(case A.WEEK when '5' then A.sales else 0 end) 목요일,
          SUM(case A.WEEK when '6' then A.sales else 0 end) 금요일,
          SUM(case A.WEEK when '7' then A.sales else 0 end) 토요일
FROM
      (
        SELECT A.reserv_date,
               C.product_name,
               TO_CHAR(TO_DATE(A.reserv_date, 'YYYYMMDD'),'d') WEEK,
               B.sales
        FROM reservation A, order_info B, item C
        WHERE A.reserv_no = B.reserv_no
        AND   B.item_id   = C.item_id
        AND   B.item_id = 'M0001'
      ) A
GROUP BY SUBSTR(reserv_date,1,6), A.product_name
ORDER BY SUBSTR(reserv_date,1,6);


-- mariadb
-- STR_TO_DATE(str, format): str 문자열을 format 형식의 날짜형 타입으로 변경
-- DATE_FORMAT(date, '출력할 포맷'): date 값중 해당되는 포맷 값을 추출
--  [format]: 
--  1. %Y=4자리 년도, %y=2자리 년도
--  2. %m=2자리 월, %d=2자리 일

SELECT  SUBSTR(reserv_date,1,6) 날짜,
          A.product_name 상품명,
          -- 20170601은 수요일로 reserv_date의 날짜를 7로 나눴을 때의 나머지에 따라 요일명 정의
          -- A 테이블과 WEEK 속성은 인라인 뷰에서 정의된 값이다.
          SUM(case A.WEEK when '5' then A.sales else 0 end) 일요일,
          SUM(case A.WEEK when '6' then A.sales else 0 end) 월요일,
          SUM(case A.WEEK when '0' then A.sales else 0 end) 화요일,
          SUM(case A.WEEK when '1' then A.sales else 0 end) 수요일,
          SUM(case A.WEEK when '2' then A.sales else 0 end) 목요일,
          SUM(case A.WEEK when '3' then A.sales else 0 end) 금요일,
          SUM(case A.WEEK when '4' then A.sales else 0 end) 토요일
FROM
	-- 인라인 뷰 정의
      (
        SELECT A.reserv_date,
               C.product_name,
               -- STR_TO_DATE: 문자열 타입인 reserv_date를 date타입으로 변경
               -- date_format: 해당 date 값 중에서 day의 값을 추출
               -- % 7 연산으로 요일명을 정의할 때 용이하도록 함
			   (date_format(STR_TO_DATE(A.reserv_date, '%Y%m%d'),'%d') % 7 ) WEEK,
               B.sales
		-- 판매된 상품의 정보에서만 select
        FROM reservation A, order_info B, item C
        WHERE A.reserv_no = B.reserv_no
        -- item_id='M0001'인 항목에 대해서만 select
        AND   B.item_id   = C.item_id
        AND   B.item_id = 'M0001'
		-- 해당 결과 테이블을 A 테이블이라고 정의(인라인 뷰)
      ) A
-- 월별 그룹화 + A.product_name 별로 그룹화
GROUP BY SUBSTR(reserv_date,1,6), A.product_name
-- 월별 오름차순
ORDER BY SUBSTR(reserv_date,1,6);
        

-- 인라인 뷰
SELECT A.reserv_date,
		C.product_name,
		(date_format(STR_TO_DATE(A.reserv_date, '%Y%m%d'),'%d') % 7 ) WEEK,
		B.sales

FROM reservation A, order_info B, item C
WHERE A.reserv_no = B.reserv_no

AND   B.item_id   = C.item_id
AND   B.item_id = 'M0001';
