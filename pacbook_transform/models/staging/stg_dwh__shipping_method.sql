select * 
from {{ source("dwh", "shipping_method") }}