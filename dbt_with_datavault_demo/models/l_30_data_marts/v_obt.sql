{{
    config(
        materialized = "view"
    )
}}
with
vehicle as (
    select
        hv.hub_vehicle_key,
        hv.vehicle_id,
        sv.vehicle_type,
        sv.model_year,
        sv.vehicle_desc,
        sv.color,
        greatest(hv.load_datetime, coalesce(sv.load_datetime, hv.load_datetime)) as load_datetime
    from {{ ref('hub_vehicle') }} hv
    left join {{ ref('sat_vehicle') }} sv
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
        greatest(hl.load_datetime, coalesce(sl.load_datetime, hl.load_datetime)) as load_datetime
    from {{ ref('hub_location') }} hl
    left join {{ ref('sat_location') }} sl
      on hl.hub_location_key = sl.hub_location_key
),

make as (
    select
        hm.hub_make_key,
        hm.make_id,
        sm.make_name,
        sm.make_type,
        greatest(hm.load_datetime, coalesce(sm.load_datetime, hm.load_datetime)) as load_datetime
    from {{ ref('hub_make') }} hm
    left join {{ ref('sat_make') }} sm
      on hm.hub_make_key = sm.hub_make_key
)

select
    v.vehicle_id,
    v.vehicle_type,
    m.make_id,
    m.make_name,
    m.make_type,
    v.model_year,
    v.vehicle_desc,
    v.color,
    ssv.date_stolen,
    l.location_id,
    l.region,
    l.country,
    l.population,
    l.density,
    greatest(
            lnk.load_datetime,
            coalesce(ssv.load_datetime, lnk.load_datetime),
            coalesce(v.load_datetime, lnk.load_datetime),
            coalesce(l.load_datetime, lnk.load_datetime),
            coalesce(m.load_datetime, lnk.load_datetime)
    ) as load_datetime

from {{ ref('lnk_stolen_vehicle') }} lnk
left join {{ ref('sat_stolen_vehicle') }} ssv
on lnk.lnk_stolen_vehicle_key = ssv.lnk_stolen_vehicle_key
left join vehicle v
on lnk.hub_vehicle_key = v.hub_vehicle_key
left join location l
on lnk.hub_location_key = l.hub_location_key
left join make m
on lnk.hub_make_key = m.hub_make_key