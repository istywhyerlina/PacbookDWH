INSERT INTO stg.shipping_method
    (method_id,method_name,cost)

SELECT 
method_id,method_name,cost 
FROM
    pacbook.shipping_method

ON CONFLICT(method_id) 
DO UPDATE SET
    cost = EXCLUDED.cost,
    method_name = EXCLUDED.method_name,
    updated_at = CASE WHEN 
                        stg.shipping_method.cost <> EXCLUDED.cost
                        OR stg.shipping_method.method_name <> EXCLUDED.method_name
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.shipping_method.updated_at
                END;