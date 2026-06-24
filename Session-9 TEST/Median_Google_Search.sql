WITH freq AS (
    SELECT
        searches,
        num_users,
        SUM(num_users) OVER (ORDER BY searches) AS end_pos
    FROM search_frequency
),
positions AS (
    SELECT
        searches,
        end_pos - num_users + 1 AS start_pos,
        end_pos
    FROM freq
),
total AS (
    SELECT SUM(num_users) AS total_users
    FROM search_frequency
)

SELECT
    ROUND(AVG(searches), 1) AS median
FROM positions, total
WHERE
    total_users / 2.0 BETWEEN start_pos AND end_pos
    OR
    total_users / 2.0 + 1 BETWEEN start_pos AND end_pos;