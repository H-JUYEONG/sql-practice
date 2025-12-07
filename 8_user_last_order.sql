-- 유저별 최근 주문 1건 조회

SELECT 
    u.user_id,
    u.name AS user_name,
    o.order_id,
    o.order_date
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.user_id = u.user_id
)
ORDER BY o.order_date DESC;
