INSERT INTO stg.customer_address
    (customer_id,address_id,status_id)

SELECT 
customer_id,address_id,status_id 
FROM
    pacbook.customer_address

ON CONFLICT(address_id) 
DO UPDATE SET
    status_id = EXCLUDED.status_id,
    customer_id = EXCLUDED.customer_id,
    updated_at = CASE WHEN 
                        stg.customer_address.status_id <> EXCLUDED.status_id
                        OR stg.customer_address.customer_id <> EXCLUDED.customer_id
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.customer_address.updated_at
                END;