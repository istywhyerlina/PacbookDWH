select * 
from {{ source("dwh", "address_status") }}