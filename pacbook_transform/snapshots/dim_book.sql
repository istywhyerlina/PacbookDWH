{% snapshot dim_book %}

{{
    config(
      target_database='pacbook-dwh',
      target_schema='final',
      unique_key='sk_book_id',

      strategy='check',
      check_cols=[
        'title',
        'isbn13',
        'language_code',
        'language_name',
        'num_pages',
        'publication_date',
        'publisher_name'
		]
    )
}}

with dim_book as (
    select 
        b.book_id as nk_book_id,
        b.title,
        b.isbn13,
        bl.language_code,
        bl.language_name,
        b.num_pages,
        b.publication_date,
        p.publisher_name
    from {{ ref("stg_dwh__book") }} b
    join 
        {{ ref("stg_dwh__book_language") }} bl on bl.language_id = b.language_id 
    join 
        {{ ref("stg_dwh__publisher") }} p on p.publisher_id = b.publisher_id 
),

final_dim_book as (
    select
		{{ dbt_utils.generate_surrogate_key( ["nk_book_id"] ) }} as sk_book_id, 
		* 
    from dim_book
)

select * from final_dim_book

{% endsnapshot %}