{{
    config(
        materialized = "view"
    )
}}

with vehicle as (
    select
        hv.hub_vehicle_key,
        hv.vehicle_id,
        sv.vehicle_type,
        sv.model_year,
        sv.vehicle_desc,
        sv.color,
        greatest(hv.load_datetime, sv.load_datetime) as load_datetime
    from {{ ref('hub_vehicle') }} hv
    join {{ ref('sat_vehicle') }} sv
      on hv.hub_vehicle_key = sv.hub_vehicle_key
),

location as (
    select
        hl.hub_location_key,
        hl.location_id,
        sl.region,
        sl.country,
        sl.population,
        sl.density,
        greatest(hl.load_datetime, sl.load_datetime) as load_datetime
    from {{ ref('hub_location') }} hl
    join {{ ref('sat_location') }} sl
      on hl.hub_location_key = sl.hub_location_key
),

make as (
    select
        hm.hub_make_key,
        hm.make_id,
        sm.make_name,
        sm.make_type,
        greatest(hm.load_datetime, sm.load_datetime) as load_datetime
    from {{ ref('hub_make') }} hm
    join {{ ref('sat_make') }} sm
      on hm.hub_make_key = sm.hub_make_key
)

select
    v.vehicle_id,
    l.location_id,
    coalesce(m.make_id, -1) as make_id,

    v.vehicle_type,
    v.model_year,
    v.vehicle_desc,
    v.color,

    ssv.date_stolen,

    coalesce(m.make_name, 'Unknown Make') as make_name,
    coalesce(m.make_type, 'Unknown') as make_type,
    l.region,
    l.country,
    l.population,
    l.density,

    greatest(lnk.load_datetime, ssv.load_datetime, v.load_datetime, l.load_datetime, coalesce(m.load_datetime, lnk.load_datetime)) as load_datetime

from {{ ref('lnk_stolen_vehicle') }} lnk
join {{ ref('sat_stolen_vehicle') }} ssv
on lnk.lnk_stolen_vehicle_key = ssv.lnk_stolen_vehicle_key
    left join vehicle v
    on lnk.hub_vehicle_key = v.hub_vehicle_key
    left join location l
    on lnk.hub_location_key = l.hub_location_key
    left join make m
    on lnk.hub_make_key = m.hub_make_key