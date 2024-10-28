INSERT INTO stg.order_status 
    (status_id,status_value) 

SELECT
    status_id,
    status_value
FROM pacbook.status_value

ON CONFLICT(status_id) 
DO UPDATE SET
    status_value = EXCLUDED.status_value,
    updated_at = CASE WHEN 
                        stg.order_status.status_value <> EXCLUDED.status_value 

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.order_status.updated_at
                END;