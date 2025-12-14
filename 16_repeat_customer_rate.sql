-- 재구매 고객 비율 계산

WITH customer_order_count AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
),
classified AS (
    SELECT
        customer_id,
        CASE
            WHEN order_count = 1 THEN 'first_time'
            ELSE 'repeat'
        END AS customer_type
    FROM customer_order_count
)
SELECT
    customer_type,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (),
        4
    ) AS ratio
FROM classified
GROUP BY customer_type;
