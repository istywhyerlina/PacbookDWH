INSERT INTO stg.address 
    (address_id,street_number,street_name,city,country_id) 

SELECT
    address_id,
    street_number,
    street_name,
    city,
    country_id
FROM pacbook.address

ON CONFLICT(address_id) 
DO UPDATE SET
    city = EXCLUDED.city,
    street_number = EXCLUDED.street_number,
    street_name = EXCLUDED.street_name,
    country_id = EXCLUDED.country_id,
    updated_at = CASE WHEN 
                        stg.address.city <> EXCLUDED.city
                        OR stg.address.street_number <> EXCLUDED.street_number 
                        OR stg.address.street_name <> EXCLUDED.street_name 
                        OR stg.address.country_id <> EXCLUDED.country_id 

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.address.updated_at
                END;