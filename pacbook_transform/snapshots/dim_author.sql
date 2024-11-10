{% snapshot dim_author %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_author_id',

      strategy='check',
      check_cols=['author_name'
		]
    )
}}

with dim_author as (
    select 
        author_id as nk_author_id,
        author_name
    from {{ ref("stg_dwh__author") }} 
),

final_dim_author as (
    select
		{{ dbt_utils.generate_surrogate_key( ["nk_author_id"] ) }} as sk_author_id, 
		* 
    from dim_author
)

select * from final_dim_author

{% endsnapshot %}