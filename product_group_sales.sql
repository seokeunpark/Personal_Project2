-- 분석3. 각 상품별(C.item_id or C.product_name) 전체 매출액(SUM(B.sales))을 내림차순으로 출력
SELECT C.item_id 상품아이디, 
       C.product_name 상품이름,
       SUM(B.sales) 상품매출
-- 판매된 상품별 매출 계산을 위해 테이블 조인
FROM reservation A, order_info B, item C 
WHERE A.reserv_no = B.reserv_no
AND   B.item_id   = C.item_id
AND   A.cancel    = 'N'
-- item_id 별로 그룹화
GROUP BY C.item_id
-- B.sales의 합계를 내림차순으로 정렬
ORDER BY SUM(B.sales) DESC;

select *
from reservation;
select *
from order_info;
select *
from item;