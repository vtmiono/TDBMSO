WITH s AS (
    SELECT *
    FROM {{source('source_seed_db', 'stolen_vehicles')}}
)
SELECT
    vehicle_id,
    vehicle_type,
    make_id,
    model_year,
    vehicle_desc,
    color,
    date_stolen,
    location_id
FROM s
WHERE vehicle_id IS NOT NULL