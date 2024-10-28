INSERT INTO stg.author 
    (author_id,author_name) 

SELECT
    author_id,
    author_name
FROM pacbook.author

ON CONFLICT(author_id) 
DO UPDATE SET
    author_name = EXCLUDED.author_name,
    updated_at = CASE WHEN 
                        stg.author.author_name <> EXCLUDED.author_name 

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.author.updated_at
                END;