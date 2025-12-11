-- 전체 고객 중 매출 기준 상위 20% 고객 찾기

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.name,
        SUM(p.price * oi.quantity) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.name
),
ranked AS (
    SELECT
        customer_id,
        name,
        total_spent,
        CUME_DIST() OVER (ORDER BY total_spent DESC) AS spend_distribution
    FROM customer_sales
)
SELECT
    customer_id,
    name,
    total_spent,
    spend_distribution
FROM ranked
WHERE spend_distribution <= 0.2
ORDER BY total_spent DESC;
