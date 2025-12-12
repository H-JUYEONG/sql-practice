-- 고객별 최대 연속 구매일 수 구하기

WITH ordered_dates AS (
    SELECT
        customer_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
),
grouped AS (
    SELECT
        customer_id,
        order_date,
        -- 날짜 - rn 값을 기준으로 그룹 생성
        DATE(order_date) - INTERVAL rn DAY AS grp
    FROM ordered_dates
),
islands AS (
    SELECT
        customer_id,
        grp,
        MIN(order_date) AS start_date,
        MAX(order_date) AS end_date,
        COUNT(*) AS consecutive_days
    FROM grouped
    GROUP BY
        customer_id,
        grp
)
SELECT
    customer_id,
    MAX(consecutive_days) AS longest_streak
FROM islands
GROUP BY customer_id
ORDER BY longest_streak DESC;
