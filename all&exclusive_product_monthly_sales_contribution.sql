-- 분석6. 분석5에 매출 기여율을 추가(기여율은 소수점 첫째자리까지만 출력)

-- oracle
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
       SUM(b.sales) - SUM(decode(b.item_id,'M0001',b.sales,0)) 전용상품외매출, 
       SUM(decode(b.item_id,'M0001',b.sales,0))   전용상품매출,
       ROUND(SUM(DECODE(B.item_id,'M0001',B.sales,0))/SUM(B.sales)*100,1) 매출기여율
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
GROUP BY SUBSTR(A.reserv_date,1,6)
ORDER BY SUBSTR(A.reserv_date,1,6); 

-- mariadb
-- round(값, 자리수): 값을 자리수까지만 반올림하여 출력
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
		-- 전체 매출액 - 전용상품 매출액 = 전용상품 외 매출액
       SUM(b.sales)-SUM(case B.item_id when 'M0001' then b.sales else 0 end) 전용상품외매출, 
       SUM(case b.item_id when 'M0001' then b.sales else 0 end) 전용상품매출,
       -- 전용상품 매출액 / 전체상품 매출액 * 100 = 전용상품의 매출 기여율
       ROUND(SUM(case b.item_id when 'M0001' then b.sales else 0 end)/SUM(B.sales)*100,1) 매출기여율
-- 판매된 물품에 대한 검색을 하기 위해 테이블 조인
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
-- 월별 그룹화
GROUP BY SUBSTR(A.reserv_date,1,6)
-- 월별 내림차순
ORDER BY SUBSTR(A.reserv_date,1,6);