-- 카테고리별 매출 누적 비율 분석 (Pareto 80/20)

WITH category_sales AS (
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
    GROUP BY
        c.category_id,
        c.category_name
),
ranked AS (
    SELECT
        category_id,
        category_name,
        total_sales,
        SUM(total_sales) OVER () AS all_sales,
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        ) AS cumulative_sales
    FROM category_sales
)
SELECT
    category_id,
    category_name,
    total_sales,
    ROUND(cumulative_sales / all_sales, 4) AS cumulative_ratio
FROM ranked
ORDER BY total_sales DESC;
