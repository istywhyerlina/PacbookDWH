select * 
from {{ source("dwh", "book") }}