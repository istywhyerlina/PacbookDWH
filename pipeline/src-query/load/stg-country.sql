INSERT INTO stg.country 
    (country_id,country_name) 

SELECT
    country_id,
    country_name
FROM pacbook.country

ON CONFLICT(country_id) 
DO UPDATE SET
    country_name = EXCLUDED.country_name,
    updated_at = CASE WHEN 
                        stg.country.country_name <> EXCLUDED.country_name 

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.country.updated_at
                END;