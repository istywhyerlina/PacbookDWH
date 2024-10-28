INSERT INTO stg.book_language
    (language_id,language_code,language_name)

SELECT 
language_id,language_code,language_name 
FROM
    pacbook.book_language

ON CONFLICT(language_id) 
DO UPDATE SET
    language_name = EXCLUDED.language_name,
    language_code = EXCLUDED.language_code,
    updated_at = CASE WHEN 
                        stg.book_language.language_name <> EXCLUDED.language_name
                        OR stg.book_language.language_code <> EXCLUDED.language_code
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.book_language.updated_at
                END;