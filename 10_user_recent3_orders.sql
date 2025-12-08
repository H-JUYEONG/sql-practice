-- 유저별 최근 3개 주문 조회

WITH ranked_orders AS (
    SELECT
        u.user_id,
        u.name AS user_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY u.user_id
            ORDER BY o.order_date DESC
        ) AS rn
    FROM users u
    JOIN orders o
        ON u.user_id = o.user_id
)
SELECT
    user_id,
    user_name,
    order_id,
    order_date
FROM ranked_orders
WHERE rn <= 3
ORDER BY user_id, order_date DESC;
