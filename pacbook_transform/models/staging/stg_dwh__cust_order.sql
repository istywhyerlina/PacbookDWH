select * 
from {{ source("dwh", "cust_order") }}