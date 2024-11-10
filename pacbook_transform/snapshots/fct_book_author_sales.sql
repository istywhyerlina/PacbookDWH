{% snapshot fct_book_author_sales %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_book_author_sales_id',

      strategy='check',
      check_cols=['price']
    )
}}

with book_author as (
select b.sk_book_id,
    b.nk_book_id,
    a.sk_author_id,
    a.author_name
    from {{ ref("dim_book") }} b
    join 
        {{ ref("stg_dwh__book_author") }} ba on ba.book_id = b.nk_book_id 
    join 
        {{ ref("dim_author") }} a on a.nk_author_id = ba.author_id 
),
order_line as (
select * from {{ ref("stg_dwh__order_line") }}
),
orderr as (
select * from {{ ref("stg_dwh__cust_order") }}
),
customer_address as (
select * from {{ ref("dim_customer_address") }}
),
dim_date as (
select * from {{ ref("dim_date") }}
),

fct_book_author_sales as (
    select 
        ba.sk_author_id,
        ol.line_id as nk_line_id,
        ba.sk_book_id,
        dd.date_id as order_date,
        ca.sk_customer_address_id,
        ol.price

        from
        order_line as ol
        join book_author as ba on ol.book_id=ba.nk_book_id
        left join orderr as o on o.order_id=ol.order_id
        left join customer_address as ca on ca.nk_address_id=o.dest_address_id and ca.nk_customer_id=o.customer_id
        left join dim_date as dd on dd.date_actual = date(order_date)
),
final_fct_book_author_sales  as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_line_id","sk_book_id","sk_author_id" ] ) }} as sk_book_author_sales_id,  
        *
    from fct_book_author_sales
)

select * from final_fct_book_author_sales

{% endsnapshot %}