INSERT INTO stg.customer
    (customer_id,first_name,last_name,email)

SELECT 
customer_id,first_name,last_name,email 
FROM
    pacbook.customer

ON CONFLICT(customer_id) 
DO UPDATE SET
    fisrt_name = EXCLUDED.fisrt_name,
    last_name = EXCLUDED.last_name,
    email = EXCLUDED.email,
    updated_at = CASE WHEN 
                        stg.customer.first_name <> EXCLUDED.first_name
                        OR stg.customer.last_name <> EXCLUDED.last_name
                        OR stg.customer.email <> EXCLUDED.email
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.customer.updated_at
                END;