-- 최근 7일 이내에 가입한 유저들의 첫 주문일 조회
-- users + orders JOIN
-- 첫 주문일 = MIN(order_date)

SELECT
    u.user_id,
    u.name AS user_name,
    MIN(o.order_date) AS first_order_date
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
WHERE u.created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY u.user_id, u.name
ORDER BY first_order_date;
