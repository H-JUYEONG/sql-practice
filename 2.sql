-- 최근 30일 동안 주문한 유저의 목록을 조회하고 유저 이름과 최근 주문일을 함께 출력하는 SQL

SELECT 
    u.user_id,
    u.name AS user_name,
    MAX(o.order_date) AS last_order_date
FROM users u
JOIN orders o 
    ON u.user_id = o.user_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY u.user_id, u.name
ORDER BY last_order_date DESC;
