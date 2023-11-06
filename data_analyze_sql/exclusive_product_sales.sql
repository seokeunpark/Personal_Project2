select *
from reservation;
select *
from order_info;

-- 분석2. 전체 상품의 총 판매량과 총 매출액, 전용 상품의 판매량과 매출액을 출력해 보세요.

-- oracle
-- DECODE(컬럼, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3..........) 
SELECT COUNT(*) 총판매량, 
       SUM(B.sales) 총매출, 
       SUM(DECODE(B.item_id,'M0001',1,0)) 전용상품판매량, 
       SUM(DECODE(B.item_id,'M0001',B.sales,0)) 전용상품매출
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N';

-- mariadb
--  case
--     when 조건1  then  반환값
--     when 조건2  then  반환값
--     else 반환값
--  end
SELECT COUNT(*) 총판매량, 
       SUM(B.sales) 총매출, 
       -- B 테이블의 item_id='M0001'이면 1을 반환, 아니면 0을 반환하고, 모두 더함
       SUM(CASE B.item_id 
       WHEN 'M0001' THEN 1 
       ELSE 0 END) 전용상품판매량, 
       -- B 테이블의 item_id='M0001'이면 sales를 반환, 아니면 0을 반환하고, 모두 더함
       SUM(CASE B.item_id 
       WHEN 'M0001' THEN B.sales 
       ELSE 0 END) 전용상품매출
-- 실제 판매된 건수를 확인하기 위해 테이블 조인
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N';
