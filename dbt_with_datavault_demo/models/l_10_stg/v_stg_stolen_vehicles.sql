{%- set yaml_metadata -%}
source_model: 'v_src_brz_stolen_vehicles'
derived_columns:
  RECORD_SOURCE: "!SEEDS_DB"
  LOAD_DATETIME: "CURRENT_TIMESTAMP(4)"
  DATE_STOLEN: "TO_DATE(date_stolen, 'MM/DD/YY')"
  CLEAN_MAKE_ID: "COALESCE(make_id, -1)"
hashed_columns:
  HUB_VEHICLE_KEY: "vehicle_id"
  HUB_MAKE_KEY: "CLEAN_MAKE_ID"
  HUB_LOCATION_KEY: "location_id"

  LNK_STOLEN_VEHICLE_KEY:
    - "vehicle_id"
    - "location_id"
    - "make_id"

  SAT_STOLEN_VEHICLE_HASH_DIFF:
    is_hashdiff: true
    columns:
      - "DATE_STOLEN"

  SAT_VEHICLE_HASH_DIFF:
    is_hashdiff: true
    columns:
      - "vehicle_type"
      - "model_year"
      - "vehicle_desc"
      - "color"
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