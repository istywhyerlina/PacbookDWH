INSERT INTO stg.book_author 
    (book_id,author_id) 

SELECT
    book_id,
    author_id
FROM pacbook.book_author

ON CONFLICT(book_id, author_id) 
DO UPDATE SET
    updated_at = stg.book_author.updated_at
