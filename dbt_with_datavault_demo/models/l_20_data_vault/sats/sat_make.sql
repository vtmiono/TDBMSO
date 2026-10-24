{%- set source_model = "v_stg_make_details" -%}
{%- set src_pk = "HUB_MAKE_KEY" -%}
{%- set src_hashdiff = "SAT_MAKE_HASH_DIFF" -%}
{%- set src_payload = ["make_name", "make_type"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk,src_payload=src_payload,
                   src_hashdiff=src_hashdiff,
                   src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}