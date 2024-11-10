select * 
from {{ source("dwh", "order_line") }}