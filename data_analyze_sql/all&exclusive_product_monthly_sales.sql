-- 분석5. 월별 총 매출액과 전용 상품 매출액을 출력

-- oracle
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
       SUM(B.sales) 총매출, 
       SUM(DECODE(B.item_id,'M0001',B.sales,0)) 전용상품매출
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
GROUP BY SUBSTR(A.reserv_date,1,6)
ORDER BY SUBSTR(A.reserv_date,1,6);

-- mariadb
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
       SUM(B.sales) 총매출, 
       SUM(case B.item_id when 'M0001' then B.sales else 0 end) M0001_전용상품매출
-- 판매된 물품에 대한 검색을 하기 위해 테이블 조인
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
-- 월별 그룹화
GROUP BY SUBSTR(A.reserv_date,1,6)
-- 월별 내림차순
ORDER BY SUBSTR(A.reserv_date,1,6);
