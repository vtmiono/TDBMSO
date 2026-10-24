WITH s AS (
    SELECT *
    FROM {{ source('source_seed_db', 'make_details') }}
)
SELECT
    make_id,
    make_name,
    make_type
FROM s
WHERE make_id IS NOT NULL