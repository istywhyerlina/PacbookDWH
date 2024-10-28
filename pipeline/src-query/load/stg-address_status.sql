INSERT INTO stg.address_status 
    (status_id,address_status) 

SELECT
    status_id,
    address_status
FROM pacbook.address_status

ON CONFLICT(status_id) 
DO UPDATE SET
    address_status = EXCLUDED.address_status,
    updated_at = CASE WHEN 
                        stg.address_status.address_status <> EXCLUDED.address_status 

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.address_status.updated_at
                END;