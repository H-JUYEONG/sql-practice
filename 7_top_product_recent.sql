-- 최근 7일 동안 주문된 상품 중 가장 많이 판매된 상품 조회

SELECT
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 1;
