{%- set source_model = "v_stg_stolen_vehicles" -%}
{%- set src_pk = "LNK_STOLEN_VEHICLE_KEY" -%}
{%- set src_hashdiff = "SAT_STOLEN_VEHICLE_HASH_DIFF" -%}
{%- set src_payload = ["DATE_STOLEN"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk,src_payload=src_payload,
                   src_hashdiff=src_hashdiff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}

