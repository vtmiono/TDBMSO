WITH s AS (
    SELECT *
    FROM {{source('source_seed_db', 'locations')}}
)
SELECT
    location_id,
    region,
    country,
    population,
    density
FROM S
WHERE location_id IS NOT NULL
