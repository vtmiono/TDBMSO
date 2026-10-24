{%- set source_model = "v_stg_stolen_vehicles" -%}
{%- set src_pk = "LNK_STOLEN_VEHICLE_KEY" -%}
{%- set src_fk = ["HUB_VEHICLE_KEY", "HUB_LOCATION_KEY", "HUB_MAKE_KEY"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}