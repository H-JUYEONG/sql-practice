-- 전체 주문 기준 가장 많이 팔린 상품 TOP 5 조회
-- order_items + products JOIN
-- 수량 기준 내림차순

SELECT
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 5;
