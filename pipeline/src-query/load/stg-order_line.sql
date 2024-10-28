INSERT INTO stg.order_line
    (line_id,order_id,book_id,price)

SELECT 
line_id,order_id,book_id,price 
FROM
    pacbook.order_line

ON CONFLICT(line_id,order_id,book_id) 
DO UPDATE SET
    price = EXCLUDED.price,
    updated_at = CASE WHEN 
                        stg.order_line.price <> EXCLUDED.price
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.order_line.updated_at
                END;