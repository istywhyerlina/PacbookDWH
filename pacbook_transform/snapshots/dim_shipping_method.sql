{% snapshot dim_shipping_method %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_method_id',

      strategy='check',
      check_cols=['method_name','cost'
		]
    )
}}

with dim_shipping_method as (
    select 
        method_id as nk_method_id,
        method_name, cost
    from {{ ref("stg_dwh__shipping_method") }} 
),

final_dim_shipping_method as (
    select
		{{ dbt_utils.generate_surrogate_key( ["nk_method_id"] ) }} as sk_method_id, 
		* 
    from dim_shipping_method
)

select * from final_dim_shipping_method

{% endsnapshot %}