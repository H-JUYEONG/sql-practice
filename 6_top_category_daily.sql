-- 특정 날짜 기준 가장 매출이 높은 카테고리 조회

SELECT
    c.category_id,
    c.category_name,
    SUM(p.price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
WHERE DATE(o.order_date) = '2024-03-15'
GROUP BY c.category_id, c.category_name
ORDER BY total_sales DESC
LIMIT 1;
