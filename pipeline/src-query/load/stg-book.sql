INSERT INTO stg.book 
    (book_id,title,isbn13,language_id,num_pages,stgation_date,publisher_id)

SELECT 
book_id,title,isbn13,language_id,num_pages,stgation_date,publisher_id 
FROM
    pacbook.book

ON CONFLICT(book_id) 
DO UPDATE SET
    title = EXCLUDED.title,
    isbn13 = EXCLUDED.isbn13,
    language_id = EXCLUDED.language_id,
    num_pages = EXCLUDED.num_pages,
    stgation_date = EXCLUDED.stgation_date,
    publisher_id = EXCLUDED.publisher_id,
    updated_at = CASE WHEN 
                        stg.book.title <> EXCLUDED.title
                        OR stg.book.isbn13 <> EXCLUDED.isbn13
                        OR stg.book.language_id <> EXCLUDED.language_id
                        OR stg.book.num_pages <> EXCLUDED.num_pages
                        OR stg.book.stgation_date <> EXCLUDED.stgation_date
                        OR stg.book.publisher_id <> EXCLUDED.publisher_id
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.book.updated_at
                END;