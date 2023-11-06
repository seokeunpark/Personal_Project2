-- 분석8. 분석7에 총 매출 대비 전용 상품의 판매율, 총 예약 건 대비 예약 취소율을 추가
-- (각 결과에 '%'를 붙이고, 소수점 발생시 소수 첫째 자리까지 출력)

-- oracle
-- || : 문자열 합치기
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
       SUM(B.sales) 총매출, 
       SUM(B.sales) - SUM(case B.item_id when 'M0001' then B.sales else 0 end) 전용상품외매출, 
       SUM(case B.item_id when 'M0001' then B.sales else 0 end) 전용상품매출,
       ROUND(SUM(case B.item_id when 'M0001' then B.sales else 0 end)/SUM(B.sales)*100,1)||'%' 전용상품판매율,
       COUNT(A.reserv_no) 총예약건,
       SUM(case A.cancel when 'N' then 1 else 0 end) 예약완료건,
       SUM(case A.cancel when 'Y' then 1 else 0 end) 예약취소건,
       ROUND(SUM(case A.cancel when 'Y' then 1 else 0 end)/COUNT(A.reserv_no)*100,1)||'%' 예약취소율
FROM reservation A LEFT OUTER JOIN order_info B
ON A.reserv_no = B.reserv_no
AND A.cancel = 'N'
-- AND   A.cancel    = 'N'
GROUP BY SUBSTR(A.reserv_date,1,6)
ORDER BY SUBSTR(A.reserv_date,1,6);

-- mariadb
-- CONCAT(str1, str2): 문자열 합치기
SELECT SUBSTR(A.reserv_date,1,6) 매출월, 
       SUM(B.sales) 총매출, 
       SUM(B.sales) - SUM(case B.item_id when 'M0001' then B.sales else 0 end) 전용상품외매출, 
       SUM(case B.item_id when 'M0001' then B.sales else 0 end) 전용상품매출,
       -- 전용상품외매출 / 전용상품매출 * 100 = 전용상품판매율
	   CONCAT(ROUND(SUM(case B.item_id when 'M0001' then B.sales else 0 end)/SUM(B.sales)*100,1), '%') 전용상품판매율,
       COUNT(A.reserv_no) 총예약건,
       SUM(case A.cancel when 'N' then 1 else 0 end) 예약완료건,
       SUM(case A.cancel when 'Y' then 1 else 0 end) 예약취소건,
       -- 총예약건 / 예약취소건 * 100 = 예약취소율
       CONCAT(ROUND(SUM(case A.cancel when 'Y' then 1 else 0 end)/COUNT(A.reserv_no)*100,1),'%') 예약취소율
FROM reservation A LEFT OUTER JOIN order_info B
ON A.reserv_no = B.reserv_no
AND A.cancel = 'N'
-- AND   A.cancel    = 'N'
GROUP BY SUBSTR(A.reserv_date,1,6)
ORDER BY SUBSTR(A.reserv_date,1,6);