select * 
from {{ source("dwh", "publisher") }}