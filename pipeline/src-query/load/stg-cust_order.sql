INSERT INTO stg.cust_order 
    (order_id,order_date,customer_id,shipping_method_id,dest_address_id)

SELECT 
order_id,order_date,customer_id,shipping_method_id,dest_address_id, 
FROM
    pacbook.book

ON CONFLICT(order_id) 
DO UPDATE SET
    order_date = EXCLUDED.order_date,
    customer_id = EXCLUDED.customer_id,
    shipping_method_id = EXCLUDED.shipping_method_id,
    dest_address_id = EXCLUDED.dest_address_id,
    updated_at = CASE WHEN 
                        stg.cust_order.order_date <> EXCLUDED.order_date
                        OR stg.cust_order.customer_id <> EXCLUDED.customer_id
                        OR stg.cust_order.shipping_method_id <> EXCLUDED.shipping_method_id
                        OR stg.cust_order.dest_address_id <> EXCLUDED.dest_address_id
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.cust_order.updated_at
                END;