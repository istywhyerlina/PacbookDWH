select * 
from {{ source("dwh", "customer_address") }}