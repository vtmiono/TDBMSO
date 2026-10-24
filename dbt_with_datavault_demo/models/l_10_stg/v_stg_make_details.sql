{%- set yaml_metadata -%}
source_model: 'v_src_brz_make_details'
derived_columns:
  RECORD_SOURCE: "!SEEDS_DB"
  LOAD_DATETIME: "CURRENT_TIMESTAMP(4)"
hashed_columns:
  HUB_MAKE_KEY: "make_id"

  SAT_MAKE_HASH_DIFF:
    is_hashdiff: true
    columns:
      - "make_name"
      - "make_type"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}