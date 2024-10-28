INSERT INTO stg.order_history
    (history_id,order_id,status_id,status_date)

SELECT 
history_id,order_id,status_id,status_date 
FROM
    pacbook.order_line

ON CONFLICT(history_id) 
DO UPDATE SET
    order_id = EXCLUDED.order_id,
    status_id = EXCLUDED.status_id,
    status_date = EXCLUDED.status_date,
    updated_at = CASE WHEN 
                        stg.order_history.order_id <> EXCLUDED.order_id
                        OR stg.order_history.status_id <> EXCLUDED.status_id
                        OR stg.order_history.status_date <> EXCLUDED.status_date
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.order_history.updated_at
                END;