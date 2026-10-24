{%- set source_model = "v_stg_locations" -%}
{%- set src_pk = "HUB_LOCATION_KEY" -%}
{%- set src_hashdiff = "SAT_LOCATION_HASH_DIFF" -%}
{%- set src_payload = ["region", "country", "population", "density"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk,src_payload=src_payload,
                   src_hashdiff=src_hashdiff,
                   src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}