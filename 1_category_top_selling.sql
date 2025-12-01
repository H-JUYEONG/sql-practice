-- 특정 카테고리(category_id = 3)의 상품별 총 판매수량을 구하고 총 판매수량이 50개 이상인 상품만 출력

SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
WHERE p.category_id = 3
GROUP BY p.product_id, p.name
HAVING total_sold >= 50
ORDER BY total_sold DESC;
