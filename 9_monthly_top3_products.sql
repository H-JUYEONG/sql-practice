-- 특정 월의 매출 기준 TOP 3 상품 조회

WITH monthly_sales AS (
    SELECT
        p.product_id,
        p.name AS product_name,
        SUM(p.price * oi.quantity) AS total_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE DATE_FORMAT(o.order_date, '%Y-%m') = '2024-03'
    GROUP BY p.product_id, p.name
),
ranked AS (
    SELECT
        *,
        RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM monthly_sales
)
SELECT *
FROM ranked
WHERE rnk <= 3
ORDER BY total_sales DESC;
