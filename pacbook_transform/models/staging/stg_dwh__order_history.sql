select * 
from {{ source("dwh", "order_history") }}