-- 이메일이 중복된 유저 중 가장 최근 가입 기록만 남기고
-- 나머지 중복 데이터만 조회 (삭제 대상)

WITH ranked_users AS (
    SELECT
        user_id,
        name,
        email,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY created_at DESC
        ) AS rn
    FROM users
)
SELECT
    user_id,
    name,
    email,
    created_at
FROM ranked_users
WHERE rn > 1
ORDER BY email, created_at;
