{% snapshot dim_customer_address %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_customer_address_id',

      strategy='check',
      check_cols=[        "first_name",
        "last_name",
        "email", 
        "street_number",
        "street_name",
        "city",
        "country_name"

		]
    )
}}

with dim_customer as (
    select 
        c.customer_id as nk_customer_id,
        a.address_id as nk_address_id,
        c.first_name,
        c.last_name,
        c.email, 
        a.street_number,
        a.street_name,
        a.city,
        co.country_name
        from {{ ref("stg_dwh__customer") }} c
        join 
            {{ ref("stg_dwh__customer_adress") }} ca on ca.customer_id = c.customer_id 
        join 
            {{ ref("stg_dwh__address") }} a on a.address_id = ca.address_id 
        join 
            {{ ref("stg_dwh__country") }} co on co.country_id = a.country_id 
        where ca.status_id=1
),

final_dim_customer as (
    select
		{{ dbt_utils.generate_surrogate_key( ["nk_customer_id","nk_address_id"] ) }} as sk_customer_address_id, 
		* 
    from dim_customer
)

select * from final_dim_customer

{% endsnapshot %}