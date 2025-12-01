-- 유저별 총 구매 금액을 계산하고  총 구매 금액이 100,000원 이상인 유저만 조회
-- 주문 상태가 COMPLETED 인 주문만 포함

SELECT
    u.user_id,
    u.name AS user_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'COMPLETED'
GROUP BY u.user_id, u.name
HAVING total_spent >= 100000
ORDER BY total_spent DESC;
