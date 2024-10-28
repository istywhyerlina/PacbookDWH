INSERT INTO stg.publisher
    (publisher_id,publisher_name)

SELECT 
publisher_id,publisher_name 
FROM
    pacbook.book_language

ON CONFLICT(publisher_id) 
DO UPDATE SET
    publisher_name = EXCLUDED.publisher_name,
    updated_at = CASE WHEN 
                        stg.publisher.publisher_name <> EXCLUDED.publisher_name
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.publisher.updated_at
                END;