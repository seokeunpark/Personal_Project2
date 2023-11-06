-- 분석10. 월별 전용상품 매출 1위부터 3위까지의 지점이 어디인지 확인

-- mariadb
-- RANK() over  : 동률을 같은 등수로 처리. 다음 등수를 동률의 수 만큼 제외하고 등수로 매김
-- DENSE_RANK() over : 동률을 같은 등수로 처리하지만, 다음 등수를 동률의 수 만큼 제외하지 않고 바로 등수로 매김
-- ROW_NUMBER() over : 동률을 반영하지 않는다. 즉, 동일한 등수는 존재하지 않고 모든 행은 다른 등수를 가짐.
-- 		PARTITION BY: 전체 순서가 아닌, 그룹별 순서로 순위를 매김
SELECT *
    FROM 
    (
      SELECT SUBSTR(A.reserv_date,1,6) 매출월,
             A.branch                 지점,
             SUM(B.sales)              전용상품매출,
             -- 전용상품매출을 내림차순으로 순위를 RANK() 기반으로 순위를 매기고, 월별 그룹별로 순위를 매김.
             RANK() OVER(PARTITION BY SUBSTR(A.reserv_date,1,6)   
			 ORDER BY SUM(B.sales) DESC) 지점순위
      -- 판매된 상품의 정보에서만 select
      FROM  reservation A, order_info B
      WHERE A.reserv_no = B.reserv_no
      AND   A.cancel = 'N'
      -- item_id='M0001'인 항목에 대해서만 select
      AND   B.item_id = 'M0001'
      -- 월별 그룹화, 지점별 그룹화
      -- 지점별 그룹화를 해야 지점별 전용상품매출이 출력된다.
      GROUP BY SUBSTR(A.reserv_date,1,6), A.branch
      -- 월별 오름차순 정렬
      ORDER BY SUBSTR(A.reserv_date,1,6)
    ) A
WHERE A.지점순위 <= 3; 


-- 인라인 뷰
SELECT SUBSTR(A.reserv_date,1,6) 매출월,
	 A.branch                 지점,
	 SUM(B.sales)              전용상품매출,
	 RANK() OVER(PARTITION BY SUBSTR(A.reserv_date,1,6)   
	 ORDER BY SUM(B.sales) DESC) 지점순위
FROM  reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND   A.cancel = 'N'
AND   B.item_id = 'M0001'
GROUP BY SUBSTR(A.reserv_date,1,6), A.branch
ORDER BY SUBSTR(A.reserv_date,1,6);