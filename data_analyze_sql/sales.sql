-- 분석1. 전체 상품의 주문 완료 건 총 매출, 평균 매출, 최고 매출, 최저 매출을 출력해 보세요.

select count(*) 전체주문건,
	SUM(B.sales) 총_매출,
    AVG(B.sales) 평균_매출,
    MAX(B.sales) 최고_매출,
    MIN(B.sales) 최저_매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no;

select *
from reservation;
select *
from order_info;
