-- 분석4. 모든 상품(B.item_id='M0001~10')의 월별(SUBSTR(A.reserv_date,1,6)) 매출액(B.sales)을 출력

-- oracle
SELECT SUBSTR(A.reserv_date,1,6) 매출월,  
       SUM(DECODE(B.item_id,'M0001',B.sales,0)) SPECIAL_SET,
       SUM(DECODE(B.item_id,'M0002',B.sales,0)) PASTA,
       SUM(DECODE(B.item_id,'M0003',B.sales,0)) PIZZA,
       SUM(DECODE(B.item_id,'M0004',B.sales,0)) SEA_FOOD,
       SUM(DECODE(B.item_id,'M0005',B.sales,0)) STEAK,
       SUM(DECODE(B.item_id,'M0006',B.sales,0)) SALAD_BAR,
       SUM(DECODE(B.item_id,'M0007',B.sales,0)) SALAD,
       SUM(DECODE(B.item_id,'M0008',B.sales,0)) SANDWICH,
       SUM(DECODE(B.item_id,'M0009',B.sales,0)) WINE,
       SUM(DECODE(B.item_id,'M0010',B.sales,0)) JUICE
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
GROUP BY SUBSTR(A.reserv_date,1,6)
ORDER BY SUBSTR(A.reserv_date,1,6);

-- mariadb
-- SUBSTR(str, pos, len): A.reserv_date문자열을 1번째 문자부터 6개 문자를 가져오기
SELECT SUBSTR(A.reserv_date,1,6) 매출월,  
		-- B.item_id='M0001' 일 때, B.sales를 반환하고, 아니면 0을 반환해라. 그 후 B.sales를 모두 더해값을 출력
	    SUM(case B.item_id when 'M0001' then B.sales else 0 end) SPECIAL_SET,
        SUM(case B.item_id when 'M0002' then B.sales else 0 end) PASTA,
        SUM(case B.item_id when 'M0003' then B.sales else 0 end) PIZZA,
        SUM(case B.item_id when 'M0004' then B.sales else 0 end) SEA_FOOD,
        SUM(case B.item_id when 'M0005' then B.sales else 0 end) STEAK,
        SUM(case B.item_id when 'M0006' then B.sales else 0 end) SALAD_BAR,
        SUM(case B.item_id when 'M0007' then B.sales else 0 end) SALAD,
        SUM(case B.item_id when 'M0008' then B.sales else 0 end) SANDWICH,
        SUM(case B.item_id when 'M0009' then B.sales else 0 end) WINE,
        SUM(case B.item_id when 'M0010' then B.sales else 0 end) JUICE
-- 판매된 물품을 확인하기 위해 테이블 조인
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel    = 'N'
-- 월별 그룹화
GROUP BY SUBSTR(A.reserv_date,1,6)
-- 월별 내림차순 출력
ORDER BY SUBSTR(A.reserv_date,1,6);
