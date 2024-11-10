select * 
from {{ source("dwh", "order_status") }}