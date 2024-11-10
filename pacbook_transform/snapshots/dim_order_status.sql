{% snapshot dim_order_status %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_status_id',

      strategy='check',
      check_cols=['status_value'
		]
    )
}}

with dim_order_status as (
    select 
        status_id as nk_status_id,
        status_value
    from {{ ref("stg_dwh__order_status") }} 
),

final_dim_order_status as (
    select
		{{ dbt_utils.generate_surrogate_key( ["nk_status_id"] ) }} as sk_status_id, 
		* 
    from dim_order_status
)

select * from final_dim_order_status

{% endsnapshot %}