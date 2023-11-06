-- 분석10-2. 월별 전용상품 매출 1위를 확인하고, 지점별로 등급을 매기기

-- 
SELECT *
    FROM 
    (
      SELECT SUBSTR(A.reserv_date,1,6) 매출월,
             A.branch                  지점,
             SUM(B.sales)              전용상품매출,
             -- 전용상품매출을 내림차순으로 순위를 row_number() 기반으로 순위를 매기고, 월별 그룹별로 순위를 매김.
             ROW_NUMBER() OVER(PARTITION BY SUBSTR(A.reserv_date,1,6) 
				ORDER BY SUM(B.sales) DESC) 지점순위,
			 -- A.branch 값에 따라 지점등급 분류
             case A.branch when '강남' then 'A'
							when '종로' then 'A'	
                            when '영등포' then 'A'
                            else 'B' end 지점등급
	  -- 판매된 상품에 대해서만 select
      FROM  reservation A, order_info B
      WHERE A.reserv_no = B.reserv_no
      AND   A.cancel = 'N'
	  -- B.item_id='M0001'인 것에 대해서만 select
      AND   B.item_id = 'M0001'
      -- 월별 그룹화,
      GROUP BY SUBSTR(A.reserv_date,1,6), 
      -- 지점별 그룹화: 전용상품매출 속성을 지점별로 보기 위함
      A.branch
	  -- 월별 오름차순 정렬
      ORDER BY SUBSTR(A.reserv_date,1,6)
      ) A
WHERE A.지점순위 = 1;
-- AND 지점등급 = 'A';


-- 인라인 뷰
SELECT SUBSTR(A.reserv_date,1,6) 매출월,
	 A.branch                  지점,
	 SUM(B.sales)              전용상품매출,
	 ROW_NUMBER() OVER(PARTITION BY SUBSTR(A.reserv_date,1,6) 
		ORDER BY SUM(B.sales) DESC) 지점순위,
	 case A.branch when '강남' then 'A'
					when '종로' then 'A'	
					when '영등포' then 'A'
					else 'B' end 지점등급
FROM  reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel = 'N'
AND   B.item_id = 'M0001'
GROUP BY SUBSTR(A.reserv_date,1,6), 
A.branch
ORDER BY SUBSTR(A.reserv_date,1,6);
