{% snapshot fct_order %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='nk_order_id',

      strategy='timestamp',
      updated_at='status_date'
    )
}}

with

orderr as (
select * from {{ ref("stg_dwh__cust_order") }}
),
customer_address as (
select * from {{ ref("dim_customer_address") }}
),
order_history as (
select * from {{ ref("stg_dwh__order_history") }}
),
dim_date as (
select * from {{ ref("dim_date") }}
),
order_status as (
select * from {{ ref("dim_order_status") }}
),
shipping_method as (
select * from {{ ref("dim_shipping_method") }}
),

fct_order as (
    select
        oh.history_id as nk_history_id,
        o.order_id as nk_order_id,
        dd.date_id as order_date_id,
        sm.sk_method_id,
        ca.sk_customer_address_id,
        os.sk_status_id,
        dd2.date_id as status_date_id,
        oh.status_date


        from
        order_history as oh
        left join orderr as o on o.order_id=oh.order_id
        left join customer_address as ca on ca.nk_address_id=o.dest_address_id and ca.nk_customer_id=o.customer_id
        left join shipping_method as sm on sm.nk_method_id=o.shipping_method_id
        left join order_status as os on os.nk_status_id=oh.status_id
        left join dim_date as dd on dd.date_actual = date(o.order_date)
        left join dim_date as dd2 on dd2.date_actual = date(oh.status_date)

        order by oh.status_date

),
final_fct_order  as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_order_id", "sk_status_id" ] ) }} as sk_order_history_id,  
        *
    from fct_order
    order by status_date

)

select * from final_fct_order

{% endsnapshot %}