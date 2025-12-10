-- 카테고리별 월 매출 및 전월 대비 증감 계산

WITH monthly_sales AS (
    SELECT
        c.category_id,
        c.category_name,
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
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
        c.category_name,
        DATE_FORMAT(o.order_date, '%Y-%m')
),
with_lag AS (
    SELECT
        category_id,
        category_name,
        month,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY category_id
            ORDER BY month
        ) AS prev_month_sales
    FROM monthly_sales
)
SELECT
    category_id,
    category_name,
    month,
    total_sales,
    prev_month_sales,
    (total_sales - COALESCE(prev_month_sales, 0)) AS diff
FROM with_lag
ORDER BY category_id, month;
